#include <criterion/criterion.h>
#include "calculate.h"


void runtest(int income, int minors, int adults, int expected) {
    int actual = calculate(income, minors, adults);
    cr_assert_eq(actual, expected, "calculate(%d,%d,%d) should be %d, but was %d.\n", income, minors, adults, expected, actual);
}


// Tests
Test(lex12, test01) { runtest(13000, 0, 1, 100); }
