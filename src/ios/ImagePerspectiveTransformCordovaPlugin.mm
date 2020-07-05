#import "ImagePerspectiveTransformCordovaPlugin.h"
#import <opencv2/opencv.hpp>

using namespace cv;

@interface ImagePerspectiveTransformCordovaPlugin()
{
    
}

@end



@implementation ImagePerspectiveTransformCordovaPlugin

- (void)TranformBase64ToBase64:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{

        NSString* strBase64 = [command.arguments objectAtIndex:0];

	NSNumber* arg_x1 = [command.arguments objectAtIndex:1];
	int x1 = [arg_x1 intValue];

	NSNumber* arg_y1 = [command.arguments objectAtIndex:2];
	int y1 = [arg_y1 intValue];

	NSNumber* arg_x2 = [command.arguments objectAtIndex:3];
	int x2 = [arg_x2 intValue];

	NSNumber* arg_y2 = [command.arguments objectAtIndex:4];
	int y2 = [arg_y2 intValue];

	NSNumber* arg_x3 = [command.arguments objectAtIndex:5];
	int x3 = [arg_x3 intValue];

	NSNumber* arg_y3 = [command.arguments objectAtIndex:6];
	int y3 = [arg_y3 intValue];

	NSNumber* arg_x4 = [command.arguments objectAtIndex:7];
	int x4 = [arg_x4 intValue];	

	NSNumber* arg_y4 = [command.arguments objectAtIndex:8];
	int y4 = [arg_y4 intValue];

	CDVPluginResult* plugin_result = nil;
       
	if(strBase64 == NULL || [strBase64 length] == 0){
		plugin_result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Base64 String is empty."];
		[self.commandDelegate sendPluginResult:plugin_result callbackId:command.callbackId];
		return;
	}

	UIImage *inputImg = [self GetImageFromBase64:strBase64];
	if(inputImg == NULL){
		plugin_result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Image from Base64 String failed."];
		[self.commandDelegate sendPluginResult:plugin_result callbackId:command.callbackId];
		return;
	}

	UIImage *outputImg = [self ImgPersTranform:inputImg x1:x1 y1:y1 x2:x2 y2:y2 x3:x3 y3:y3 x4:x4 y4:y4];
	if(outputImg == NULL){
		plugin_result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Perspective Tranform failed."];
		[self.commandDelegate sendPluginResult:plugin_result callbackId:command.callbackId];
		return;
	}
	
	NSString *result = [self GetBase64FromImg:outputImg];
	plugin_result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
	
        [self.commandDelegate sendPluginResult:plugin_result callbackId:command.callbackId];
    }];
}


- (void)TranformUriToBase64:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{

        NSString* strUri = [command.arguments objectAtIndex:0];
	
	NSNumber* arg_x1 = [command.arguments objectAtIndex:1];
	int x1 = [arg_x1 intValue];

	NSNumber* arg_y1 = [command.arguments objectAtIndex:2];
	int y1 = [arg_y1 intValue];

	NSNumber* arg_x2 = [command.arguments objectAtIndex:3];
	int x2 = [arg_x2 intValue];

	NSNumber* arg_y2 = [command.arguments objectAtIndex:4];
	int y2 = [arg_y2 intValue];

	NSNumber* arg_x3 = [command.arguments objectAtIndex:5];
	int x3 = [arg_x3 intValue];

	NSNumber* arg_y3 = [command.arguments objectAtIndex:6];
	int y3 = [arg_y3 intValue];

	NSNumber* arg_x4 = [command.arguments objectAtIndex:7];
	int x4 = [arg_x4 intValue];	

	NSNumber* arg_y4 = [command.arguments objectAtIndex:8];
	int y4 = [arg_y4 intValue];

	CDVPluginResult* plugin_result = nil;
       
	if(strUri == NULL || [strUri length] == 0){
		plugin_result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Uri is empty."];
		[self.commandDelegate sendPluginResult:plugin_result callbackId:command.callbackId];
		return;
	}

	UIImage *inputImg = [self GetImageFromUri:strUri];
	if(inputImg == NULL){
		plugin_result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Image from Uri failed."];
		[self.commandDelegate sendPluginResult:plugin_result callbackId:command.callbackId];
		return;
	}

	UIImage *outputImg = [self ImgPersTranform:inputImg x1:x1 y1:y1 x2:x2 y2:y2 x3:x3 y3:y3 x4:x4 y4:y4];
	if(outputImg == NULL){
		plugin_result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Perspective Tranform failed."];
		[self.commandDelegate sendPluginResult:plugin_result callbackId:command.callbackId];
		return;
	}
	
	NSString *result = [self GetBase64FromImg:outputImg];
	plugin_result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
	
        [self.commandDelegate sendPluginResult:plugin_result callbackId:command.callbackId];
    }];
}


