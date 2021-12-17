# PolarAccessLink Custom UI




## Project specification
The app is built to easily aggregate and further elaborate the measurements acquired by Polar TM devices, and of which the data are available through their open API. Everyone can use the application as long as the config file in the android controller is set up correctly, with the data provided by PolarAccessLink after the registration for the API use.
Please be mindful of the fact that if you acquire the data through this app and commit the transaction on PolarAccessLink server the data will be forever deleted from Polar servers, and if you lose it from the device you will not be able to recover it in any way. That is why the commit operation is commented in the code, you can find the corresponding TODO in netcontroller class

## Implemented Features

| Functionality | Status |
|:-----------------------|:------------------------------------:|
| Basic features | [![GREEN](http://placehold.it/15/44bb44/44bb44)](https://github.com/Calonca/ing-sw-2021-laconca-lodari-giaccaglia/tree/master/src/main/java/it/polimi/ingsw/server/model) |
| Daily activities aggregation | [![GREEN](http://placehold.it/15/44bb44/44bb44)](https://github.com/Calonca/ing-sw-2021-laconca-lodari-giaccaglia/tree/master/src/main/java/it/polimi/ingsw/server/model) |
| High availability |[![GREEN](http://placehold.it/15/44bb44/44bb44)](https://github.com/Calonca/ing-sw-2021-laconca-lodari-giaccaglia/tree/master/src/main/java/it/polimi/ingsw/server) |
| Activity sorting by attribute| [![GREEN](http://placehold.it/15/44bb44/44bb44)](https://github.com/Calonca/ing-sw-2021-laconca-lodari-giaccaglia/tree/master/src/main/java/it/polimi/ingsw/client/view/GUI) |
| All time records by attribute |[![GREEN](http://placehold.it/15/44bb44/44bb44)](https://github.com/Calonca/ing-sw-2021-laconca-lodari-giaccaglia/tree/master/src/main/java/it/polimi/ingsw/client/view/CLI) |



## Usage

### Android

1. Install android studio
2. Install flutter plugin for android studio
3. Register on PolarAccessLink to obtain client id and secret
4. Clone the repo
5. Insert the correct data in lib/controller/net_controller
6. Build and install on your device, or run on local vm


## Disclaimers

* Clicking repeatedly during the sort action may cause issues.
* InAppWebView version may not be compatible with your mobile device, please check accordingly

## Software used

**Android studio and Flutter** 

**dcdg** - UML diagrams

## Copyright and license

PolarAccessLink is property of Polar TM
