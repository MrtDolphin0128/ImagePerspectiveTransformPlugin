package com.mrtdolphin.perspectivetransformplugin;

import android.Manifest;
import android.content.Context;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import android.graphics.ImageFormat;
import android.graphics.PixelFormat;
import android.hardware.Camera;
import android.os.Build;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;

import android.view.Gravity;
import android.view.Surface;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.FrameLayout;


import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Environment;
import android.util.Base64;
import android.util.Log;
import android.net.Uri;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;

import org.opencv.android.BaseLoaderCallback;
import org.opencv.android.LoaderCallbackInterface;
import org.opencv.android.OpenCVLoader;
import org.opencv.android.Utils;
import org.opencv.core.CvType;
import org.opencv.core.Mat;
import org.opencv.core.Point;
import org.opencv.core.Size;
import org.opencv.imgproc.Imgproc;
import org.opencv.utils.Converters;



import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.LinkedList;


public class ImagePerspectiveTransformCordovaPlugin extends CordovaPlugin{

    private static final String  TAG = "OpenCV::Activity";
  
    @SuppressWarnings("deprecation")
    private Activity             activity;
    private BaseLoaderCallback mLoaderCallback;   
    
    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        activity = cordova.getActivity();

        super.initialize(cordova, webView);

        mLoaderCallback = new BaseLoaderCallback(activity) {
            @Override
            public void onManagerConnected(int status) {
                switch (status) {
                    case LoaderCallbackInterface.SUCCESS:
                    {
                        Log.i(TAG, "OpenCV loaded successfully");
                    } break;
                    default:
                    {
                        super.onManagerConnected(status);
                    } break;
                }
            }
        };
        
    }

    @Override
    public boolean execute(String action, JSONArray data,
                           CallbackContext callbackContext) throws JSONException {
     
		String strSrc, strResult;
		int x1, y1, x2, y2, x3, y3, x4, y4;
            
        if(action.equals("TranformBase64ToBase64")) {
            Log.i(TAG, "TranformBase64ToBase64 called");
            
			try {
                strSrc = data.getString(0);
                x1 = data.getInt(1);
                y1 = data.getInt(2);
                x2 = data.getInt(3);
                y2 = data.getInt(4);
                x3 = data.getInt(5);
                y3 = data.getInt(6);
                x4 = data.getInt(7);
                y4 = data.getInt(8);

				strResult = TranformBase64ToBase64(strSrc, x1, y1, x2, y2, x3, y3, x4, y4);
				callbackContext.success(strResult); 

            } catch (JSONException je) {
                Log.e(TAG, je.getMessage());
				callbackContext.error(je.getMessage());
            }
            
            return true;
        }

		if(action.equals("TranformUriToBase64")) {
            Log.i(TAG, "TranformUriToBase64 called");
            
			try {
                strSrc = data.getString(0);
                x1 = data.getInt(1);
                y1 = data.getInt(2);
                x2 = data.getInt(3);
                y2 = data.getInt(4);
                x3 = data.getInt(5);
                y3 = data.getInt(6);
                x4 = data.getInt(7);
                y4 = data.getInt(8);

				strResult = TranformUriToBase64(strSrc, x1, y1, x2, y2, x3, y3, x4, y4);
				callbackContext.success(strResult); 

            } catch (JSONException je) {
                Log.e(TAG, je.getMessage());
				callbackContext.error(je.getMessage());
            }
            
            return true;
        }
       
	    if(action.equals("TranformBase64ToUri")) {
            Log.i(TAG, "TranformBase64ToUri called");
            
			try {
                strSrc = data.getString(0);
                x1 = data.getInt(1);
                y1 = data.getInt(2);
                x2 = data.getInt(3);
                y2 = data.getInt(4);
                x3 = data.getInt(5);
                y3 = data.getInt(6);
                x4 = data.getInt(7);
                y4 = data.getInt(8);

				strResult = TranformBase64ToUri(strSrc, x1, y1, x2, y2, x3, y3, x4, y4);
				callbackContext.success(strResult); 

            } catch (JSONException je) {
                Log.e(TAG, je.getMessage());
				callbackContext.error(je.getMessage());
            }
            
            return true;
        }

		if(action.equals("TranformUriToUri")) {
            Log.i(TAG, "TranformUriToUri called");
            
			try {
                strSrc = data.getString(0);
                x1 = data.getInt(1);
                y1 = data.getInt(2);
                x2 = data.getInt(3);
                y2 = data.getInt(4);
                x3 = data.getInt(5);
                y3 = data.getInt(6);
                x4 = data.getInt(7);
                y4 = data.getInt(8);

				strResult = TranformUriToUri(strSrc, x1, y1, x2, y2, x3, y3, x4, y4);
				callbackContext.success(strResult); 

            } catch (JSONException je) {
                Log.e(TAG, je.getMessage());
				callbackContext.error(je.getMessage());
            }
            
            return true;
        }

        return false;
    }

    @Override
    public void onResume(boolean multitasking) {
        super.onResume(multitasking);
        if (!OpenCVLoader.initDebug()) {
            Log.d(TAG, "Internal OpenCV library not found. Using OpenCV Manager for initialization");
            OpenCVLoader.initAsync(OpenCVLoader.OPENCV_VERSION_3_1_0, activity, mLoaderCallback);
        } else {
            Log.d(TAG, "OpenCV library found inside package. Using it!");
            mLoaderCallback.onManagerConnected(LoaderCallbackInterface.SUCCESS);
        }
        
    }


	public String TranformBase64ToBase64(String base64str, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4)
    {
        Bitmap inputBmp = decodeBase64String(base64str);
        if(inputBmp == null){
            return null;
        }

        Bitmap outputBmp = ImgPersTranform(inputBmp, x1, y1, x2, y2, x3, y3, x4, y4);

        return Base64FromBmp(outputBmp);
    }

    public String TranformUriToBase64(String strUri, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4)
    {
        Bitmap inputBmp = getBitmapFromUri(strUri);
        if(inputBmp == null){
            return null;
        }
        Bitmap outputBmp = ImgPersTranform(inputBmp, x1, y1, x2, y2, x3, y3, x4, y4);

        return Base64FromBmp(outputBmp);
    }

    public String TranformBase64ToUri(String base64str, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4)
    {
        Bitmap inputBmp = decodeBase64String(base64str);
        if(inputBmp == null){
            return null;
        }

        Bitmap outputBmp = ImgPersTranform(inputBmp, x1, y1, x2, y2, x3, y3, x4, y4);

        return saveBmpToFile(outputBmp);
    }

    public String TranformUriToUri(String strUri, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4)
    {
        Bitmap inputBmp = getBitmapFromUri(strUri);
        if(inputBmp == null){
            return null;
        }
        Bitmap outputBmp = ImgPersTranform(inputBmp, x1, y1, x2, y2, x3, y3, x4, y4);

        return saveBmpToFile(outputBmp);
    }

    public static Bitmap decodeBase64String(String base64str)
    {
        Bitmap bmp;
        byte[] decodedString = new byte[0];

        String imageDataBytes = base64str.substring(base64str.indexOf(",")+1);
        decodedString = Base64.decode(imageDataBytes.getBytes(), Base64.DEFAULT);
        bmp = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
        return bmp;
    }

    public Bitmap getBitmapFromUri(String strUriPath)
    {
        Bitmap bmp = null;
        try {
            InputStream ims = activity.getContentResolver().openInputStream(Uri.fromFile(new File(strUriPath)));
            bmp = BitmapFactory.decodeStream(ims);

        } catch (FileNotFoundException e) {

        }
        return bmp;
    }


    public Bitmap ImgPersTranform(Bitmap inputBmp, int x1, int y1, int x2, int y2, int x3, int y3, int x4, int y4)
    {
        if(inputBmp == null){
            return null;
        }

        Mat inputMat = new Mat();
        Utils.bitmapToMat(inputBmp, inputMat);

        List<Point> temp = new ArrayList<Point>();
        temp.add(new Point(x1, y1));
        temp.add(new Point(x2, y2));
        temp.add(new Point(x3, y3));
        temp.add(new Point(x4, y4));

        Map<Integer, Point> orderpoints = getOrderedPoints(temp);

        Point pa = orderpoints.get(0);
        Point pb = orderpoints.get(1);
        Point pc = orderpoints.get(2);
        Point pd = orderpoints.get(3);

        List<Point> dst = new ArrayList<Point>();
        dst.add(pa);
        dst.add(pb);
        dst.add(pc);
        dst.add(pd);

        Mat tempM = Converters.vector_Point2f_to_Mat(dst);

        double w1 = Math.sqrt( Math.pow(pd.x - pc.x , 2) + Math.pow(pd.x - pc.x, 2));
        double w2 = Math.sqrt( Math.pow(pb.x - pa.x , 2) + Math.pow(pb.x - pa.x, 2));
        double h1 = Math.sqrt( Math.pow(pb.y - pd.y , 2) + Math.pow(pb.y - pd.y, 2));
        double h2 = Math.sqrt( Math.pow(pa.y - pc.y , 2) + Math.pow(pa.y - pc.y, 2));

        double W = (w1 < w2) ? w1 : w2;
        double H = (h1 < h2) ? h1 : h2;

        Mat outputMat = new Mat((int)W, (int)H, CvType.CV_8UC4);

        Point ocvPOut1 = new Point(0, 0);
        Point ocvPOut2 = new Point(W-1,0);
        Point ocvPOut3 = new Point(0, H-1);
        Point ocvPOut4 = new Point(W-1,H-1);
        List<Point> dest = new ArrayList<Point>();
        dest.add(ocvPOut1);
        dest.add(ocvPOut2);
        dest.add(ocvPOut3);
        dest.add(ocvPOut4);
        Mat endM = Converters.vector_Point2f_to_Mat(dest);

        Mat perspectiveTransform = Imgproc.getPerspectiveTransform(tempM, endM);

        Imgproc.warpPerspective(inputMat,
                outputMat,
                perspectiveTransform,
                new Size(W, H));
        Bitmap bmp = Bitmap.createBitmap(outputMat.cols(), outputMat.rows(),
                Bitmap.Config.ARGB_8888);
        Utils.matToBitmap(outputMat,bmp);

        return bmp;
    }

    public String Base64FromBmp(Bitmap bmp)
    {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        bmp.compress(Bitmap.CompressFormat.JPEG, 100, baos); //bm is the bitmap object
        byte[] b = baos.toByteArray();

        String strBase64 = Base64.encodeToString(b, Base64.DEFAULT);
		return "data:image/jpeg;base64,"+strBase64;
    }

    public Map<Integer, Point> getOrderedPoints(List<Point> points) {

        Point centerPoint = new Point();
        int size = points.size();
        for (Point point : points) {
            centerPoint.x += point.x / size;
            centerPoint.y += point.y / size;
        }
        Map<Integer, Point> orderedPoints = new HashMap<>();
        for (Point point : points) {
            int index = -1;
            if (point.x < centerPoint.x && point.y < centerPoint.y) {
                index = 0;
            } else if (point.x > centerPoint.x && point.y < centerPoint.y) {
                index = 1;
            } else if (point.x < centerPoint.x && point.y > centerPoint.y) {
                index = 2;
            } else if (point.x > centerPoint.x && point.y > centerPoint.y) {
                index = 3;
            }
            orderedPoints.put(index, point);
        }
        return orderedPoints;
    }

    public String saveBmpToFile(Bitmap bmp)
    {
        File mediaStorageDir = new File(Environment.getExternalStorageDirectory()
                + "/Android/data/"
                + activity.getPackageName()
                + "/Files");

        // This location works best if you want the created images to be shared
        // between applications and persist after your app has been uninstalled.

        // Create the storage directory if it does not exist
        if (! mediaStorageDir.exists()){
            if (! mediaStorageDir.mkdirs()){
                return null;
            }
        }
        // Create a media file name
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        String filename = mediaStorageDir.getPath() + File.separator + timeStamp +".jpg";

        FileOutputStream out = null;
        try {
            out = new FileOutputStream(filename);
            bmp.compress(Bitmap.CompressFormat.PNG, 100, out); // bmp is your Bitmap instance
            // PNG is a lossless format, the compression factor (100) is ignored
        } catch (Exception e) {
            return null;
        } finally {
            try {
                if (out != null) {
                    out.close();
                }
            } catch (IOException e) {
                return null;
            }
        }

        return Uri.fromFile(new File(filename)).getPath();
    }

}
