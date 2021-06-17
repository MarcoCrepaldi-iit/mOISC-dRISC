/*
dRISC 816 demonstration program with spi and i2c

reads data from a MAX30205 evaluation board and send
it using an RFM95 LoRa chip in broadcast

I2C on pins IOR[7-6], SCL SDA
LED pin on IOR[5]
RESET pin of RFM95 on IOR[4]
SPI on pins IOR[3-0], CS MISO CLK and MOSI

For compilation: stack pointer must be >= 32190 and < 32700 or so (it depends on function calls parameters)

*/
#include <mOISC.h>
#include "RH_RF95.h"
#include "MAX30205.h"
#define mOISC_SPI_EDGE 1

#define SLAVE_NOK 1
#define REG_NOK 2
#define WRITE_NOK 3
#define OK 0

#define ACK_RECEIVED 1
#define FROM  1
#define TO  0
#define BROADCAST_ADDR 0xff
#define ID  0
#define FLAGS  0

#define RH_SPI_WRITE_MASK 0x80

#define ASCII_READABLE 32

int current_idr = 0xC0;

void delay(int cycle)
{
	int count;
  	for (count = 1; count <= cycle; count++)
  	{
		
	}	
}

int spi_ll(int addr, int write, int writebyte)
{
	int d, b, c, wb;
	int dataout = 0;
	int datain_flag = 0;
	int prev_data = 0;
	prev_data = *mOISC_ior & 0xF7;
	datain_flag = (addr & 0x7F) | (write << 7); 

	#if mOISC_SPI_EDGE == 0
		*mOISC_ior = 0xF7 & prev_data;
	for (c = 0; c < 8; c ++)
	{
		b = (datain_flag >> (7-c)) & 0x01;
		//*mOISC_ior = 0x02 | b | prev_data;
		//*mOISC_ior = 0x02 | b | prev_data;
		*mOISC_ior = 0x02 | b | prev_data;
		*mOISC_ior = b | prev_data;
		//*mOISC_ior = b | prev_data;
	}
	for (c = 0; c < 8; c ++)
	{
                wb = (writebyte >> (7-c)) & 0x01;
		*mOISC_ior = 0x02 | wb| prev_data;
		d = ((*mOISC_ior) & 0x04) >> 2;
		dataout = dataout | (d << (7-c));
		*mOISC_ior = 0x00 | wb | prev_data;
		//*mOISC_ior = 0x00 | wb | prev_data;
	}	
	*mOISC_ior = 0x00 | prev_data;
	delay(5);
	*mOISC_ior = 0x08 | prev_data;
	#endif

	#if mOISC_SPI_EDGE == 1

		*mOISC_ior = 0x00 | prev_data;
	for (c = 0; c < 8; c ++)
	{
		b = (datain_flag >> (7-c)) & 0x01;
		//*mOISC_ior = b | prev_data;
		//*mOISC_ior = b | prev_data;
		*mOISC_ior = b | prev_data;
		*mOISC_ior = 0x02 | b | prev_data;
		//*mOISC_ior = 0x02 | b | prev_data;
	}
	for (c = 0; c < 8; c ++)
	{
		wb = (writebyte >> (7-c)) & 0x01;
		*mOISC_ior = 0x00 | wb | prev_data;
		d = ((*mOISC_ior) & 0x04) >> 2;
		dataout = dataout | (d << (7-c));
		//*mOISC_ior = 0x02 | wb | prev_data;
		*mOISC_ior = 0x02 | wb | prev_data;
	}	

	*mOISC_ior = 0x00 | prev_data;
	delay(5);
	*mOISC_ior = 0x08 | prev_data;
	#endif
 	return dataout;
}

