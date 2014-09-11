#ifndef SENDCIOT_H_
#define SENDCIOT_H_

#include <Arduino.h>

class SendCiot{
	public:
		String send(String array[][2], int elements, String apikey, String device);
};

#endif
