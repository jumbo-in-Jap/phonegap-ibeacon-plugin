phonegap-ibeacon-plugin
=======================

This plugin to use iBeacon advertise in phonegap application.

##how to use

* add source your Phonegap source.

IosIBeaconPlugin.h,IosIBeaconPlugin.m to classes.

* write config.xml

``
    <!-- My iBeacon plugin -->
    <feature name="IosIBeaconPlugin">
        <param name="ios-package" value="IosIBeaconPlugin" />
    </feature>
``

* use in html source.

        function startIBeacon(){
            cordova.exec(
                function callback(data) {
                         console.log("success");
                         $("#beaconBtn").unbind();
                         $("#beaconBtn").text("iBeacon stop.");
                         $("#beaconBtn").click(function(){
                                               stopIBeacon();
                                               });
                },
                function errorHandler(err) {
                         console.log("error");
                },
                'IosIBeaconPlugin',
                'startAdvertiseFromJS',
                ['80D8FFC4-9807-407C-8C4D-F7AF9248B027','1','1','jp.com.sample.iBeaconPlugin']
            );
        }
        
        function stopIBeacon(){
            cordova.exec(
                function callback(data) {
                        console.log("success");
                         $("#beaconBtn").unbind();
                         $("#beaconBtn").text("iBeacon start.");
                         $("#beaconBtn").click(function(){
                                               startIBeacon();
                                               })
                },
                function errorHandler(err) {
                         console.log("error");
                },
                'IosIBeaconPlugin',
                'stopAdvertiseFromJS',
                []
            );
        }
