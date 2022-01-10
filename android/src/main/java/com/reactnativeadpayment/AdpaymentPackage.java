package com.reactnativeadpayment;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import com.facebook.react.ReactPackage;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.ViewManager;
import com.reactnativeadyenpayment.AdpaymentModule;

public class AdpaymentPackage implements ReactPackage {
  @Override
  public List<NativeModule> createNativeModules(ReactApplicationContext reactContext) {
    // return Arrays.<NativeModule>asList(new RNAdyenCryptModule(reactContext));
    return Arrays.asList(new NativeModule[]{
      new AdpaymentModule(reactContext)
    });
  }

    @Override
    public List<ViewManager> createViewManagers(ReactApplicationContext reactContext) {
        return Collections.emptyList();
    }
}
