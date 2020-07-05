# Image Perspective Transform CordovaPlugin (Android & iOS)
This plugin allows the application to detect if an inputed image target is visible, or not, by matching the image features with the device camera features using [OpenCV](http://opencv.org/) (v3.1. on Android, v2.4.13 on iOS)  It also presents the device camera preview in the background.

## Install
To install the plugin in your current Cordova project run outside you project root
```
git clone https://github.com/MrtDolphin/ImagePerspectiveTransformCordovaPlugin.git
cd <your-project-root>
cordova plugin add ../ImagePerspectiveTransformCordovaPlugin
```

### Android
- The plugin aims to be used with Android API >= 16 (4.1 Jelly Bean).

### IOS
- The plugin aims to be used with iOS version >= 7.
- **Important!** Go into src/ios folder and extract opencv2.framework from the zip file into the same folder.
- Since iOS 10, `<key>NSCameraUsageDescription</key>` is required in the project Info.plist of any app that wants to use Camera.
The plugin should add this automatically but in case this does not happen to add it, just open the project in XCode, go to the Info tab and add the `NSCameraUsageDescription` key with a string value that explain why your app need an access to the camera.

### Note
In *config.xml* add Android and iOS target preference
```javascript
<platform name="android">
    <preference name="android-minSdkVersion" value="16" />
</platform>
<platform name="ios">
    <preference name="target-device" value="handset"/>
    <preference name="deployment-target" value="7.0"/>
</platform>
```


## Usage

This plugin offers the  Perspective Tranform of an image from/to both Base64 Encoded String and Image Uri
This offers 4 functions `TranformBase64ToBase64`, `TranformUriToBase64`, `TranformBase64ToUri` and `TranformUriToUri`.
All 4 functions has 9(Base64Encoded/Uri string of an Image, coordinates of 4 points for tranformation) + 2 callback(SuccessCallback and ErrorCallback) parameters.

## API

**`TranformBase64ToBase64`** - Applys perspective tranform to Base64Encoded String and returns Base64 Encoded String of the result image.
*** appearance***
TranformBase64ToBase64 = function (inputval, x1, y1, x2, y2, x3, y3, x4, y4, successCallback, errorCallback) {
  cordova.exec(successCallback, errorCallback, "ImagePerspectiveTransformCordovaPlugin", "TranformBase64ToBase64", [inputval, x1, y1, x2, y2, x3, y3, x4, y4]);
};

*** Request Params:
inputval : String - Base64 Encoded String of an image
x1, y1, x2, y2, x3, y3, x4, y4 : int - x pos and y pos of 4 points' coordinates for transformation respectively.
* These position values should be ordered in clock wise order.

*** Response:
: String - Base64 Encoded String of target image


All other 3 apis have same format like above api.
Just their input string and return string are Base64Encoded String or ImageUri according to api name.


## Demo Project

[ImagePerspectiveTransformDempApp](https://github.com/MrtDolphin/ImagePerspectiveTransformDempApp)
