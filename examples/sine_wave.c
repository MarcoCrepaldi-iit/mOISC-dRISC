#include <mOISC.h>

const int sine[64] = {127, 140, 152, 165, 177, 188, 199, 209, 218, 227, 234, 241, 246, 250, 253, 254, 254, 253, 251, 248, 243, 237, 230, 222, 213, 203, 193, 181, 170, 158, 145, 132, 120, 107, 94, 82, 71, 59, 49, 39, 31, 23, 16, 10, 6, 2, 0, 0, 0, 2, 5, 9, 14, 21, 28, 37, 47, 57, 68, 79, 91, 104, 116, 129};
int direction = 0;

int sleep(int cycle, int override)
{
  //*mOISC_ior = override;
  int count;
    for (count = 1; count <= cycle; count++)
    {
    
  } 
  if (override > 128) {direction = 1;}
  if (override < 0) {direction = 0;}
  if (direction == 1) override--;
  else override++;
  return override;
}

int main()
{

  *mOISC_csr = 192;
  *mOISC_idr = 0xff;
  int i = 0;
  int tmp = 0;
  int data;
  while(1)
  	{
      *mOISC_ior = sine[i];
      i++;
      tmp = sleep(tmp, tmp);
      i = i & 0x3F;
	}
}
