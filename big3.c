
#include <stdio.h>

void  biggest3() {
int a = 10, b = 22, c = 9;

if (a >= b && a >= c)
printf("%d is the largest number.\n", a);
else if (b >= a && b >= c)
printf("%d is the largest number.\n", b);
else
printf("%d is the largest number.\n", c);

//return 0;
}
