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

//@ requires size>=3;
void shellsort(int a[], const int size)
{
  int i=0,j=0,inc,tmp=0;
  inc = 3;
  //@ assert inc == 3;
  /*@ loop invariant inc >= 0 && inc <= 3;
    @ loop assigns j,inc,tmp,i;
    @ loop variant inc;
  */
  while (inc > 0)
  {
    /*@ loop invariant i >= 0 && i <= size;
      @ loop assigns i,j,inc,tmp;
      @ loop variant size-i;
    */
    for (i=0; i<size; i++)
    {
      j = i;
      tmp = a[i];
      //@ assert i >= 0;
      //@ assert j >= 0;
      /*@ loop invariant j >= 0;
        @ loop assigns j;
        @ loop variant j;
      */
      while ((j>=inc) && ( a[j-inc]>tmp ))
      {
        //@ assert j-inc >= 0;
        a [j] = a [j-inc] ;
        j = j - inc ;
      }
      a [j] = tmp ;
    }
    if(inc/2 != 0) {
      //@ assert inc >= 2;
      inc = inc / 2 ;
      //@ assert inc >= 1;
   } else if( inc == 1 ) {
      //@ assert inc == 1;
      inc = 0;
      //@ assert inc == 0;
    }
    /*
        ça sert à rien :D

        else {
          //@ assert inc != 0;
          inc = 1;
          //@ assert inc == 1;
        }
    */
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
