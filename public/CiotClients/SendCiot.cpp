#include "SendCiot.h"
#include <Ethernet.h>

String dataString = "";
EthernetClient client;
char server[] = "ciot.herokuapp.com";

/**
    Sends an HTTP request to the CIOT system after constructing a JSON
    @param array contains the key-value pairs that will be sent in the JSON
    @param elements contains the number of columns in the array
    @param apikey contains the apikey of the CIOT user
    @param device contains the device id of the CIOT user
    @return gives the message sent from the CIOT server

    99.9% Based on Carriots library
*/

String SendCiot::send(String array[][2], int elements, String apikey, String device){
  String key;
  String value;
  String msg;
   //See if the connection is successful
   if (client.connect(server, 80)) {
    Serial.println(F("connected"));
    //Construct the JSON from the array passed to the method
    dataString = "{\"protocol\":\"v2\",\"checksum\":\"\",\"device\":\"";
    dataString += device;
    dataString += "\",\"at\":\"now\",\"data\":{";
    //Run through the bucle add each key-value in the array to the JSON
    for (int i=0; i<elements;i++){
      key=array[i][0];
      value=array[i][1];
      dataString += "\""+key+"\":";
      dataString += "\""+value+"\"";
      if (elements>1 && i!=elements-1){
         dataString += ",";
      }
    }
    dataString += "}}";
    Serial.println("\n\nDataString:\n"+dataString);

    //Make an HTTP request to the CIOT server
    client.println("POST /v1/streams/new HTTP/1.1");
    client.println("Host: ciot.herokuapp.com");
    client.println("Accept: application/json");
    client.println("User-Agent: Arduino-CIOT");
    client.println("Content-Type: application/json");
    client.print("key: ");
    client.println(apikey);
    client.print("Content-Length: ");
    int thisLength = dataString.length();
    client.println(thisLength);
    client.println("Connection: close");
    client.println();
    client.println(dataString);

   }
  //Store incoming data from the net connection to send back to the sketch
  while (client.available()) {
      char c = client.read();
      msg += c;
  }
  if (!client.connected()) {
      client.stop();
  }
  return msg;
}

