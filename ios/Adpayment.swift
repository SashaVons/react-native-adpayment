import Adyen
import Foundation
import SafariServices

@objc(Adpayment)
class Adpayment: RCTEventEmitter, PresentationDelegate, ActionComponentDelegate {
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
        let apiContext = APIContext(environment: Environment.liveEurope, clientKey: clientKey)
        let json = redirectData.data(using: .utf8)!
        let action = try! JSONDecoder().decode(Action.self, from: json)
        lazy var actionComponent: AdyenActionComponent = {
            let handler = AdyenActionComponent(apiContext: apiContext)
            handler.delegate = self
            handler.presentationDelegate = self
            handler._isDropIn = true
            return handler
        }()
        print(action)
        DispatchQueue.main.async {
            actionComponent.handle(action)
        }
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
    
    override func supportedEvents() -> [String]! {
        return [
            "onError",
            "onSuccess"
        ]
    }
}
