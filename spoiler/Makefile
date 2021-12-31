CFLAGS	= -Os

all: build

build: ag ag-c89

clean:
	-rm ag ag-c89 *.out

# Original K&R version.
ag$E: ag.c
	${CC} ${CFLAGS} ag.c -o $*

ag-c89$E: ag-c89.c
	${CC} ${CFLAGS} ag-c89.c -o $*

test: ag$E
	${MAKE} -f test.mk PRG=./ag >ag.out 2>&1

test-c89: ag-c89$E
	${MAKE} -f test.mk PRG=./ag-c89 >ag-c89.out 2>&1

# Make sure the old and revised versions behave the same.
test-compare: build test test-c89
	sed -e 's/-c89//' ag-c89.out | diff -u ag.out -
	rm *.out