void spitransaction(int writebyte)
{
	int b, c, wb;
	int dataout = 0;
	int datain_flag = 0;
	int prev_data = 0;
	prev_data = *mOISC_ior;
	datain_flag = (writebyte & 0xFF);

	#if mOISC_SPI_EDGE == 0
		//*mOISC_ior = 0xF7 & prev_data);
	for (c = 0; c < 8; c ++)
	{
		b = (datain_flag >> (7-c)) & 0x01;
		//*mOISC_ior = 0x02 | b | prev_data;
		//*mOISC_ior = 0x02 | b | prev_data;
		*mOISC_ior = 0x02 | b | prev_data;
		*mOISC_ior = b | prev_data;
		//*mOISC_ior = b | prev_data;
	}
	#endif

	#if mOISC_SPI_EDGE == 1

	for (c = 0; c < 8; c ++)
	{
		b = (datain_flag >> (7-c)) & 0x01;
		//*mOISC_ior = b | prev_data;
		//*mOISC_ior = b | prev_data;
		*mOISC_ior = b | prev_data;
		*mOISC_ior = 0x02 | b | prev_data;
		//*mOISC_ior = 0x02 | b | prev_data;
	}
	#endif
	*mOISC_ior = prev_data;
}

void spiselect(void)
{
	int prev_data = 0;
	prev_data = *mOISC_ior & 0xF7;

	*mOISC_ior = 0xF7 & prev_data;
}

void spiunselect(void)
{
	int prev_data = 0;
	prev_data = *mOISC_ior;
	*mOISC_ior = 0x08 | prev_data;
}

void spiLEDInit(void)
{
	current_idr |= 0x3B; // with LED
	*mOISC_idr = current_idr; //IO port X X X X CS MISO CLK MOSI
	*mOISC_ior = 0x08; // Chip Select up
}

int spiWrite(int addr, int writebyte)
{
	int write = 1;
	return spi_ll(addr, write, writebyte);
}

int spiRead(int addr)
{
	int read = 0;
	return spi_ll(addr, read, 0);
}

void spiBurstWrite(int reg, int src[], int len)
{
    spiselect();
    spitransaction(reg | RH_SPI_WRITE_MASK); 
    while (len--)
    spitransaction(src[len]);
    spiunselect();
}

void RH_RF95_setFrequency_868()
{
    spiWrite(RH_RF95_REG_06_FRF_MSB, 217);
    spiWrite(RH_RF95_REG_07_FRF_MID, 0);
    spiWrite(RH_RF95_REG_08_FRF_LSB, 0);
}

void RH_RF95_setFrequency_915()
{
    spiWrite(RH_RF95_REG_06_FRF_MSB, 228);
    spiWrite(RH_RF95_REG_07_FRF_MID, 192);
    spiWrite(RH_RF95_REG_08_FRF_LSB, 0);
}

void RH_RF95_setPreambleLength(int bytes)
{
    spiWrite(RH_RF95_REG_20_PREAMBLE_MSB, bytes >> 8);
    spiWrite(RH_RF95_REG_21_PREAMBLE_LSB, bytes & 0xff);
}

void RH_RF95_setModeIdle()
{
  spiWrite(RH_RF95_REG_01_OP_MODE, RH_RF95_MODE_STDBY);
}

void RH_RF95_setModemConfig_Bw125Cr45Sf128(void)
{
    spiWrite(RH_RF95_REG_1D_MODEM_CONFIG1,       0x72);
    spiWrite(RH_RF95_REG_1E_MODEM_CONFIG2,       0x74);
    spiWrite(RH_RF95_REG_26_MODEM_CONFIG3,       0x00);
}

void RH_RF95_setModemConfig_Bw500Cr45Sf128(void)
{
    spiWrite(RH_RF95_REG_1D_MODEM_CONFIG1,       0x92);
    spiWrite(RH_RF95_REG_1E_MODEM_CONFIG2,       0x74);
    spiWrite(RH_RF95_REG_26_MODEM_CONFIG3,       0x00);
}

void RH_RF95_setModemConfig_Bw31_25Cr48Sf512(void)
{
    spiWrite(RH_RF95_REG_1D_MODEM_CONFIG1,       0x48);
    spiWrite(RH_RF95_REG_1E_MODEM_CONFIG2,       0x94);
    spiWrite(RH_RF95_REG_26_MODEM_CONFIG3,       0x00);
}

void RH_RF95_setModemConfig_Bw125Cr48Sf4096(void)
{
    spiWrite(RH_RF95_REG_1D_MODEM_CONFIG1,       0x78);
    spiWrite(RH_RF95_REG_1E_MODEM_CONFIG2,       0xc4);
    spiWrite(RH_RF95_REG_26_MODEM_CONFIG3,       0x00);
}

