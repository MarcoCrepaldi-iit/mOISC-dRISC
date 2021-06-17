# coding=utf-8
# # # # # # # # 
import serial
import sys
import time

class MAX30205_RFM95_demo():

	_INT_ZERO = 0
	_INT_ONE = 1
	_INT_TWO = 2
	_INT_FOUR = 4
	_INT_EIGHT = 8
	_FLOAT_TWO = 2.0
	_SERIAL_BAUD_RATE = 115200

	# initializes peripheral and checks for input arguments serial port only

	def __init__(self):
		if len(sys.argv) <= self._INT_ONE:
			sys.stdout.write('\nerror: you need to specify the port name, e.g., /dev/ttyACM0\n\n')
			sys.exit(self._INT_ONE)
		elif len(sys.argv) > self._INT_TWO:
			sys.stdout.write('\nerror: you need to specify only one parameter, that is the port name, e.g., /dev/ttyACM0\n\n')
			sys.exit(self._INT_ONE)
		try:
			self.serialport = serial.Serial(sys.argv[self._INT_ONE], self._SERIAL_BAUD_RATE, timeout=0, dsrdtr=True, rtscts=True)
		except:
			sys.stdout.write('\nerror: cannot open the specified serial port ' + str(sys.argv[self._INT_ONE]) + '\n\n')
			sys.exit(self._INT_ONE)
		sys.stdout.write('\n\ninfo: reading MAX30205 temperature data through RFM95 LoRa, press ctrl-c to exit...\n')
		self.readLoop()

	# reads temperature bytes [0] + [1]/2**8
	def readLoop(self):
		try:	
			while True:
				bytesToRead = self.serialport.in_waiting
				if (bytesToRead == self._INT_FOUR): 
					rxBytes = self.serialport.readline()
					T = rxBytes[self._INT_ZERO] + rxBytes[self._INT_ONE] / self._FLOAT_TWO**self._INT_EIGHT
					sys.stdout.write('T (°C) = ' + str(T) + '\n')
					sys.stdout.flush()
				elif (bytesToRead > self._INT_FOUR):
					while self.serialport.in_waiting != 0:
						self.serialport.read(1)
		except KeyboardInterrupt:
			self.serialport.close()
			sys.stdout.write('\n\n')
			sys.exit(self._INT_ZERO)
		except:		
			sys.stdout.write('\n\n')
			sys.exit(self._INT_ONE)

# Loads demo
demo = MAX30205_RFM95_demo()

