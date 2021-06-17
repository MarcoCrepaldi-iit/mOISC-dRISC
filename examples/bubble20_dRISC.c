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
  int a[20]; 
  a[0] = 20;
  a[1] = 19;
  a[2] = 18;
  a[3] = 17;
  a[4] = 16;
  a[5] = 15;
  a[6] = 14;
  a[7] = 13;
  a[8] = 12;
  a[9] = 11;
  a[10] = 10;
  a[11] = 9;
  a[12] = 8;
  a[13] = 7;
  a[14] = 6;
  a[15] = 5;
  a[16] = 4;
  a[17] = 3;
  a[18] = 2;
  a[19] = 1;
  //while(1)
    //{
      bubbleSort(a, 20);
      //*mOISC_chr = 0xFF;
      *mOISC_chr = 0xFF; //HALT
  //}
}