void RH_RF95_setTxPower(int power)
{


  spiWrite(RH_RF95_REG_09_PA_CONFIG, RH_RF95_PA_SELECT | (power-5));

}

void RH_RF95_setModeTx()
{

  spiWrite(RH_RF95_REG_01_OP_MODE, RH_RF95_MODE_TX);
  spiWrite(RH_RF95_REG_40_DIO_MAPPING1, 0x40); // Interrupt on TxDone
}

int RH_RF95_send(int data[], int len)
{
    if (len > RH_RF95_MAX_MESSAGE_LEN)
  return 0;
    RH_RF95_setModeIdle();

    spiWrite(RH_RF95_REG_0D_FIFO_ADDR_PTR, 0);
    spiWrite(RH_RF95_REG_00_FIFO, BROADCAST_ADDR);
    spiWrite(RH_RF95_REG_00_FIFO, BROADCAST_ADDR);
    spiWrite(RH_RF95_REG_00_FIFO, ID);
    spiWrite(RH_RF95_REG_00_FIFO, FLAGS);
    spiBurstWrite(RH_RF95_REG_00_FIFO, data, len);
    spiWrite(RH_RF95_REG_22_PAYLOAD_LENGTH, len + RH_RF95_HEADER_LEN);

    RH_RF95_setModeTx(); // Start the transmitter
    while((spiRead(RH_RF95_REG_12_IRQ_FLAGS) & RH_RF95_TX_DONE ) != RH_RF95_TX_DONE);
    return 1;
}

int RH_RF95_init(void)
{

    spiWrite(RH_RF95_REG_01_OP_MODE, RH_RF95_MODE_SLEEP | RH_RF95_LONG_RANGE_MODE);
    delay(200); // Wait for sleep mode to take over

    if ((spiRead(RH_RF95_REG_01_OP_MODE)) != (RH_RF95_MODE_SLEEP | RH_RF95_LONG_RANGE_MODE))

     return 0; // No device present

    spiWrite(RH_RF95_REG_0E_FIFO_TX_BASE_ADDR, 0);
    spiWrite(RH_RF95_REG_0F_FIFO_RX_BASE_ADDR, 0);
    RH_RF95_setModeIdle();
    RH_RF95_setModemConfig_Bw125Cr45Sf128(); 
    RH_RF95_setPreambleLength(8); 
    RH_RF95_setFrequency_868();
    RH_RF95_setTxPower(13);

    return 1;
}


void i2c_low_scl()
{
	current_idr |= 0x80;
	// Set this
	*mOISC_idr = current_idr;
	*mOISC_ior = 0x3F & *mOISC_ior;
	//current_idr = new_idr;
}

// Pins are IOR7 -> SCL, IOR6 -> SDA

void i2c_high_scl()
{
	current_idr &= 0x7F;
	// Remove this, only for debug purposes
	//*mOISC_ior = 0x80 | *mOISC_ior);
	// Set this
	*mOISC_idr = current_idr;
	//current_idr = new_idr;
}

void i2c_low_sda()
{
	current_idr |= 0x40;
	// Set this
	*mOISC_idr = current_idr;
	*mOISC_ior = 0xBF & *mOISC_ior;
	//current_idr = new_idr;
}

void i2c_release_sda()
{
	current_idr &= 0xBF;
	// Set this
	*mOISC_idr = current_idr;
	//current_idr = new_idr;
}

void i2c_drive_sda()
{
	current_idr |= 0x40; // | current_idr;
	// Set this
	*mOISC_idr = current_idr;
	//current_idr = new_idr;
}

void i2c_high_sda()
{
	current_idr &= 0xBF;// & current_idr;
	// Remove this, only for debug purposes
	//*mOISC_ior = 0x40 | *mOISC_ior);
	// Set this
	*mOISC_idr = current_idr;
	//current_idr = new_idr;
}

void i2c_init()
{
	i2c_high_sda();
	i2c_high_scl();

}

