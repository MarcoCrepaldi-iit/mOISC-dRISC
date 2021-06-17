#ifndef MAX30205_h
#define MAX30205_h


#define REG_TEMPERATURE 0x00
#define REG_CONFIGURATION 0x01
#define REG_THYST 0x02
#define REG_TOS 0x03
// 0x48
#define ADDR_DEV 0x48
#define CFG_SHUTDOWN_OR 0x01
#define CFG_WAKEUP_AND 0xFE
#define CFG_COMPARATOR_AND 0xFD
#define CFG_INTERRUPT_OR 0x02
#define CFG_POLARITY_LOW_AND 0x0B
#define CFG_POLARITY_HIGH_OR 0x04
#define CFG_MODE_LOW_AND 0xDF
#define CFG_MODE_HIGH_OR 0x20
#define CFG_QUEUE_MASK 0xE7
#define CFG_TIMEOUT_DISABLE_AND 0xBF
#define CFG_TIMEOUT_ENABLE_OR 0x30
#define CFG_ONE_SHOT_ENABLE_OR 0x40
#define CFG_ONE_SHOT_DISABLE_AND 0x7F
#define _THR_TEMP_DEFAULT 37.5
#define _THR_HYST_DETAULT 37.0

#define ipart_THR_T int(_THR_TEMP_DEFAULT)
#define fract_THR_T _THR_TEMP_DEFAULT-ipart_THR_T
#define fcode_THR_T int(fract_THR_T << 7)
#define icode_THR_T ipart_THR_T << 8

#define ipart_THR_H int(_THR_HYST_DEFAULT)
#define fract_THR_H _THR_HYST_DEFAULT-ipart_THR_H
#define fcode_THR_H int(fract_THR_H << 7)
#define icode_THR_H ipart_THR_H << 8
#endif
