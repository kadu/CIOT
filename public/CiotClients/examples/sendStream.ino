#include <SPI.h>
#include <Ethernet.h>
#include <SendCiot.h>         // You must include the library here in order to use it in the sketch

const String APIKEY="CIOT_DEVICE_KEY";		// Replace with your CIOT device key
const String DEVICE="ArduinoDU"; 		// Replace with the id_developer of your device

const int numElements=3;			// Specify the number of rows in your array, in this case 3

byte mac[] = {  0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };

SendCiot sender;

void setup() {
  Serial.begin(9600);            // Start serial port
  Serial.println(F("Starting"));

  Ethernet.begin(mac);           // Start the Ethernet connection

}

void loop() {
  String array[numElements][2] = {{"Name", "James"}, {"Age", "28"}, {"Gender", "Male"}};  // Define the values of the array to be sent
  Serial.println(sender.send(array, numElements, APIKEY, DEVICE));                 // Using the instance of the library, call the method send
 delay(5000);                 //Send this stream every 10 secs.
}