int i2c_write(int slave_addr, int reg_addr, int reg_datah, int reg_datal, int nbytes)
{
	i2c_low_sda();
	i2c_low_scl();
	int prev_data = 0;
	int ack;
	int c;
	prev_data = *mOISC_ior;
	int b;
	for (c = 0; c < 7; c ++)
	{
		b = (slave_addr >> (6-c)) & 0x01;
		
		if (b == 1) {
			i2c_high_sda();
		}
		else
		{
			i2c_low_sda();
		}
		i2c_high_scl();
		i2c_low_scl();
		i2c_low_sda();
		
	}

	i2c_high_scl();
	i2c_low_scl();
	i2c_release_sda();

	i2c_high_scl();
	ack = (*mOISC_ior & 0x40) >> 6;
	i2c_low_scl();
	i2c_drive_sda();

	for (int c = 0; c < 8; c ++)
	{
		b = (reg_addr >> (7-c)) & 0x01;
		
		if (b == 1) {
			i2c_high_sda();
		}
		else
		{
			i2c_low_sda();
		}
		i2c_high_scl();
		i2c_low_scl();
		i2c_low_sda();
	}
	i2c_release_sda();
	i2c_high_scl();
	ack = (*mOISC_ior & 0x40) >> 6;
	i2c_low_scl();
	i2c_drive_sda();

	int bytedata = 0;
	if (nbytes == 2) {
		bytedata = reg_datah;
	}
	else
	{
		bytedata = reg_datal;
	}

	for (int c = 0; c < 8; c ++)
	{
		b = (bytedata >> (7-c)) & 0x01;
		
		if (b == 1) {
			i2c_high_sda();
		}
		else
		{
			i2c_low_sda();
		}
		i2c_high_scl();
		i2c_low_scl();
		i2c_low_sda();

	}
	i2c_release_sda();
	i2c_high_scl();
	ack = (*mOISC_ior & 0x40) >> 6;
	i2c_low_scl();
	i2c_drive_sda();
	i2c_low_sda();	

	if (nbytes == 2) {
		bytedata = reg_datal;
		for (int c = 0; c < 8; c ++)
		{
			b = (bytedata >> (7-c)) & 0x01;
			if (b == 1) {
				i2c_high_sda();
			}
			else
			{
				i2c_low_sda();
			}
			i2c_high_scl();
			i2c_low_scl();
			i2c_low_sda();
		}
		i2c_release_sda();
		i2c_high_scl();
		ack = (*mOISC_ior & 0x40) >> 6;
		i2c_low_scl();
		i2c_drive_sda();
		i2c_low_sda();	
	}

	i2c_high_scl();  
	i2c_high_sda();

	return OK;
}

void i2c_read(int slave_addr, int reg_addr, int *buf)
{
	i2c_low_sda();
	i2c_low_scl();
	int prev_data = 0;
	int ack;
	int c;
	int d;
	int dataout;
	prev_data = *mOISC_ior;
	int b;
	for (c = 0; c < 7; c ++)
	{
		b = (slave_addr >> (6-c)) & 0x01;

		if (b == 1) {
			i2c_high_sda();
		}
		else
		{
			i2c_low_sda();
		}
		i2c_high_scl();
		i2c_low_scl();
		i2c_low_sda();
	}
	i2c_high_scl();
	i2c_low_scl();
	i2c_release_sda();
	i2c_high_scl();
	ack = (*mOISC_ior & 0x40) >> 6;
	i2c_low_scl();
	i2c_drive_sda();
	i2c_high_sda();


	for (int c = 0; c < 8; c ++)
	{
		b = (reg_addr >> (7-c)) & 0x01;
		if (b == 1) {
			i2c_high_sda();
		}
		else
		{
			i2c_low_sda();
		}
		i2c_high_scl();
		i2c_low_scl();
		i2c_low_sda();
	}
	i2c_release_sda();
	i2c_high_scl();
	ack = (*mOISC_ior & 0x40) >> 6;
	i2c_low_scl();
	i2c_drive_sda();
	i2c_high_sda();


	// Re-start

	i2c_high_sda();  
	i2c_high_scl();

	i2c_low_sda();
	i2c_low_scl();

	for (c = 0; c < 7; c ++)
	{
		b = (slave_addr >> (6-c)) & 0x01;
		if (b == 1) {
			i2c_high_sda();
		}
		else
		{
			i2c_low_sda();
		}
		i2c_high_scl();
		i2c_low_scl();
		i2c_low_sda();
	}
	// READ
	i2c_high_sda();
	i2c_high_scl();
	i2c_low_scl();
	i2c_low_sda();
	i2c_release_sda();
	// ACK
	i2c_high_scl();
	ack = (*mOISC_ior & 0x40) >> 6;
	i2c_low_scl();

	dataout = 0;
	// reads data
	for (c = 0; c < 8; c ++)
	{
		i2c_high_scl();
		d = ((*mOISC_ior) & 0x40) >> 6;
		dataout = dataout | (d << (7-c));
		i2c_low_scl();
	}	

	// ACK
	i2c_drive_sda();
	i2c_low_sda();
	i2c_high_scl();
	i2c_low_scl();
	i2c_low_sda();
	i2c_release_sda();
	buf[1] = dataout;
	dataout = 0;

	// reads data
	for (c = 0; c < 8; c ++)
	{
		i2c_high_scl();
		d = ((*mOISC_ior) & 0x40) >> 6;
		dataout = dataout | (d << (7-c));
		i2c_low_scl();
	}	

	// NACK
	i2c_drive_sda();
	i2c_high_sda();
	i2c_high_scl();
	i2c_low_scl();
	i2c_low_sda();
	buf[0] = dataout;

	// Bus release
	i2c_high_scl();  
	i2c_high_sda();


	
}

