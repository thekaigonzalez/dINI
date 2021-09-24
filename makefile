#makefile
SRC=iconf.d
FLAGS=-O
all:
	dmd $(SRC) $(FLAGS) -lib -oflibiconf.a

test:
	dmd test1.d $(FLAGS) libiconf.a -oftest1

install:
	cp iconf.d /usr/include/dlang/dmd/iconf.d
	cp libiconf.a /usr/lib/libiconf.a

pre:
	mkdir /usr/include/dlang/dmd/conf/

check:
	./tests/test1
	./tests/test2
	./tests/test3

gendoc:
	dmd -Dd./docs/api/ iconf.d 