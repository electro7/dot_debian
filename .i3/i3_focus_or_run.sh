#!/bin/bash
#
# Ejecuta un programa o si existe, le da el focus
# Sintaxis:
#   -c -> Clase de la ventana a buscar
#   -t -> Titulo de la ventana a buscar

case "$3" in
  *terminal*)
    PROG=$(pgrep -cx "$4")
    ;;
  *)
    PROG=$(pgrep -cx "$3")
    ;;
esac

echo $PROG

case "$1" in
  -t)
    FIND="title"
    ;;
  -c)
    FIND="class"
    ;;
  *)
    echo "Falfa especificar el titulo (-t) o la clase de la ventana (-c)."
    exit 1
    ;;
esac

if [ "$PROG" -eq 0 ]; then
  echo "running..."
  i3-msg exec $3 $4 $5
else
  echo "focus..."
  i3-msg [$FIND="(?i)$2"] focus
fi
