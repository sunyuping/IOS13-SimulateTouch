#include "AlertBox.h"

void showAlertBoxFromRawData(UInt8 *eventData)
{
    NSString *alertData = [NSString stringWithFormat:@"%s", eventData];
    NSArray *alertDataArray = [alertData componentsSeparatedByString:@";;"];
    showAlertBox(alertDataArray[0], alertDataArray[1], 999);
}

void showAlertBox(NSString* title, NSString* content, int dismissTime)
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    [dict setObject: title forKey: (__bridge NSString*)kCFUserNotificationAlertHeaderKey];
    [dict setObject: content forKey: (__bridge NSString*)kCFUserNotificationAlertMessageKey];
    [dict setObject: @"Ok" forKey:(__bridge NSString*)kCFUserNotificationDefaultButtonTitleKey];
    
    SInt32 error = 0;
    CFUserNotificationRef alert = CFUserNotificationCreate(NULL, 0, kCFUserNotificationPlainAlertLevel, &error, (__bridge CFDictionaryRef)dict);


    
    CFOptionFlags response;
    
     if((error) || (CFUserNotificationReceiveResponse(alert, dismissTime, &response))) {
        NSLog(@"com.zjx.springboard: alert error or no user response after %d seconds for title: %@. Content %@", dismissTime, title, content);
     }
    
    /*
    else if((response & 0x3) == kCFUserNotificationAlternateResponse) {
        NSLog(@"cancel");
    } else if((response & 0x3) == kCFUserNotificationDefaultResponse) {
        NSLog(@"view");
    }
    */

    CFRelease(alert);
}