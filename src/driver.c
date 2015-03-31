/*
 * driver.c - this program calls the assembly routines and
 * demonstrates how easy it is to interface with C!
 *
 * Author: Curtis Dyer
 * Class: CS-3
 *
 * Midterm
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <inttypes.h>

/* declaring our ASM functions */
uint64_t getnum(void);
uint64_t bitcount(uint64_t n);

int main(void)
{
	uint64_t num = getnum();
	printf("%" PRIu64 " bits ON in %" PRIu64 "\n", bitcount(num), num);

	return 0;
}

