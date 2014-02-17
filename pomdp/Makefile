CC=g++
CFLAGS= -Wall -Werror -Wextra -Wno-unused-parameter -g

all: pomdp
pomdp: pomdp.o pomdp_test.o
	$(CC) $(CFLAGS) -o pomdp pomdp.o pomdp_test.o
pomdp_test.o: pomdp_test.cpp pomdp.o
	$(CC) $(CFLAGS) -c pomdp_test.cpp
pomdp.o: pomdp.cpp
	$(CC) $(CFLAGS) -c pomdp.cpp

clean:
	rm -rf pomdp.o pomdp_test.o pomdp
