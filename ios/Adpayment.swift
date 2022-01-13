import Adyen
import Foundation
import SafariServices

@objc(Adpayment)
class Adpayment: NSObject, ActionComponentDelegate, PresentationDelegate {
    func present(component: PresentableComponent) {
        
    }
    
    func didOpenExternalApplication(_ component: ActionComponent) {
        
    }
    
    func didProvide(_ data: ActionComponentData, from component: ActionComponent) {
        
    }
    
    func didComplete(from component: ActionComponent) {
        
    }
    
    func didFail(with error: Error, from component: ActionComponent) {
        
    }
    
    @objc func openRedirect(_ redirectData: String, clientKey: String) {
        let actionComponent: AdyenActionComponent = {
            let apiContext = APIContext(environment: Environment.test, clientKey: clientKey)
            let component = AdyenActionComponent(apiContext: apiContext)
            component.delegate = self
            component.presentationDelegate = self
            return component
        }()
        let data = Data(redirectData.utf8)
        let action = try! JSONDecoder().decode(Action.self, from: data)
        actionComponent.handle(action)
    }

    @objc func encrypt(_ cardNumber: String,
                           expiryMonth:String,
                           expiryYear:String,
                           securityCode:String,
                           publicKey: String,
                           resolver resolve: RCTPromiseResolveBlock,
                           rejecter reject: RCTPromiseRejectBlock)  {
        let card = Card(number: cardNumber,
                                      securityCode: securityCode,
                                      expiryMonth:  expiryMonth,
                                      expiryYear: expiryYear)
     do {
         let encryptedCard = try CardEncryptor.encrypt(card: card, with: publicKey)
          
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
}
