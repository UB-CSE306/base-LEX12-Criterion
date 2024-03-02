# OS identification from: https://stackoverflow.com/questions/714100/os-detecting-makefile
OS := $(shell uname -s)

ifeq ($(OS), Darwin) 
  INCLUDE_PATH := /opt/homebrew/include
  LIB_PATH := /opt/homebrew/lib
endif
ifeq ($(OS), Linux) 
  INCLUDE_PATH := /util/criterion/include
  LIB_PATH := /util/criterion/lib/x86_64-linux-gnu
endif

CC := gcc
CFLAGS = -ggdb -O0 -c -Wall -fprofile-arcs -ftest-coverage 

OBJECTS = calculate.o tests.o

tests:  calculate.o tests.o
	$(CC) -L $(LIB_PATH) -I $(INCLUDE_PATH) -o tests $(OBJECTS) -lcriterion -lgcov

calculate.o: calculate.h calculate.c
	$(CC) $(CFLAGS) calculate.c

tests.o: calculate.h tests.c 
	$(CC) -c $(CFLAGS) -I $(INCLUDE_PATH) tests.c


.PHONY: clean
clean:
	rm -rf *~ $(OBJECTS) *.dSYM tests *.gc??
