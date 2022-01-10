#import "Adpayment.h"

@implementation Adpayment

RCT_EXPORT_MODULE()

@end
@interface RCT_EXTERN_MODULE(AdpaymentModule, NSObject)

 +(BOOL)requiresMainQueueSetup
 {
   return YES;
 }

 RCT_EXTERN_METHOD(encryptCard:(NSString) cardNumber
 expiryMonth:(NSString)expiryMonth
 expiryYear:(NSString) expiryYear
 securityCode:(NSString) securityCode
 publicKey:(NSString) publicKey
 resolver:(RCTPromiseResolveBlock)resolve
 rejecter:(RCTPromiseRejectBlock)reject)
@end
