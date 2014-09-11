CIOT
====

CIOT is a backend to provide a place to store IoT sensors.


How to use
==========

* Create a user
* Create a device

Send json's from device via post to CIOT, according with this:

**url**: http://YOUR_SERVER/v1/streams/new
**header**: key: YOUR_DEVICE_KEY
**raw**: A_JSON_WITH_ANY_INFO

For Arduino you can download a CIOT Library (comming soon)