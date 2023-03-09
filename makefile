# OS identification from: https://stackoverflow.com/questions/714100/os-detecting-makefile
OS := $(shell uname -s)

ifeq ($(OS), Darwin) 
  INCLUDE_PATH := /opt/homebrew/Cellar/criterion/2.4.1_1/include
  LIB_PATH := /opt/homebrew/Cellar/criterion/2.4.1_1/lib
  CC = gcc-12
endif
ifeq ($(OS), Linux) 
  INCLUDE_PATH := /util/criterion/include
  LIB_PATH := /util/criterion/lib/x86_64-linux-gnu
  CC = gcc
endif

FLAGS = -ggdb -O0 -c -Wall -fprofile-arcs -ftest-coverage 
OBJECTS = calculate.o tests.o


calculate.o: calculate.h calculate.c
	$(CC) $(FLAGS) calculate.c

tests.o: calculate.h tests.c 
	$(CC) -c $(CFLAGS) -I $(INCLUDE_PATH) tests.c

tests:  calculate.o tests.o
	$(CC) $(CFLAGS) -L $(LIB_PATH) -I $(INCLUDE_PATH) -o tests $(OBJECTS) -lcriterion -lgcov


.PHONY: clean
clean:
	rm -rf *~ $(OBJECTS) *.dSYM tests *.gc??