- (void)TranformBase64ToUri:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{

        NSString* strBase64 = [command.arguments objectAtIndex:0];
	
	NSNumber* arg_x1 = [command.arguments objectAtIndex:1];
	int x1 = [arg_x1 intValue];

	NSNumber* arg_y1 = [command.arguments objectAtIndex:2];
	int y1 = [arg_y1 intValue];

	NSNumber* arg_x2 = [command.arguments objectAtIndex:3];
	int x2 = [arg_x2 intValue];

	NSNumber* arg_y2 = [command.arguments objectAtIndex:4];
	int y2 = [arg_y2 intValue];

	NSNumber* arg_x3 = [command.arguments objectAtIndex:5];
	int x3 = [arg_x3 intValue];

	NSNumber* arg_y3 = [command.arguments objectAtIndex:6];
	int y3 = [arg_y3 intValue];

	NSNumber* arg_x4 = [command.arguments objectAtIndex:7];
	int x4 = [arg_x4 intValue];	

	NSNumber* arg_y4 = [command.arguments objectAtIndex:8];
	int y4 = [arg_y4 intValue];

	CDVPluginResult* plugin_result = nil;
       
	if(strBase64 == NULL || [strBase64 length] == 0){
		plugin_result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Base64 String is empty."];
		[self.commandDelegate sendPluginResult:plugin_result callbackId:command.callbackId];
		return;
	}

	UIImage *inputImg = [self GetImageFromBase64:strBase64];
	if(inputImg == NULL){
		plugin_result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Image from Base64 String failed."];
		[self.commandDelegate sendPluginResult:plugin_result callbackId:command.callbackId];
		return;
	}

	UIImage *outputImg = [self ImgPersTranform:inputImg x1:x1 y1:y1 x2:x2 y2:y2 x3:x3 y3:y3 x4:x4 y4:y4];
	if(outputImg == NULL){
		plugin_result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Perspective Tranform failed."];
		[self.commandDelegate sendPluginResult:plugin_result callbackId:command.callbackId];
		return;
	}
	
	NSString *result = [self GetUriFromImg:outputImg];
	plugin_result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
	
        [self.commandDelegate sendPluginResult:plugin_result callbackId:command.callbackId];
    }];
}

- (void)TranformUriToUri:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{

        NSString* strUri = [command.arguments objectAtIndex:0];
	
	NSNumber* arg_x1 = [command.arguments objectAtIndex:1];
	int x1 = [arg_x1 intValue];

	NSNumber* arg_y1 = [command.arguments objectAtIndex:2];
	int y1 = [arg_y1 intValue];

	NSNumber* arg_x2 = [command.arguments objectAtIndex:3];
	int x2 = [arg_x2 intValue];

	NSNumber* arg_y2 = [command.arguments objectAtIndex:4];
	int y2 = [arg_y2 intValue];

	NSNumber* arg_x3 = [command.arguments objectAtIndex:5];
	int x3 = [arg_x3 intValue];

	NSNumber* arg_y3 = [command.arguments objectAtIndex:6];
	int y3 = [arg_y3 intValue];

	NSNumber* arg_x4 = [command.arguments objectAtIndex:7];
	int x4 = [arg_x4 intValue];	

	NSNumber* arg_y4 = [command.arguments objectAtIndex:8];
	int y4 = [arg_y4 intValue];

	CDVPluginResult* plugin_result = nil;
       
	if(strUri == NULL || [strUri length] == 0){
		plugin_result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Uri is empty."];
		[self.commandDelegate sendPluginResult:plugin_result callbackId:command.callbackId];
		return;
	}

	UIImage *inputImg = [self GetImageFromUri:strUri];
	if(inputImg == NULL){
		plugin_result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Image from Uri failed."];
		[self.commandDelegate sendPluginResult:plugin_result callbackId:command.callbackId];
		return;
	}

	UIImage *outputImg = [self ImgPersTranform:inputImg x1:x1 y1:y1 x2:x2 y2:y2 x3:x3 y3:y3 x4:x4 y4:y4];
	if(outputImg == NULL){
		plugin_result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Perspective Tranform failed."];
		[self.commandDelegate sendPluginResult:plugin_result callbackId:command.callbackId];
		return;
	}
	
	NSString *result = [self GetUriFromImg:outputImg];
	plugin_result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
	
        [self.commandDelegate sendPluginResult:plugin_result callbackId:command.callbackId];
    }];
}


