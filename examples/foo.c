#include <mOISC.h>

#define MAX 10

void foo(int value)
{
      // IOR value is i
      *mOISC_ior = value;
}

int main()
{
  int data;
  // 100MHz CPU, all IOR pins are output 
  *mOISC_csr = mOISC_100MHz;
  *mOISC_idr = 0xFF;

  while (1) {

    for (int i = 0; i <= MAX; i++)
    {
      foo(i);
    }
  }
}
 
