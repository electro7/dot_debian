#!/usr/bin/perl
#Thanks to Kordian Witek for finding stupid bugs in my code and making loadsa
#suggestions which ended up improving the heuristics :)
#And also Patrik Grip-Jansson for find a bug and providing a fix
#This script is released under the GPL.
#It's written by James Maddison <jsm00@doc.ic.ac.uk>.

use File::Basename;
use File::Copy;
use File::Path;
use File::Find;
use Getopt::Std;
use Cwd;
#use strict;

#------------------------------sets options-----------------------------------#
push @INC,dirname($0);

my $version = "2.1.1";
my $date = "28th January 2002";
my $config_file = "$ENV{HOME}/.mp3moverrc";

#first off reading in masks from the configuration file if it is found
my %option;

my %gui_option;
## gui-options
## Ds = do not show directory information in main window for
## source mp3
## Dd = do not show directory information in main window for
## destination mp3

my ($FILEMASK,$DIRECTORYMASK,$ID3TITLEMASK);

if ( -r "$config_file" ) {
  &read_config_file(\%option,\%gui_option,$config_file,\$FILEMASK,\$DIRECTORYMASK,\$ID3TITLEMASK);
}

#setting default options if configuration file didn't specify them
$FILEMASK='%r - %a - %n - %t' unless ( $FILEMASK );
$DIRECTORYMASK='%r/%a/' unless ( $DIRECTORYMASK );
$ID3TITLEMASK='%n - %t' unless ( $ID3TITLEMASK );

getopts("a:c:hd:efgi:lm:pr:s:tuwxyACDI:M:RSTX",\%option);

