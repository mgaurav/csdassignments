CC = \g++
CFLAGS = -W -Wall
COMMON = cache.cpp lruqueue.cpp address.cpp
NAIVE = expt-results/naive/
AWARE = expt-results/cacheaware/
OBLIVIOUS = expt-results/cacheoblivious/

all : naive aware oblivious

naive : naivematrixmultiplication.cpp $(COMMON)
	$(CC) -o $(NAIVE)a.out $^
	cd $(NAIVE); \
	python runexpt.py;

aware : cacheaware2.cpp $(COMMON)
	$(CC) -o $(AWARE)a.out $^ -lm
	cd $(AWARE); \
	python runexpt.py;

oblivious : cacheobliviousmatrixmultiplication.cpp $(COMMON)
	$(CC) -o $(OBLIVIOUS)a.out $^
	cd $(OBLIVIOUS); \
	python runexpt.py;
