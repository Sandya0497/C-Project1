#include <stdio.h>

void factorial() {
int n, i;
unsigned long long fact = 1; // Factorial can be very large, so we use unsigned long long

printf("Enter an integer: ");
scanf("%d", &n);

if (n < 0)
printf("Error! Factorial of a negative number doesn't exist.");
else {
for (i = 1; i <= n; ++i) {
fact *= i;
}
printf("Factorial of %d = %llu", n, fact);
}

//return 0;
}