( $option{"h"} ) && die (
"MP3 mover $version ($date)
Run in the directory containing the mp3s you want to sort out.
usage: mp3move.pl [options]

Options:
   -a <album>		set <album> as the album title, useful with -m option
   -c <title>		processes <title> instead of files, and only prints the
   			processed form of the title onto standard output
   -d <directory>       use this directory as the base directory for the audio
	  		files to be moved to (.. is default)
   -e	  		Exchanges the album title with the song title
   -f	  		Don't ask me before moving each audio file
   -g	  		Try to get information preferentially from the id3 tag
	  		(if it exists) rather than the filename.
   -h	  		print Help (this message) and exit
   -i <version>		write id3v<version> tag of mp3 based on filename. 
   -l	  		Convert audio file to all lower case
   -m '<pattern>'  	Only move audio files matching this pattern (* is 
	  		default and note the pattern must be enclosed in 's)
   -p	  		Run mp3mover in command line mode.
   -r <artist>		Sets artist to <artist>, useful with -m option
   -s '/<reg1>/<reg2>/' Substitution operator, substitutes occurence of <reg1>
	  		in audio files for <reg2> (note the 's).
   -t	  		Just print what mp3mover would do, don't move any files
   -u	  		Convert audio file to all upper case
   -w	  		Remove spaces. (equivalent to -s'/ //')
   -x	  		Try and fill in information missing from filename from 
	  		the ID3 tag
   -y	  		Try and fill in missing information from directory the
	  		mp3 is in (according to directory mask)
   -A	  		Do not create Acoustic or Live directories if either
	 		(Acoustic) or (Live) are found in the title of the mp3
   -C 	 		Do not remove trailing \"Comedy-\" and \"Parody-\"
   -D	  		Do not create directories/move files, just rename files
   -I <version>		Only write id3v<version> tags, don't rename/move files
   -M '<pattern>'  	Only move audio files not matching specified pattern
   -R	  		Search through directories recursively for audio files
   -S	  		Convert spaces to underscores (equivalent to -s'/ /_/')
   -T	  		Do not change \"The Artist\" to \"Artist, The\"
   -X	  		Print out information for each audio file even if 
	  		mp3mover thinks is already named correctly\n");

#----------------------options all figured out here----------------------------#

my ($sub1,$sub2);
if ( $option{"s"} ) {
  ( $sub1 = $option{"s"} ) =~ s#^/([^/]*)/.*/$#$1#;
  ( $sub2 = $option{"s"} ) =~ s#^/[^/]*/([^/]*)/$#$1#;
}

if ( $option{"c"} ) {
  $option{"D"} = 1;
  undef $option{"x"};
  &bring_it_on($option{"c"});
  die("$_\n");
}

my ($suffix,$presuffix);
if ( $option{"d"} ) { $suffix = $option{"d"}; } else { $suffix=".."; }

#converts relative paths to their absolute paths based on working directory
#script was run from
#put a / at the end if there isn't one
$suffix =~ s#([^/])$#$1/#;

unless ( $suffix =~ m#^/# ) {
  $presuffix = &cwd;

  while ( $suffix =~ m#(^|[^.])\./# ) {
	$suffix =~ s#(^|[^.])\./#$1#g;
  }
  
  while ( $suffix =~ m#^\.\./# ) {
	$suffix =~ s#^\.\./##;
	$presuffix =~ s#/[^/]*$##;
  }
  $suffix = "$presuffix/$suffix";
}

if ( $option{"I"} ) {
  ( $option{"i"} = $option{"I"} );
  $option{"D"} = 1;
}

undef $option{"i"} if ( $option{"t"} );

#checks if user has specified -i option without having the appropriate module
if ( $option{"i"} || $option{"g"} || $option{"x"} ) {
  eval { require MP3::Tag };
  if ( "$@" =~ m#^Can't locate MP3/Tag\.pm# ) {
	print "\nYou need the module MP3::Tag installed in order to use either certain options you have specified. These options will be disabled\n";
	undef $option{"i"};
	undef $option{"x"};
	undef $option{"g"};
  }
}

( -f $suffix || -e $suffix && ! -w $suffix ) && die ("Cannot write to base directory for mp3s\n") unless ( $option{"D"} || $option{"t"} );

my $match;
if ( $option{"m"} ) {
  $match = &correct_pattern( $option{"m"} ); 
} 
else { 
  $match='.*'; 
}

$option{"M"} = &correct_pattern( $option{"M"} ) if ( $option{"M"} );

undef $option{"x"} if $option{"g"};
#------------------------finished setting options----------------------------#

#---------------- some global variables -----------------#
my $index;
my $sourcefile;
my $bad_name;
my ($artist,$album,$title,$songnumber,$extension);
#--------------------------------------------------------#

unless ( $option{"p"} ) {
  eval { require Tk };
  if ( "$@" =~ m#^Can't locate Tk\.pm# ) {
	die "You need to install the module to use the graphical user interface. Please run mp3mover with the -p option to run in command line mode, or download Perl::Tk from cpan.perl.org\n"
  }
  require MP3::GuiMp3mover;
  &GuiMp3mover::gui(\%option,\%gui_option,\$date,\$version,
  \$FILEMASK,\$DIRECTORYMASK,\$ID3TITLEMASK,\$config_file);
}
else {
  &get_mp3s;
}

print "\n";

sub read_config_file($$$$$$) {
  my $opt_pointer = $_[0];
  my $gui_pointer = $_[1];
  my $option_file = $_[2];
  my $FILEMASK_p = $_[3];
  my $DIRECTORYMASK_p = $_[4];
  my $ID3TITLEMASK_p = $_[5];

  my $current_pointer = $opt_pointer;

  open(OPTIONS,"<$option_file");
  while ( <OPTIONS> ) {
	if ( /^\s*FILEMASK\s*=/ ) {
	  ( $$FILEMASK_p ) = $_ =~ m/(?:.*?)\s*=\s*'(.*)'\s*$/;
	}
	elsif ( /^\s*DIRECTORYMASK\s*=/ ) {
	  ( $$DIRECTORYMASK_p ) = $_ =~ m/(?:.*?)\s*=\s*'(.*)'\s*$/;
	  $$DIRECTORYMASK_p .= "/" unless $$DIRECTORYMASK_p =~ m#/$#;
	}
	elsif ( /^\s*ID3TITLEMASK\s*=/ ) {
	  ( $$ID3TITLEMASK_p ) = $_ =~ m/(?:.*?)\s*=\s*'(.*)'\s*$/;
	}
	elsif ( /\<gui_options\>/ ) {
	  $current_pointer = $gui_pointer;
	}
	elsif ( /\<options\>/ ) {
	  $current_pointer = $opt_pointer;
	}
	elsif ( /^\s*-\w+ *$/ ) {
	  s/^\s*-(\w+) *$/$current_pointer->{$1}=1/e;
	}
	elsif ( /^\s*-\w+ '.*'/ ) {
	  s/^\s*-(\w+) +'(.*)'/$current_pointer->{$1}=$2/e;
	}
  }
  close OPTIONS;
}  

sub get_mp3s {
  $index = 0;
  find(\&recurse,"./");
}

sub recurse {
  #recurse through directories sorting mp3s it finds
  ( print "\n" && return 1 ) if ( ! $option{"R"} && "$File::Find::name" =~ m#[^.]/# );
  if ( -f  && /$match/ && /\.(mp(2|3)|vqf|wma|wav)$/i ) {
	unless ( $option{"M"} && /$option{"M"}/ ) {
	  $sourcefile = $_;
	  if ( $option{"g"} && $sourcefile =~ /\.mp3$/i ) {
		($artist,$album,$title,$songnumber) = &read_id3("$sourcefile");
		if ( $artist || $album || $title || $songnumber ) {
		  $extension=".mp3";
		  &rejoin
		}
		else {
		  &bring_it_on("$_")
		}
	  }
	  else {
		&bring_it_on("$_")
	  }
	  &user_response("$_");
	}
  }
}

sub bring_it_on {
  $_ = $_[0];
  $_ = &perfect_name("$_");
  ($artist,$album,$title,$songnumber) = &splitup("$_");
  &rejoin;
}

sub correct_pattern {
  #converts an ls <pattern> style pattern into a regular expression
  $_ = join(" ",@_);
  s/(\?|\*)/\.$1/g;
  s/(\(|\)|\[|\]|\<|\>|\{|\})/\\$1/g;
  s/(\.[^*])/\\$1/g;
        $_ = "\^$_\$";
  return "$_";
}

sub mess {
  #switches - when it's not a delimter for different symbols so that they
  #won't confuse the script and may be replaced later by un_mess
  $_ = $_[0];
  s/( |\(|-)([0-3]?\d)(\.|-| )([0-3]?\d)(\.|-|\)| )(\d\d)/$1$2\%$4\%$6/; #dates
  s/matchbox\s20/matchbox\*20/g;
  s/x-rated/x\*rated/g; #from here on it's just certain words
  s/scott-rock/scott\*rock/g;
  s/re-entry/re\*entry/g;
  s/electro-shock/electro\*shock/g;
  s/3-speed/3\*speed/g;
  s/cut-throat/cut\*throat/g;
  return $_
}

sub un_mess {
  #unmesses stuff the program had to change because of words with - in
  $_ = $_[0];
  s/Matchbox\*20/Matchbox 20/gi;
  s/([0-3]?\d)\%([0-3]?\d)\%(\d\d)/$1-$2-$3/g;
  s/\*/-/g;
  return $_
}


sub perfect_name {
  #this subroutine removes most of the stupidness in naming the mp3
  $_ = $_[0];

  s/(\.\s*)+/\./g;
  ( $extension = $_ ) =~ s/.*(\.\w{3,4})/$1/;
  $extension = lc $extension;
  $_ =~ s/(.*)\.\w{3,4}/$1/;
  s/([a-z])([A-Z])/$1 $2/g unless ( /[^-]\s[^-]/ );
  $_ = lc;
  s/\.+$//g; #shouldn't be any dots before .mp3
  s/\s+$//g; #shouldn't be any spaces before .mp3
  s/{|\[|</\(/g; #change all left bracket types to (
  s/}|\]|>/\)/g; #change all right bracket types to )
  s/(%|_)20/ /g; #change _20 and %20 to spaces
  s/(%|_)28/(/g; #change _28 and %28 to (
  s/(%|_)29/)/g; #change _29 and %29 to )
  s/\(+/\(/g;
  s/\)+/\)/g; #only allows one bracket in a row
  s/(-+|\s+)(ksi|api|(sinned-)?ego)($|\s)/$3/gi; #mp3 gang advertising
  if ( /^([a-zA-Z-]+-[a-zA-Z-]+_)+[a-zA-Z-]+-[a-zA-Z-]+$/ && ! /\s-\s/ ) {
	s/-/ /g;
	s/_/-/g;
  }
  else {
	s/^([^_-]+)_([^_-]+)_(\d{1,2})_([^_-]+)$/$1-$2-$3-$4/;
	s/^([^_-]+)_(\d{1,2})_([^_-]+)_([^_-]+)$/$1-$3-$2-$4/;
	s/^(\d{1,2})_([^_-]+)_([^_-]+)_([^_-]+)$/$2-$3-$1-$4/;
	s/^([^_-]+)_([^_-]+)_([^_-]+)$/$1-$2-$3/ if ( /\s/ );
	s/_/-/g if ( /\s.+\s/ );
  }
  s/(\s|-)(\w+)_(\d{1,2})(\s|-)/$1$2-$3$4/;
  s/(\s|-)(\d{1,2})_(\w+)(\s|-)/$1$3-$2$4/;
  #these lines undo some of the really weird naming schemes i've
  #seen such as Band - 08_Album Title Title.mp2
  s/([a-z][a-zA-Z]+)-([a-z][a-zA-Z]+)-([a-z][A-Z]+)/$1 $2 $3/gi;
  s/@/at/g; #changes @ to at
  s/(\w)&/$1 &/g;
  s/&(\w)/& $1/g; #Radiohead&Drugstore to Radiohead & Drugstore
  s/&/and/g; #& to and
  s/,[^\d\s]/, $1/g; #comma should be followed by a space
  s/\s(don|can|couldn|wouldn|hasn|shouldn|isn)t\s/ $1\'t /g;
  s/\s(he|she)s\s/ $1\'s /g; #some people can't spell
  s/_/ /g; #_ to space
  s/([^\d\s_])-([^\d\s_])/$1\*$2/g if ( /\s-\s/ ); #double barrelled stuff
  s/(\w|\s)\(((\w|\s)+)(-|\s)+(\d\d)\)/$1-$2-$5-/; #Artist (Album 01) Title
  s/(\w|\s)\((\d\d)(-|\s)+((\w|\s)+)\)/$1-$4-$2-/; #Artist (01 Album) Title
  s/\((\d\d)\)/-$1-/g; #some people put the song number in brackets
  s/(\w)\(/$1 \(/g; #sorts out spacing before brackets
  s/\)(\w)/\) $1/g; #spacing after brackets
  s/\(\s/\(/g;
  s/\s\)/\)/g; #these two lines turn ( blah ) to (blah)
  s/\)\(/\) \(/g; #(blah)(something) to (blah) (something)
  s/^\((.*?)\)-?/$1-/; #(Artist) Album - Title.mp3
  s/\s?\(\d\)\./\./; #i've seen so many mp3s with this at the end,
  s/[^\d\s]\d\./$1\./; #changes Title1.mp3 into Title.mp3
  s/-live-/ \(live\) /g; #live should be in brackets.. not within -s
  s/\s+/ /g; #sorts out more than one space in a row
  s/-\s/-/g; #spacing after -s
  s/\s-/-/g; #spacing before -s
  s/-+/-/g; #sorts out more than one - in a row
  s/(\w)\s?\+\s?(\w)/$1 and $2/g;
  s/\slive$/ \(live\)/;
  s/^prank\sphone\scalls\s.*?-/prank phone call-/;
  s/^(comedy|parody)// unless ( $option{"C"} );
  s/([^-]+\s+cover)(\s+version)?-(.*)\$/$3 \($1\)/;
  #incorrectly named cover version mp3s 
  s/^([^-]*)\s\(?(feat(uring|\.)?|with|w|and)\s([^-]+?)\)?-(.*)$/$1-$5 \(featuring $4\)/;
  s/\((.*\s)?(feat\.?|with|w)\s(.*)\)$/\($1featuring $3\)/;
  #above two correct Artist1 Featuring Artist2
  s/\((.+)\)\s\((.+)\)$/\($1 $2\)/ while ( /\(.+\)\s\(.+\)$/ );
  #Title (Live) (Acoustic).mp3 -> Title (Live Acoustic).mp3
  s/(\s|-)\(?(\d?\d)(-|\.)(\d?\d)(-|\.)(\d\d)\)?$/ \(0$2-0$4-$6\)/;
  s/\(0?(\d\d)-0?(\d\d)-(\d\d)\)/\($1-$2-$3\)/;
  #above two line gives dates their correct format
  while ( /\([^)]*\([^)]*\)([^(]*[^)]|$)/ ) {
	s/\(([^)]*?)\s?\(([^)]*)\)/\($1 $2\)/g
  }
  #removes bad bracketing e.g. (Acoustic ) )
  s/\((.*)-(.*)\)/\($1 $2\)/g; #- within brackets must be removed
  $_ = &mess("$_");
  return $_
}

sub get_song_number {
  #tries to extract song number from what was passed to it for 
  #reinsertion later into correct place, and returns the song number
  #and the variable passed to it without the songnumber, if found

  $_ = $_[0];
  my $songnumber = $_[0];
  
  #case 1: song number placed nicely
  $songnumber =~ s/(.*)(^|-)0?([0-2]\d)( |-)(.*)/$3/;
  if ( $_ ne $songnumber ) {
	s/(.*)(^|-)0?([0-2]\d)( |-)(.*)/$1-$5/;
	s/^-//;
	return ($songnumber,$_)
  }
  
  #song number contains one digit (eg 1 not 01 etc.)
  $songnumber =~ s/(.*)(^|-)(\d)-(.*)/$3/;
  if ( $_ ne $songnumber ) {
	s/(.*)(^|-)\d-(.*)/$1-$3/;
	s/^-//;
	return ("0$songnumber",$_)
  }

  #next most desperate case, song number not preceded by start of
  #file or a -. this can mess up the song sometimes with bands
  #like Band 13, but is good in more cases than it is bad
  $songnumber =~ s/(.*) ([0-2]\d)-(.*)/$2/;
  if ( $_ ne $songnumber ) {
	s/(.*) ([0-2]\d)-/$1-/;
	return ($songnumber,$_)
  }

  return (undef,$_);
}

sub case_correct {
  #corrects case of whatever is passed to it
  $_ = $_[0];
  unless ( $option{"l"} || $option{"u"} ) {
	s/(^|\s|-|\(|\.)([a-z])/$1\U$2/g; #sorts out case (mostly)
	s/(^|\s|-|\(|\.)Mc(\w)/$1Mc\u$2/g; #scottish people eh
	s/ (Or|As|It|For|And|In|Of|The|At|A|To)( |-)/ \L$1\E$2/g; 
	#and the rest
	s/ (Or|As|It|For|And|In|Of|The|At|A|To)( |-)/ \L$1\E$2/g;
	#sometimes it messes up for a reason i don't know unless i do
	#this temporary solution until i work out what's going on	
	s/,\sthe/, The/g;
	s/(\w+)\s\(/\u$1 \(/g;
	s/T\.v\./TV/g; #TV shouldn't have dots between
	s/(^|\s|-|\()(Rsvp|KMFDM|Ny|Dj|Mc|Ok|Acdc|Usa|Afi|Nwa|Bsb|Zz|Mtv|Vast|Bbc|Tv)( |\.|-|\)|$)/$1\U$2\E$3/g;
	#some case exceptions
	s/\*([^\d\s])/\*\u$1/g; #double barrelled things again
	s/^R\s?e\s?m($|\s)/R\.E\.M\.$1/i; #that's how R.E.M. is written!
	s/^(The\s?)?Foo\s?fighters/Foo Fighters/i;
	s/^(The\s?)?Blood\s?hound\s?gang/Blood Hound Gang/i;
	s/^Pj Harvey/PJ Harvey/i;
	s/^Fenix\s?tx/FenixTX/i;
	s/Fivin[g']?\sMf/Fivin' MF/g; #cool Local H song
  }
  s/^(.*)$/\U$1/ if ( $option{"u"} );
  s/^(.*)$/\L$1/ if ( $option{"l"} );
  s/\s/_/g if ( $option{"S"} );
  s/\s//g if ( $option{"w"} );
  s/$sub1/$sub2/gi if ( $option{"s"} );
  return $_;
}

sub splitup {
  #sorts out which bit of the mp3 is the artst/album/title if each of
  #them exist
  $_ = $_[0];
  my ($artist,$album,$title,$songnumber);
  ($songnumber,$_) = &get_song_number("$_");

  my @title;
  ($artist,$album,@title) = split("-");
  $title = join(" ",@title);

  unless ( $title || $album ) {
	$title = $artist;
	undef $artist;
	$bad_name = 1 unless ( exists $option{"a"} || exists $option{"r"} || $option{"g"} || $option{"x"} );
  }

  unless ( $title ) {
	$title=$album;
	if ( $option{"a"} ) {
	  $album = $option{"a"};
	}
	elsif ( $option{"r"} ) {
	  $album = $artist;
	}
	else {
	  undef $album;
	}
  }
  else {
	if ( $option{"a"} ) {
	  $album = $option{"a"};
	}
	else {
	  $album =~ s/^\((.*)\)$/$1/; #in case the album is in brackets
	}
  }
	$artist = $option{"r"} if ( $option{"r"} );
	if ( $option{"x"} && $extension eq ".mp3" && ! $option{"g"} ) {
	  unless ( $artist && $album && $title && $songnumber ) {
		($idartist,$idalbum,$idtitle,$idsongnumber) = &read_id3("$sourcefile");
		$artist = $idartist unless ( $artist );
		$album = $idalbum unless ( $album );
		$title = $idtitle unless ( $title );
		$songnumber = $idsongnumber unless ( $songnumber );
	  }
	}

	$artist =~ s/^\((.*)\)$/$1/g;
	$artist =~ s/^The (.*)/$1, The/ unless ( $option{"T"} );
	#change "The Artist"  to "Artist, The"

	if ( $artist && ! $option{"r"} ) {
	  $artist = &un_mess("$artist");
	  $artist = &case_correct("$artist");
	}
	if ( $album && ! $option{"a"} ) {
	  $album = &un_mess("$album");
	  $album = &case_correct("$album");
	}
	$title = &un_mess("$title");
	$title = &case_correct("$title");

	return ($artist,$album,$title,$songnumber)
}

sub rejoin {
  
  if ( $option{"e"} && $album ) {
	my $temp = $title;
	$title = $album;
	$album = $temp
  }

  $_ = correct_mask($FILEMASK,$artist,$album,$songnumber,$title);	
  $_ .= "$extension" unless /\.\w{3,4}$/;
  $sourcename = $_;

  if ( $bad_name ) {
	undef $bad_name;
	unless ( $option{"D"} ) {
	  $_ = "$suffix/$_";
	  s#/+#/#g;
	  s#^./##;
	}
	return 0;
  }

  #some mp3s won't have album title/song number etc.

  unless ( $option{"D"} ) {
	$dest_path = correct_mask($DIRECTORYMASK,$artist,$album,$songnumber,$title);
	$dest_path = "$suffix$dest_path";
	$dest_path =~ s#/+#/#g; #two slashes in a row looks ugly
	$dest_path =~ s#^./##; #might as well remove ./ at start
	
	unless ( $option{"A"} ) {
	  $dest_path .= "Live/" if /\([^)]*Live[^)]*\)/;
	  $dest_path .= "Acoustic/" if /\([^)]*Acoustic[^)]*\)/;
	}
  }
  else {
	$dest_path = &cwd."/";
  }
  $_ = "$dest_path$_";
}

sub read_id3 ($) {
  require MP3::Tag;
  my $source = $_[0];
  my ($mp3,$id3);
  $mp3 = MP3::Tag->new($source);
  $mp3->getTags;
  if ( exists $mp3->{ID3v2} ) {
	$id3=$mp3->{ID3v2}
  }
  elsif ( exists $mp3->{ID3v1} ) {
	$id3=$mp3->{ID3v1}
  }
  else {
	return (undef,undef,undef,undef);
  }

	my($artist,$album,$title,$songnumber);
	$title = $id3->song;
	$album = $id3->album;
	$artist = $id3->artist;
	if ( $title eq "undef" ) { 
	  undef $title
	}
	else {
	  $title = &case_correct("$title");
	}
	if ( $album eq "undef" ) {
	  undef $album
	}
	else {
	  $album = &case_correct("$album")
	}
	if ( $artist eq "undef" ) {
	  undef $artist
	}
	else {
	  $artist = &case_correct("$artist")
	}
	if ( $title ) {
	  ( $songnumber = $title ) =~ s/^(\d\d)\s*-.*$/$1/;
	  unless ( $songnumber eq $title ) {
		$title =~ s/^\d\d\s*-\s*(.*)/$1/
	  }
	  else {
		if ( $artist ) {
		  ( $songnumber = $artist ) =~ s/^(\d\d)\s*-.*$/$1/;
		  unless ( $songnumber eq $artist ) {
			$artist =~ s/^\d\d\s*-\s*(.*)/$1/
		  }
		  else {
			undef $songnumber
		  }
		}
	  }
	}

	unless ( $artist && $album && $title && $songnumber || $option{"x"} ) {
	  ($fnartist,$fnalbum,$fntitle,$fnsongnumber) = &splitup(&perfect_name("$source"));
	  $artist = $fnartist unless ( $artist );
	  $album = $fnalbum unless ( $album );
	  $title = $fntitle unless ( $title );
	  $songnumber = $fnsongnumber unless ( $songnumber );
	}

	$bad_name = 1 unless ( $artist || $album || $option{"x"} );
	return ($artist,$album,$title,$songnumber)
}

sub id3tag ($$$$$) {
  my $sourcefile = $_[0];
  my $artist = $_[1];
  my $album = $_[2];
  my $songnumber = $_[3];
  my $title = $_[4];
  my $ID3TITLEMASK = $_[5];
  
  #this subroutine is responsible for writing the id3 tag to the mp3
  #using the module MP3::Tag
  require MP3::Tag;
  my $mp3 = MP3::Tag->new($sourcefile);
  $mp3->getTags;

  my $id3_title = &correct_mask($ID3TITLEMASK,$artist,$album,$songnumber,$title);

  if ( $option{"i"} == 1 ) {
	if ( exists $mp3->{ID3v2} ) {
	  $mp3->{ID3v2}->remove_tag;
	}
	$mp3->newTag(ID3v1) unless ( exists $mp3->{ID3v1} );
	my $id3v1 = $mp3->{ID3v1};
	$id3v1->artist($artist) if ( $artist );
	$id3v1->album($album) if ( $album );
	$id3v1->song($id3_title);
	$id3v1->writeTag;
	$mp3->close;
  }
  elsif ( $option{"i"} == 2 ) {

	if ( exists $mp3->{ID3v1} ) {
	  $mp3->{ID3v1}->removeTag();
	}
	unless ( exists $mp3->{ID3v2} ) {
	  $mp3->newTag(ID3v2);
	}
	my $id3v2 = $mp3->{ID3v2};
	unless ( $id3v2->getFrame(TPE2) eq ("undef","undef") ) {
	  $id3v2->remove_frame(TPE2);
	}
	unless ( $id3v2->song eq "undef" ) {
	  $id3v2->change_frame(TIT2,$id3_title);
	}
	else {
	  $id3v2->add_frame(TIT2,$id3_title);
	}
	if ( $artist ) {
	  unless ( $id3v2->artist eq "undef" ) {
		$id3v2->change_frame(TPE1,$artist);
	  }
	  else {
		$id3v2->add_frame(TPE1,$artist);
	  }
	}
	if ( $album ) {
	  unless ( $id3v2->album eq "undef" ) {
		$id3v2->change_frame(TALB,$album);
	  }
	  else {
		$id3v2->add_frame(TALB,$album);
	  }
	}
	$id3v2->write_tag;
	$mp3->close	
  }
}

sub check_id3 {
  #will return true if the id3 doesn't need changing, so that the user
  #won't be asked in this case if also using the -D option and the
  #filename is unchanged.
  require MP3::Tag;

  $id3_title = &correct_mask($ID3TITLEMASK,$artist,$album,$songnumber,$title);

  $mp3 = MP3::Tag->new($sourcefile);
  $mp3->getTags;

  my $id3;

  if ( $option{"i"} == 1 ) {
	return 0 unless ( exists $mp3->{ID3v1} );
	$id3 = $mp3->{ID3v1};
	my $temptitle = $id3->song;
	return 0 unless ( $temptitle eq $id3_title || 
	length $temptitle == 30 && $id3_title =~ /^$temptitle/ );
  }
  elsif ( $option{"i"} == 2 ) {
	return 0 unless ( exists $mp3->{ID3v2} );
	$id3 = $mp3->{ID3v2};
	return 0 unless ( $id3->song eq $id3_title );
  }
  
  if ( $artist ) {
	 return 0 unless ( $id3->artist eq $artist );
  }
  if ( $album ) {
	return 0 unless ( $id3->album eq $album );
  }
  return 1;
}

sub correct_mask($$$$$) {
  #corrects a filemask by substituting the appropriate variable values
  my $mask = $_[0];
  my $artist = $_[1];
  my $album = $_[2];
  my $songnumber = $_[3];
  my $title = $_[4];

  if ( $artist ) {
	$mask =~ s/\%r/$artist/g;
	$mask =~ s/\%ur/\U$artist/g;
	$mask =~ s/\%lr/\L$artist/g;
	if ( $mask =~ /\%fr/ ) {
	  ( $smartist = $artist ) =~ s/^(.).*/$1/;
	  $mask =~ s/\%fr/$smartist/g;
	}
  }
  else {
	$mask =~ s/\(?\%[flu]?r[^%]*(\%|$)/$1/;
  }
  if ( $album ) {
	$mask =~ s/\%a/$album/g;
	$mask =~ s/\%ua/\U$album/g;
	$mask =~ s/\%la/\L$album/g;
  }
  else {
	$mask =~ s/\(?\%[lu]?a[^%]*(\%|$)/$1/;
  }
  if ( $songnumber ) {
	$mask =~ s/\%n/$songnumber/g;
  }
  else {
	$mask =~ s/\(?\%n[^%]*(\%|$)/$1/;
  }
  if ( $title ) {
	$mask =~ s/\%t/$title/g;
	$mask =~ s/\%ut/\U$title/g;
	$mask =~ s/\%lt/\L$title/g;
  }
  else {
	$mask =~ s/\(?\%[lu]?t[^%]*(\%|$)/$1/;
  }
  return $mask
}

sub user_response($) {
  $_ = $_[0];
  $sourcefile = &cwd."/$sourcefile";

  my $nochange;

  if ( ( $sourcefile eq $_  ) && 
  ( ! $option{"i"} || $option{"i"} && &check_id3 ) ||
  $option{"I"} && &check_id3 ) {
	$nochange = 1
  }
  else {
	$nochange = 0
  }

  next if ( $nochange && ! $option{"X"} );

  unless ( $option{"p"} ) {
	$index ++;
	$GuiMp3mover::index ++;
	$GuiMp3mover::mp3[$index]->{artist} = $artist;
	$GuiMp3mover::mp3[$index]->{album} = $album;
	$GuiMp3mover::mp3[$index]->{title} = $title;
	$GuiMp3mover::mp3[$index]->{songnumber} = $songnumber;
	$GuiMp3mover::mp3[$index]->{dest} = $_;
	$GuiMp3mover::mp3[$index]->{source} = $sourcefile;
	( $GuiMp3mover::mp3[$index]->{sourcename} = $sourcefile ) =~ s#.*/(.*)$#$1#;
	( $GuiMp3mover::mp3[$index]->{sourcedir} = $sourcefile ) =~ s#(.*/).*?$#$1#;
	$GuiMp3mover::mp3[$index]->{move} = 1;
	( $GuiMp3mover::mp3[$index]->{newname} = $_ ) =~ s#.*/(.*)$#$1#;
	( $GuiMp3mover::mp3[$index]->{newdir} = $_ ) =~ s#(.*/).*?$#$1#;
  }

  else {
	print "\n";
	print "$sourcefile";
	if ( $nochange ) {
	  print "\nNo Change\n" ;
	  return 1;
	}
	else {
	  print " -->\n$_ ";
	}

	if ( $option{"t"} ) {
	  print "\n";
	  return 1;
	}
  
	if ( ( $option{"f"} && print "\n" ) || &sure ) {
	  &id3tag($sourcefile,$artist,$album,$songnumber,$title,$ID3TITLEMASK) if ( $option{"i"} );
	  if ( ! $option{"D"} || ! $option{"I"} && $dest_path ) {
		unless ( $bad_name ) { 
		  mkpath("$dest_path")
		} 
		else {
		  $bad_name = 0
		}
	  }
	  unless ( $option{"I"} ) {
		if ( -f $_ ) {
		  rename("$sourcefile","$_"."temp") ||
		  print "Failed to move file\n";
		  rename("$_"."temp",$_);
		}
		else {
		  rename("$sourcefile","$_") || 
		  print "Failed to move file\n";
		}
	  }
	}
  }
}

sub sure { 
  print "[y/N] ";
  my $answer = <STDIN>;
  if ( $answer =~ /^y(es)?$/ ) {
	return 1
  }
  else {
	return 0
  }
}

sub write_options ($$$$$$) {

  my $opt_pointer = $_[0];
  my $gui_pointer = $_[1];
  my $config_file = $_[2];
  my $FILEMASK_p = $_[3];
  my $DIRECTORYMASK_p = $_[4];
  my $ID3TITLEMASK_p = $_[5];
  
  open (CONFIG,">$config_file");
  print CONFIG "ID3TITLEMASK=\'$$ID3TITLEMASK_p\'","\n" unless ($$ID3TITLEMASK_p eq '%n - %t');
  print CONFIG "DIRECTORYMASK=\'$$DIRECTORYMASK_p\'","\n" unless ($$DIRECTORYMASK_p eq '%r/%a/');
  print CONFIG "FILEMASK=\'$$FILEMASK_p\'","\n" unless ($$FILEMASK_p eq '%r - %a - %n - %t');
  

  print CONFIG "<options>\n";
  &save_hash($opt_pointer,\*CONFIG);
  print CONFIG "</options>\n";
  print CONFIG "<gui_options>\n";
  &save_hash($gui_pointer,\*CONFIG);
  print CONFIG "</gui_options>\n";
  
  close CONFIG;
}

sub save_hash ($$) {
  my $opt_pointer = $_[0];
  local *CONFIG = $_[1];

  my $key;
  
  foreach $key (keys %$opt_pointer) {
  
  	next if ( $opt_pointer->{$key} == 0 );
	
	if ( $opt_pointer->{$key} == 1 && $key ne "i" ) {
	  print CONFIG "-$key\n"
	}
	else {
	  print CONFIG "-$key \'$opt_pointer->{$key}\'\n"
	}
  }
}	
