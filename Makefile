HOME = $(shell cd; pwd)
CONDA = $(HOME)/anaconda2
CFLAGS = -Ibitshuffle
OBJS = pybitshuffle.o bitshuffle/bitshuffle.o bitshuffle/bitshuffle_core.o bitshuffle/iochain.o

all: pybitshuffle.so

# Python wrapper
pybitshuffle.so: $(OBJS)
	$(CC) -std=c99 -fPIC -o $@ -shared $^ $$(pkg-config --libs python) $$(pkg-config --libs liblz4)

%.o: %.c
	$(CC) -std=c99 -fPIC -c $^ -o $@ $$(pkg-config --cflags python) $$(pkg-config --cflags liblz4) $(CFLAGS)

l4_terminus: CFLAGS += -I$(CONDA)/include/python2.7
l4_terminus: $(OBJS)
	$(CC) -std=c99 -fPIC -o pybitshuffle.so -shared $^ $$(pkg-config --libs python) $$(pkg-config --libs liblz4) -L$(CONDA)/lib

clean:
	rm -f bitshuffle/*.o
	rm -f *.so *.o
