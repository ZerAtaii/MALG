#include <stdio.h>



int main()
{
  unsigned int n=0,reverse=0 ,temp=0;
  printf("Enter a number to check if it is a palindrome or not\n ");
  scanf("%u ",&n);
  //@ assert n >= 0;
  //@ assert reverse == 0;
  //@ assert temp == 0;
  temp = n ;
  //@ loop invariant temp >= 0;
  //@ loop assigns reverse,temp;
  //@ loop variant temp; 
  while ( temp != 0 )
  {
    reverse = reverse * 10;
    reverse = reverse + temp%10;
    temp = temp /10;
  }
  if ( n == reverse )
    //@ assert n == reverse;
    printf("%d is a palindrome number.\n",n);
  else
    //@ assert n != reverse;
    printf("%d is not a palindrome number.\n ",n);
  return 0;
}
