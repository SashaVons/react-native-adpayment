#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_MODULE(Adpayment, NSObject)

RCT_EXTERN_METHOD(encrypt:(NSString) cardNumber
 securityCode:(NSString) securityCode
 expiryMonth:(NSString)expiryMonth
 expiryYear:(NSString) expiryYear
 publicKey:(NSString) publicKey
 resolver:(RCTPromiseResolveBlock)resolve
 rejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(openRedirect:(NSString) redirectData
 clientKey:(NSString) clientKey)

RCT_EXTERN_METHOD(redirectDidCancel:(RCTPromiseResolveBlock)resolve
 reject:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(closeRedirect)

@end

