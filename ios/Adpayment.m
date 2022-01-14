#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_MODULE(Adpayment, NSObject)

RCT_EXTERN_METHOD(encrypt:(NSString) cardNumber
 expiryMonth:(NSString)expiryMonth
 expiryYear:(NSString) expiryYear
 securityCode:(NSString) securityCode
 publicKey:(NSString) publicKey
 resolver:(RCTPromiseResolveBlock)resolve
 rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(openRedirect:(NSString) redirectData
 clientKey:(NSString) clientKey)

@end

