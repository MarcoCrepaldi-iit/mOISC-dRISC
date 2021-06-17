#include <mOISC.h>

void swap(int *xp, int *yp) 
{ 
    int temp = *xp; 
    *xp = *yp; 
    *yp = temp; 
} 
  
// A function to implement bubble sort 
void bubbleSort(int *arr, int n) //, int n) 
{ 
   int i, j; 
   for (i = 0; i < n-1; i++)       
  
       // Last i elements are already in place    
       for (j = 0; j < n-i-1; j++)  
           if (arr[j] > arr[j+1]) 
              swap(&arr[j], &arr[j+1]); 
} 

int main()
{

  *mOISC_csr = 192;
  //*mOISC_idr = 0xff;
  int a[10]; 
  a[0] = 10;
  a[1] = 9;
  a[2] = 8;
  a[3] = 7;
  a[4] = 6;
  a[5] = 5;
  a[6] = 4;
  a[7] = 3;
  a[8] = 2;
  a[9] = 1;
  //while(1)
    //{
      bubbleSort(a, 10);
      //*mOISC_chr = 0xFF;
      *mOISC_chr = 0xFF; //HALT
  //}
}


