#!/bin/bash
#
# Ejecuta un programa o si existe, le da el focus
# Sintaxis:
#   -c -> Clase de la ventana a buscar
#   -t -> Titulo de la ventana a buscar

case "$3" in
  *terminal*)
    PROG=$(ps -ef | grep -v grep | grep -v $0 | grep "$4")
    ;;
  *)
    PROG=$(ps -ef | grep -v grep | grep -v $0 | grep "$3")
    ;;
esac

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

if [ -z "$PROG" ]; then
  i3-msg exec $3 $4 $5
else
  i3-msg [$FIND="(?i)$2"] focus
fi
