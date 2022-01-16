import Adyen
import Foundation
import SafariServices

@objc(Adpayment)
class Adpayment: RCTEventEmitter, PresentationDelegate, ActionComponentDelegate {
    var redirectComponent: RedirectComponent?
    var redirectCanceled = false;
    
    func present(component: PresentableComponent, disableCloseButton: Bool) {
        print("present")
        print(disableCloseButton)
    }
    
    func didOpenExternalApplication(_ component: ActionComponent) {
        print("didOpenExternalApplication")
        print(component)
    }
    
    func didProvide(_ data: ActionComponentData, from component: ActionComponent) {
        print("didProvide")
        print(data)
    }
    
    func didComplete(from component: ActionComponent) {
    }
    
    func didFail(with error: Error, from component: ActionComponent) {
        if((error as? ComponentError) == .cancelled) {
            self.redirectCanceled = true
        }
    }
    
    func present(component: PresentableComponent) {
        
    }
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc func closeRedirect() {
        DispatchQueue.main.async {
            if(self.redirectComponent != nil) {
                self.redirectComponent?.dismiss(true, completion: nil)
            }
        }
    }

    @objc func redirectDidCancel(_ resolve: RCTPromiseResolveBlock, rejecter reject: RCTPromiseRejectBlock) {
        resolve(self.redirectCanceled)
        if(self.redirectCanceled) {
            self.redirectCanceled = false;
        }
    }
    
    @objc func openRedirect(_ redirectData: String, clientKey: String) {
        self.redirectCanceled = false
        let json = redirectData.data(using: .utf8)!
        let action = try! JSONDecoder().decode(RedirectAction.self, from: json)
        let redirect = RedirectComponent();
        redirect.delegate = self
        redirect.clientKey = clientKey
        self.redirectComponent = redirect
        DispatchQueue.main.async {
            self.redirectComponent!.handle(action)
        }
    }

    @objc func encrypt(_ cardNumber: String,
                           securityCode:String,
                           expiryMonth:String,
                           expiryYear:String,
                           publicKey: String,
                           resolver resolve: RCTPromiseResolveBlock,
                           rejecter reject: RCTPromiseRejectBlock)  {
        let card = CardEncryptor.Card(number: cardNumber,
                                      securityCode: securityCode,
                                      expiryMonth:  expiryMonth,
                                      expiryYear: expiryYear)
     do {
         let encryptedCard = try CardEncryptor.encryptedCard(for: card, publicKey: publicKey)
          
          let resultMap:Dictionary? = [
            "encryptedCardNumber":encryptedCard.number,
            "encryptedExpiryMonth":encryptedCard.expiryMonth,
            "encryptedExpiryYear":encryptedCard.expiryYear,
            "encryptedSecurityCode":encryptedCard.securityCode,
          ]
          resolve(resultMap)
     } catch _ {
         print("Not me error")
     }
    }
    
    override func supportedEvents() -> [String]! {
        return [
            "onError",
            "onSuccess"
        ]
    }
}
