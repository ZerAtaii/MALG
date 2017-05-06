#include<stdio.h>
#include<stdlib.h>
#define SIZE 8

void display(int a[], const int size);
void shellsort( int a[], const int size);


int main ()
{
  int a[SIZE] ={5,6,3,1,7,8,2,4};
  printf("−−− C Shell Sort Demonstration −−− \n ");
  printf(" Array before sorting :\n");
  display(a,SIZE);
  shellsort(a,SIZE);
  printf(" Array after sorting :\n");
  display(a,SIZE);
  return 0;
}

//@ requires size>=0;
void shellsort(int a[], const int size)
{
  int i=0,j=0,inc,tmp=0;
  inc = 3;
  //@ assert inc == 3;
  //@ loop invariant inc >= 0;
  //@ loop assigns j,inc,tmp;
  //@ loop variant inc;
  while (inc > 0)
  {
    //@ loop invariant i >= 0;
    //@ loop assigns j,inc,tmp;
    //@ loop variant size-i;
    for (i=0; i<size; i++)
    {
      j = i;
      tmp = a[i];
      //@ assert j-inc >= 0;
      //@ loop assigns j,inc;
      //@ loop variant j-inc;
      while ((j>=inc) && ( a[j-inc]>tmp ))
      {
        //@ assert j-inc < size;
        a [j] = a [j-inc] ;
        j = j - inc ;
      }
      a [j] = tmp ;
    }
    if(inc/2 != 0)
      inc = inc / 2 ;
    else if( inc == 1 )
    //@ assert inc == 1;
      inc = 0;
    else
    //@ assert inc == 0;
      inc = 1;
  }
}

//@ requires size>=0;
void display( int a[], const int size)
{
  int i;
  //@ loop variant size-i;
  for ( i = 0; i < size; i++)
    printf("%d", a [i]);
  printf("\n");
}
