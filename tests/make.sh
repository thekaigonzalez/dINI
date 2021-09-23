for f in ./test*.d; do dmd -O `basename $f` -L/usr/lib/libiconf.a; done
