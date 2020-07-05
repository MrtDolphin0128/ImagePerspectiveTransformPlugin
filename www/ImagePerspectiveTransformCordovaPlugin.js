/**
*
**/
var ImagePerspectiveTransformCordovaPlugin = function () {};

ImagePerspectiveTransformCordovaPlugin.prototype.TranformBase64ToBase64 = function (inputval, x1, y1, x2, y2, x3, y3, x4, y4, successCallback, errorCallback) {
  cordova.exec(successCallback, errorCallback, "ImagePerspectiveTransformCordovaPlugin", "TranformBase64ToBase64", [inputval, x1, y1, x2, y2, x3, y3, x4, y4]);
};

ImagePerspectiveTransformCordovaPlugin.prototype.TranformUriToBase64 = function (inputval, x1, y1, x2, y2, x3, y3, x4, y4, successCallback, errorCallback) {
  cordova.exec(successCallback, errorCallback, "ImagePerspectiveTransformCordovaPlugin", "TranformUriToBase64", [inputval, x1, y1, x2, y2, x3, y3, x4, y4]);
};

ImagePerspectiveTransformCordovaPlugin.prototype.TranformBase64ToUri = function (inputval, x1, y1, x2, y2, x3, y3, x4, y4, successCallback, errorCallback) {
  cordova.exec(successCallback, errorCallback, "ImagePerspectiveTransformCordovaPlugin", "TranformBase64ToUri", [inputval, x1, y1, x2, y2, x3, y3, x4, y4]);
};

ImagePerspectiveTransformCordovaPlugin.prototype.TranformUriToUri = function (inputval, x1, y1, x2, y2, x3, y3, x4, y4, successCallback, errorCallback) {
  cordova.exec(successCallback, errorCallback, "ImagePerspectiveTransformCordovaPlugin", "TranformUriToUri", [inputval, x1, y1, x2, y2, x3, y3, x4, y4]);
};

if (!window.plugins) {
  window.plugins = {};
}

if (!window.plugins.ImagePerspectiveTransformCordovaPlugin) {
  window.plugins.ImagePerspectiveTransformCordovaPlugin = new ImagePerspectiveTransformCordovaPlugin();
}

if (typeof module != 'undefined' && module.exports){
  module.exports = ImagePerspectiveTransformCordovaPlugin;
}
