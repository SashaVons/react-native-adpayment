#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(Adpayment, NSObject)

 RCT_EXTERN_METHOD(encryptCard:(NSString) cardNumber
 expiryMonth:(NSString)expiryMonth
 expiryYear:(NSString) expiryYear
 securityCode:(NSString) securityCode
 publicKey:(NSString) publicKey
 resolver:(RCTPromiseResolveBlock)resolve
 rejecter:(RCTPromiseRejectBlock)reject)

@end