// Don't need to call this, already setup at POR.
/*void MAX30205_init(int i2cbuf[])
{
     int cfg;
     i2c_read(ADDR_DEV, REG_CONFIGURATION, i2cbuf);
     cfg = i2cbuf[0];
     i2c_write(ADDR_DEV, (cfg & CFG_QUEUE_MASK) | CFG_POLARITY_HIGH_OR, 0, REG_CONFIGURATION, 1);
     i2c_read(ADDR_DEV, REG_CONFIGURATION, i2cbuf);
     cfg = i2cbuf[0];
     i2c_write(ADDR_DEV, cfg & CFG_TIMEOUT_DISABLE_AND, 0, REG_CONFIGURATION, 1);
     i2c_read(ADDR_DEV, REG_CONFIGURATION, i2cbuf);
     cfg = i2cbuf[0];
     i2c_write(ADDR_DEV, cfg | CFG_POLARITY_HIGH_OR, 0, REG_CONFIGURATION, 1);
     i2c_read(ADDR_DEV, REG_CONFIGURATION, i2cbuf);
     cfg = i2cbuf[0];
     i2c_write(ADDR_DEV, cfg & CFG_MODE_LOW_AND, 0, REG_CONFIGURATION, 1);
     i2c_read(ADDR_DEV, REG_CONFIGURATION, i2cbuf);
     cfg = i2cbuf[0];
     i2c_write(ADDR_DEV, cfg & CFG_WAKEUP_AND, 0, REG_CONFIGURATION, 1);
}*/

void MAX30205_read(int *buf)
{
	i2c_read(ADDR_DEV, REG_TEMPERATURE, buf);
}

void led_init()
{

}

int main()
{
  int i2cbuf[2] = {0, 0};
  int length = 2;

  *mOISC_csr = mOISC_100MHz;

  // MAX30205 initialization
  spiLEDInit();
  i2c_init();
  //MAX30205_init(i2cbuf);

  // RFM95 reset pull down
  *mOISC_ior = 0xEF & *mOISC_ior;
  delay(10);
  *mOISC_ior = 0x10 | *mOISC_ior; 

  // RFM95 initialization
  if (RH_RF95_init() == 0) {
	while (1);
  }
  
  
  while(1)
  {
    MAX30205_read(i2cbuf);
    RH_RF95_send(i2cbuf, length);

    *mOISC_csr = mOISC_10kHz; 
    // LED Blinking IOR[5], low speed CPU
    *mOISC_ior = 0x20 | *mOISC_ior;
    delay(1);
    *mOISC_ior = 0xDF & *mOISC_ior;
	delay(1);
	// high speed CPU
    *mOISC_csr = mOISC_100MHz; 

  }
}
