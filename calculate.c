#include <stdio.h>
#include <stdlib.h>
#include "calculate.h"

/* Calculate a tax owed under a hypothetical tax plan.
 * For a household with minors, adults and an overall income
 * tax is computed as follows:
 * each minor gets a deduction in the amount of $18,000
 * each adult gets a deduction in the amount of $12,000
 *
 * if income is below the combined deductions of everyone in the
 * household, tax is zero
 *
 * if income is above the combined deductions of everyone in the
 * household, but less than 3 times the combined deductions, then tax
 * is 10% of the income above the combined deduction amount.
 *
 * if income is above 3 times the combined deductions, then tax is 10%
 * of 2 * the combined deductions, plus 15% of the amount above 3
 * times the combined deductions. 
 *
 * If minors and adults are both < 1, then tax is 0
 * If only minors < 0, then set minors to 0
 * If only adults < 0, then set adults to 0
 *
 * Write tests to achieve 100% code coverage using 
 *          gcov -abcfu calculate.c
 *
 */

int calculate(int income, int minors, int adults) {
  static int baseM = 18000;
  static int baseA = 12000;
  static int rate1 = 10;
  static int rate2 = 15;

  if (minors < 1 && adults < 1) { return 0; }
  if (minors < 0) { minors = 0; }
  if (adults < 0) { adults = 0; }
  
  int rate1Start = minors * baseM + adults * baseA;

  int rate2Start = 3 * rate1Start;

  int tax = 0;

  if (income < rate1Start) {
    tax = 0;
  }
  else if (!(income < rate1Start) && income < rate2Start) {
    tax = (income - rate1Start) * rate1 / 100;
  } 
  else if (income >= rate2Start) {
    tax = (rate2Start - rate1Start) * rate1 / 100;
    tax += (income - rate2Start) * rate2 / 100;
  }
  return tax;

}
