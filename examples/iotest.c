#include <mOISC.h>

// This routine emulates CPU delay
// It is a cycle that does nothing
void sleep(int cycle)
{
	int count;
  	for (count = 1; count <= cycle; count++)
  	{
		
	}	
}

int multiply(int b, int q)
{
	int a = 0;
	int n = 16;
	while (n != 0)
	{
		if ((q & 0x1) == 1) {
			a = a + b;
		}
		b = b << 1;
		q = q >> 1;
		n = n - 1;
	}
	return a;
}

int main()
{
  *mOISC_csr = 192;
  int sleeps, number;
  int cpu_speed = 0;
  int test_overlowr, opo0, opo1;
  opo0 = 2500;
  opo1 = 32767;
  test_overlowr = opo0 + opo1;
  sleeps = 81;
  sleeps = multiply(sleeps, 5);
  *mOISC_idr = 0xff;
  *mOISC_ior = sleeps;
  number = 0;
  *mOISC_idr = 0xCF;
  *mOISC_icr = 0x10;
  *mOISC_csr = 0;
  while(1)
  	{
  	*mOISC_ior = number;
  	if ((cpu_speed > 64) && (cpu_speed <= 192))  {
	sleep(sleeps);		
	}
	test_overlowr = opo0 + opo1;
	if (number == 16) {
		number = 0;
		cpu_speed += 64;
		if (cpu_speed >= 256) {
			cpu_speed = 0;
		}
		*mOISC_csr = cpu_speed;
	}
	else if (number == 6) {
		if ((*mOISC_ior & 0x20) == 0x00) {
		*mOISC_iwr = 0x10;
	}
	}
  	number++;
	}
}
