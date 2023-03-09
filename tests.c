#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include "CUnit.h"
#include "Automated.h"
#include "calculate.h"


/* Runs a test input that *should* pass and produce an int result
 */
void test01(void) {
  int expected = 100;
  int actual = calculate(13000,0,1);
  CU_ASSERT_EQUAL( expected , actual );
}

/* The main() function for setting up and running the tests.
 * Returns a CUE_SUCCESS on successful running, another
 * CUnit error code on failure.
 */
int main()
{
   CU_pSuite Suite = NULL;

   /* initialize the CUnit test registry */
   if (CUE_SUCCESS != CU_initialize_registry()) { return CU_get_error(); }

   /* add a suite to the registry */
   Suite = CU_add_suite("Suite_of_tests_with_valid_inputs", NULL, NULL);
   if (NULL == Suite) {
      CU_cleanup_registry();
      return CU_get_error();
   }

   /* add the tests to Suite */
   if (
          (NULL == CU_add_test(Suite, "13000/0/1", test01))
      )
   {
      CU_cleanup_registry();
      return CU_get_error();
   }

   /* Run all tests using automated interface, with output to 'test-Results.xml' */
   CU_set_output_filename("test");
   CU_automated_run_tests();

   CU_cleanup_registry();
   return CU_get_error();
}
