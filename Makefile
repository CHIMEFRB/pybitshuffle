all: pybitshuffle.so

# Python wrapper
pybitshuffle.so: pybitshuffle.o bitshuffle/bitshuffle.o bitshuffle/bitshuffle_core.o bitshuffle/iochain.o
	$(CC) -std=c99 -fPIC -o $@ -shared $^ $$(pkg-config --libs python) $$(pkg-config --libs liblz4)

%.o: %.c
	$(CC) -std=c99 -fPIC -c $^ -o $@ $$(pkg-config --cflags python) $$(pkg-config --cflags liblz4) -Ibitshuffle

clean:
	rm bitshuffle/*.o
	rm *.so *.o
