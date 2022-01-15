import { NativeModules, Platform } from 'react-native';
import type { Card } from './types';

const AdyenPayment = NativeModules.Adpayment;

export const encryptCard = (card: Card, publicToken: string) => {
  const { number, cvc, expiryMonth, expiryYear } = card;

  return AdyenPayment.encrypt(
    number,
    cvc,
    expiryMonth,
    expiryYear,
    publicToken
  );
};

export const openRedirect = (data: any, publicKey: string) => {
  return AdyenPayment.openRedirect(data, publicKey);
};

export const closeRedirect = () => {
  if (Platform.OS === 'ios') return AdyenPayment.closeRedirect();
};

export const redirectDidCancel = () => {
  if (Platform.OS === 'ios') return AdyenPayment.redirectDidCancel();
};

export default {
  encryptCard,
};