- (UIImage *) GetImageFromBase64 : (NSString *) strBase64
{
    NSString *encodedData = strBase64;
    if ([strBase64 rangeOfString:@"data:"].location == NSNotFound) {
        // do nothing
    } else {
        NSArray *lines = [strBase64 componentsSeparatedByString: @","];
        encodedData = lines[1];
    }
    
    // NSString *encodedData = [strBase64 substringFromIndex:[strBase64 rangeOfString:@","].location+1];
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:encodedData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *res = [UIImage imageWithData:data];
    return res;
}

- (UIImage *) GetImageFromUri :(NSString *) strUri
{
    UIImage* img = [UIImage imageWithContentsOfFile:strUri];
    return img;
}

- (UIImage *) ImgPersTranform : (UIImage *) inputImg
                            x1: (int) x1
                            y1: (int) y1
                            x2: (int) x2
                            y2: (int) y2
                            x3: (int) x3
                            y3: (int) y3
                            x4: (int) x4
                            y4: (int) y4
{
    NSMutableArray * points = [[NSMutableArray alloc] initWithCapacity:4];
    
    [points addObject:[NSValue valueWithCGPoint:CGPointMake(x1, y1)]];
    [points addObject:[NSValue valueWithCGPoint:CGPointMake(x2, y2)]];
    [points addObject:[NSValue valueWithCGPoint:CGPointMake(x3, y3)]];
    [points addObject:[NSValue valueWithCGPoint:CGPointMake(x4, y4)]];
    
    // okay, sort it by the X, then split it
    NSArray * sortedArray = [points sortedArrayUsingComparator:^NSComparisonResult(NSValue *obj1, NSValue *obj2) {
        CGPoint firstPoint = [obj1 CGPointValue];
        CGPoint secondPoint = [obj2 CGPointValue];
        if (firstPoint.x > secondPoint.x) {
            return NSOrderedDescending;
        } else if (firstPoint.x < secondPoint.x) {
            return NSOrderedAscending;
        } else {
            return NSOrderedSame;
        }
    }];
    
    // we're sorted on X, so grab two of those bitches and figure out top and bottom
    NSMutableArray * left = [[NSMutableArray alloc] initWithCapacity:2];
    NSMutableArray * right = [[NSMutableArray alloc] initWithCapacity:2];
    [left addObject:sortedArray[0]];
    [left addObject:sortedArray[1]];
    
    [right addObject:sortedArray[2]];
    [right addObject:sortedArray[3]];
    
    // okay, now sort each of those arrays on the Y access
    NSArray * sortedLeft = [left sortedArrayUsingComparator:^NSComparisonResult(NSValue *obj1, NSValue *obj2) {
        CGPoint firstPoint = [obj1 CGPointValue];
        CGPoint secondPoint = [obj2 CGPointValue];
        if (firstPoint.y > secondPoint.y) {
            return NSOrderedDescending;
        } else if (firstPoint.y < secondPoint.y) {
            return NSOrderedAscending;
        } else {
            return NSOrderedSame;
        }
    }];
    
    NSArray * sortedRight = [right sortedArrayUsingComparator:^NSComparisonResult(NSValue *obj1, NSValue *obj2) {
        CGPoint firstPoint = [obj1 CGPointValue];
        CGPoint secondPoint = [obj2 CGPointValue];
        if (firstPoint.y > secondPoint.y) {
            return NSOrderedDescending;
        } else if (firstPoint.y < secondPoint.y) {
            return NSOrderedAscending;
        } else {
            return NSOrderedSame;
        }
    }];
    
    
    CGPoint ptTopLeft = [[sortedLeft objectAtIndex:0] CGPointValue];
    CGPoint ptTopRight = [[sortedRight objectAtIndex:0] CGPointValue];
    CGPoint ptBottomLeft = [[sortedLeft objectAtIndex:1] CGPointValue];
    CGPoint ptBottomRight = [[sortedRight objectAtIndex:1] CGPointValue];
    
    
    CGFloat w1 = sqrt( pow(ptBottomRight.x - ptBottomLeft.x , 2) + pow(ptBottomRight.x - ptBottomLeft.x, 2));
    CGFloat w2 = sqrt( pow(ptTopRight.x - ptTopLeft.x , 2) + pow(ptTopRight.x - ptTopLeft.x, 2));
    
    CGFloat h1 = sqrt( pow(ptTopRight.y - ptBottomRight.y , 2) + pow(ptTopRight.y - ptBottomRight.y, 2));
    CGFloat h2 = sqrt( pow(ptTopLeft.y - ptBottomLeft.y , 2) + pow(ptTopLeft.y - ptBottomLeft.y, 2));
    
    CGFloat maxWidth = (w1 < w2) ? w1 : w2;
    CGFloat maxHeight = (h1 < h2) ? h1 : h2;
    
    cv::Point2f src[4], dst[4];
    src[0].x = ptTopLeft.x;
    src[0].y = ptTopLeft.y;
    src[1].x = ptTopRight.x;
    src[1].y = ptTopRight.y;
    src[2].x = ptBottomRight.x;
    src[2].y = ptBottomRight.y;
    src[3].x = ptBottomLeft.x;
    src[3].y = ptBottomLeft.y;
    
    dst[0].x = 0;
    dst[0].y = 0;
    dst[1].x = maxWidth - 1;
    dst[1].y = 0;
    dst[2].x = maxWidth - 1;
    dst[2].y = maxHeight - 1;
    dst[3].x = 0;
    dst[3].y = maxHeight - 1;
    
    cv::Mat original = [self  cvMatFromUIImage:inputImg];
    cv::Mat undistorted = cv::Mat( cvSize(maxWidth,maxHeight), CV_8UC4);
    cv::warpPerspective(original, undistorted, cv::getPerspectiveTransform(src, dst), cvSize(maxWidth, maxHeight));
    
    UIImage *newImage = [self UIImageFromCVMat:undistorted];
    
    undistorted.release();
    original.release();
    
    return newImage;;
}

