#include "mOISC.h"

// Function overrides (automatically substituted by dc.py)
// FOR DEBUG PURPOSES ONLY
/*
void __setcsr(int x) { return; }
void __seticr(int x) { return; }
void __setidr(int x) { return; }
void __setiwr(int x) { return; }
void __setchr(int x) { return; }
void __setior(int x) { return; }
int __getior(void) { return 0; }
int __getisr(void) { return 0; }*/

#define IOR_ADDR 0x07
#define IDR_ADDR 0x06
#define ISR_ADDR 0x05
#define CSR_ADDR 0x04
#define ICR_ADDR 0x03
#define IWR_ADDR 0x02
#define CHR_ADDR 0x01
#define MCR_ADDR 0x00

volatile int *mOISC_ior = (volatile int *)IOR_ADDR;
volatile int *mOISC_idr = (volatile int *)IDR_ADDR;
volatile int *mOISC_isr = (volatile int *)ISR_ADDR;
volatile int *mOISC_csr = (volatile int *)CSR_ADDR;
volatile int *mOISC_icr = (volatile int *)ICR_ADDR;
volatile int *mOISC_iwr = (volatile int *)IWR_ADDR;
volatile int *mOISC_chr = (volatile int *)CHR_ADDR;
volatile int *mOISC_mcr = (volatile int *)MCR_ADDR;

// Compatibility for x86 archs
void memcpy(void *dest, const void *src, int n)
{ 
   // Typecast src and dest addresses to (int *), char * is not supported completely
   int *csrc = (int *)src; 
   int *cdest = (int *)dest;    

   // Copy contents of src[] to dest[] 
   for (int i=0; i<n; i++) 
       cdest[i] = csrc[i]; 
} 

