package com.reactnativeadpayment;

import android.content.Context;

import androidx.annotation.NonNull;

import com.adyen.checkout.base.model.payments.response.Action;
import com.adyen.checkout.core.api.Environment;
import com.adyen.checkout.redirect.RedirectComponent;
import com.adyen.checkout.redirect.RedirectConfiguration;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;
import com.adyen.checkout.cse.Card;
import com.adyen.checkout.cse.CardEncryptor;
import com.adyen.checkout.cse.EncryptedCard;
import com.adyen.checkout.cse.internal.CardEncryptorImpl;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.WritableNativeMap;
import android.support.v4.app.FragmentActivity;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Locale;

@ReactModule(name = AdpaymentModule.NAME)
public class AdpaymentModule extends ReactContextBaseJavaModule {
  public static final String NAME = "Adpayment";
  public Context context;

  public AdpaymentModule(ReactApplicationContext reactContext) {
    super(reactContext);

    this.context = reactContext;
  }

  @Override
  @NonNull
  public String getName() {
    return NAME;
  }


  @ReactMethod void openRedirect(String publicKey, String paymentResponse) {
    JSONObject redirectData = null;
    try {
      redirectData = new JSONObject(paymentResponse);
    } catch (JSONException e) {
      e.printStackTrace();
    }
     Action action = Action.SERIALIZER.deserialize(redirectData);
     RedirectConfiguration redirectConfiguration = new RedirectConfiguration.Builder(Locale.ENGLISH, Environment.EUROPE)
       .setClientKey(publicKey)
       .build();


     RedirectComponent redirectComponent = RedirectComponent.PROVIDER.get((FragmentActivity)getCurrentActivity(), redirectConfiguration);

     redirectComponent.handleAction(this.getCurrentActivity(), action);
   }

  @ReactMethod
  public void encrypt(String number, String cvc, String expiryMonth, String expiryYear,
                      String publicKey, Promise promise) {
    CardEncryptor encryptor = new CardEncryptorImpl();
    Card card = new Card.Builder()
      .setNumber(number)
      .setSecurityCode(cvc)
      .setExpiryDate(Integer.parseInt(expiryMonth), Integer.parseInt(expiryYear))
      .build();

    EncryptedCard encryptedCard = encryptor.encryptFields(card, publicKey);

    WritableNativeMap encryptedCardMap = new WritableNativeMap();
    encryptedCardMap.putString("encryptedCardNumber", encryptedCard.getEncryptedNumber());
    encryptedCardMap.putString("encryptedSecurityCode", encryptedCard.getEncryptedSecurityCode());
    encryptedCardMap.putString("encryptedExpiryMonth", encryptedCard.getEncryptedExpiryMonth());
    encryptedCardMap.putString("encryptedExpiryYear", encryptedCard.getEncryptedExpiryYear());
    promise.resolve(encryptedCardMap);
  }
}