- (NSString *) GetBase64FromImg: (UIImage *) inputImg
{
    NSString *strHeader = @"data:image/jpeg;base64,";
    NSString *res = [UIImageJPEGRepresentation(inputImg, 100) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return [strHeader stringByAppendingString:res];
}

- (NSString *) GetUriFromImg: (UIImage *) inputImg
{
    // Create path.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd_HH:mm:ss"];
    
    NSDate *currentDate = [NSDate date];
    NSString *dateString = [formatter stringFromDate:currentDate];
    
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[dateString stringByAppendingString:@".jpg"]];
    
    // Save image.
    if([UIImageJPEGRepresentation(inputImg, 100) writeToFile:filePath atomically:YES]){
         return filePath;
    }
    
    return NULL;
}

// get cvMat from UIImage
- (cv::Mat) cvMatFromUIImage: (UIImage *) image
{
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
    
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    
    return cvMat;
}

- (UIImage *) UIImageFromCVMat: (cv::Mat)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    CGColorSpaceRef colorSpace;
    
    if (cvMat.elemSize() == 1)
    {
        colorSpace = CGColorSpaceCreateDeviceGray();
    }
    else
    {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                 //width
                                        cvMat.rows,                                 //height
                                        8,                                          //bits per component
                                        8 * cvMat.elemSize(),                       //bits per pixel
                                        cvMat.step[0],                              //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,//bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        false,                                      //should interpolate
                                        kCGRenderingIntentDefault                   //intent
                                        );
    
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return finalImage;
}


- (void)beginImageContextWithSize:(CGSize)size
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        if ([[UIScreen mainScreen] scale] == 2.0) {
            UIGraphicsBeginImageContextWithOptions(size, YES, 2.0);
        } else {
            UIGraphicsBeginImageContext(size);
        }
    } else {
        UIGraphicsBeginImageContext(size);
    }
}

- (void)endImageContext
{
    UIGraphicsEndImageContext();
}


@end
