#ifndef DRISCIO_H_   /* Include guard */
#define DRISCIO_H_

// CPU speeds for dRISC 816
#define mOISC_100MHz                                        192
#define mOISC_50MHz                                         128
#define mOISC_1MHz                                          64
#define mOISC_10kHz                                         0

// Boolean variables (only int16_t types are available and killed to 16 bit in dRISC)
#define true                                                1
#define false                                               0

// Overrides declaration
// FOR DEBUG PURPOSES ONLY
/*
void __setcsr(int16_t x);
void __seticr(int16_t x);
void __setidr(int16_t x);
void __setiwr(int16_t x);
void __setchr(int16_t x);
void __setior(int16_t x);
int16_t __getior(void);
int16_t __getisr(void);*/

// Compatibility w.r.t. x86 memcpy
void memcpy(void *dest, const void *src, int n);
#endif // FOO_H_
