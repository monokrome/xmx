CC=coffee
OUT=lib/xmx
IN=src/

all: lib/xmx
	${CC} -o ${OUT} -c ${IN}

lib/xmx:
	mkdir -p "${OUT}"

