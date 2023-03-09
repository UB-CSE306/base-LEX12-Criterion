OBJECTS = calculate.o 

# OS identification from: https://stackoverflow.com/questions/714100/os-detecting-makefile
OS := $(shell uname -s)

ifeq ($(OS), Darwin) 
  CUNIT_PATH_PREFIX = /usr/local/Cellar/cunit/2.1-3/
  CUNIT_DIRECTORY = cunit
endif
ifeq ($(OS), Linux) 
  CUNIT_PATH_PREFIX = /util/CUnit/
  CUNIT_DIRECTORY = CUnit/
endif

CC = gcc
FLAGS = -g -O0 -c -Wall -fprofile-arcs -ftest-coverage 


calculate.o: calculate.c
	$(CC) $(FLAGS) calculate.c

tests: $(OBJECTS) tests.c
	$(CC) -g -O0 -Wall -fprofile-arcs -ftest-coverage -L $(CUNIT_PATH_PREFIX)lib  -I $(CUNIT_PATH_PREFIX)include/$(CUNIT_DIRECTORY) $(OBJECTS) tests.c -o tests -lcunit -lgcov 

clean:
	rm -rf *~ *.o *.dSYM a.out runner tests *.xml *.gc??
