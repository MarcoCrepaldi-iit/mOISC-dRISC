#ifndef DRISCIO_H_   /* Include guard */
#define DRISCIO_H_

// CPU speeds for dRISC 816
#define mOISC_100MHz                                        192
#define mOISC_50MHz                                         128
#define mOISC_1MHz                                          64
#define mOISC_10kHz                                         0

// Boolean variables (only int types are available and these are killed to 16 bit in dRISC)
#define true                                                1
#define false                                               0

// Overrides declaration
// FOR DEBUG PURPOSES ONLY
/*
void __setcsr(int x);
void __seticr(int x);
void __setidr(int x);
void __setiwr(int x);
void __setchr(int x);
void __setior(int x);
int __getior(void);
int __getisr(void);*/

// Compatibility w.r.t. x86 memcpy
void memcpy(void *dest, const void *src, int n);
#endif 
