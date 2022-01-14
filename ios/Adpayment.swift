import Adyen
import Foundation
import SafariServices

@objc(Adpayment)
class Adpayment: RCTEventEmitter, PresentationDelegate, ActionComponentDelegate {
    func present(component: PresentableComponent, disableCloseButton: Bool) {
        
    }
    
    func didOpenExternalApplication(_ component: ActionComponent) {
        
    }
    
    func didProvide(_ data: ActionComponentData, from component: ActionComponent) {
        
    }
    
    func didComplete(from component: ActionComponent) {
        
    }
    
    func didFail(with error: Error, from component: ActionComponent) {
        
    }
    
    func present(component: PresentableComponent) {
        
    }
    
    var redirectComponent: RedirectComponent?
    
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc func openRedirect(_ redirectData: String, clientKey: String) {
        let json = redirectData.data(using: .utf8)!
        let action = try! JSONDecoder().decode(RedirectAction.self, from: json)
        let redirectComponent = RedirectComponent();
        redirectComponent.delegate = self
        redirectComponent.clientKey = clientKey
        self.redirectComponent = redirectComponent
        DispatchQueue.main.async {
            redirectComponent.handle(action)
        }
    }

    @objc func encrypt(_ cardNumber: String,
                           expiryMonth:String,
                           expiryYear:String,
                           securityCode:String,
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
