import { NativeModules } from 'react-native';
import type { Card } from './types';

const AdyenPayment = NativeModules.AdyenPayment;

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

export default {
  encryptCard,
};
