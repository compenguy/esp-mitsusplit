# MitsuSplit - ESP32 Firmware System For Controlling Mitsubishi Minisplit Systems Built on ESPHome

This project owes everything to:
* The [ESPHome project](https://esphome.io/), a fantastic project making home automation projects using ESP microcontrollers trivially easy
* The [MitsubishiCN105ESPHome component](https://github.com/echavet/MitsubishiCN105ESPHome) for ESPHome, where they've done amazing work implementing support for a range of Mitsubishi equipment for ESPHome

## Acquiring The Hardware

* An ESPHome-compatible microcontroller, with a serial port
  * I recommend the [LilyGo T-RSS3](https://lilygo.cc/products/t-rs-s3), based on the ESP32-S3 with an electrically-isolated 5V serial port
  * The part I used, the [LilyGo T-RSC3](https://github.com/Xinyuan-LilyGO/T-RSC3), based on the ESP32-C3, is no longer available
* A CN105 connector cable
  * You can find these on AliExpress - search for `24AWG PA PAP-05V-S`
* A serial port connector
  * For debugging purposes I used a terminal-block adapter (called a `db9 conversion board` on AliExpress)
  * For the finished cabling I used a soldered serial adapter in a permanent housing
* If you're using a microcontroller that's only 3.3V tolerant, you'll need a [level shifter](https://github.com/SwiCago/HeatPump/blob/master/CN105_ESP8266.png)

## Wiring

The CN105 connector on the minisplit's control board is a PAP-05V-R housing for SPHD-002T-P0.5 pins.

Check the pin number markings on the minisplit control board carefully. The pin assignments are

1. 12V DC
2. GND
3. 5V DC
4. TX (from the minisplit's perspective)
5. RX (from the minisplit's perspective)

Be very careful about the handling of the 12V DC line - most microcontrollers don't tolerate that for a supply voltage but the LilyGo T-RS*3 boards do. It's also important to note that the LilyGo T-RSS3 _will not_ run off 5V - its minimum input voltage requirement is _7V_, so it _must_ be supplied by the 12V DC line.

Additional references and photos for the wiring can be found on other minisplit hacking sites:
* https://nicegear.nz/blog/hacking-a-mitsubishi-heat-pump-air-conditioner/ (the OG hacker)
* https://github.com/SwiCago/HeatPump (level shifter circuit diagram or premade part recommendations, CN105 cable recommendations)
* https://casualhacker.net/post/2017-10-24-CN105_Connector (documents his process for crimping his own cable)

## Building The Firmware

The firmware definitions supplied here are tailored to the LilyGo T-RSC3, and will require some minor modifications to support other boards.

If you use a different microcontroller, and want to contribute your work back, by all means, submit a PR.

* Building the firmware requires the `esphome` command line utility.

[Official instructions for installation are located on the esphome site](https://esphome.io/guides/installing_esphome.html),
but the short version is you must have python3 installed, and then use pip3 to install esphome (which requires wheel),
similar to the following:

```
pip3 install wheel
pip3 install esphome
```

* Installing the firmware the first time requires the board to be plugged in via USB
  * Subsequent updates can be done via wifi, as long as it is able to successfully connect to your wifi network

* Create a `secrets.yaml` file at the root of the project (this file is specified in .gitignore so that it can't accidentally be added to revision control)
* Add the following values to this file:
  * `api_key: "<base64 value>"`
  * `ota_password: "<base64 value>"`
  * `wifi_ssid: <wifi ssid that it should connect to>`
  * `wifi_password: <wifi psk for the network it should connect to>`
  * `fallback_password: <psk for the AP created if it's unable to connect to wifi ssid>`

The OTA password is an encoded form of the password that must be supplied to authorize firmware updates.
See the ESPHome "[OTA Updates](https://esphome.io/components/ota/esphome.html)" documentation for more information.

For more information about the api key value in the secrets file, see the ESPHome "[Native API Component](https://esphome.io/components/api.html)" documentation
(including a dynamic, client-side in-page key you can copy/paste for your convenience).

* Run `make` to compile the image and upload it to the board
  * You can also invoke esphome directly
  * Check the Makefile for additional targets you can use



