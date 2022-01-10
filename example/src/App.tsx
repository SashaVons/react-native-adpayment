import * as React from 'react';

import { StyleSheet, View, Text } from 'react-native';
import { encryptCard } from 'react-native-adpayment';

export default function App() {
  const [result, setResult] = React.useState<any>();

  React.useEffect(() => {
    encryptCard(
      {
        number: '4111111111111111',
        cvc: '373',
        expiryMonth: '03',
        expiryYear: '30',
      },
      '10001|A7A884D1E395A22CD903B604D44F3A5928B0E4F642CA3F0784231A323B0374F1CC58DA6B6B08717441CEC1FBD35F1555D75959CA42AFF14995DDC62EA662AF6866223E5BCCCF82451A29053811FE4F3355175FE7571095CE11836FFC7372F791D518761CE9042B2ADEF6A49BA293D34FD1D05CAB1D9291E4989CD1D2198BE9C7A9115863F72CF17FD68F4ADB436B5757281E46CD36E92CAFF70EC7D0D964DDEFC2E7017BD2079F7184592B7541298D4CB76199568952A0871B6BA1CBD29B14AC2BFF003076408F81E7C6938EB5B27706B0924A220E489CA2C07AD66E6CDCCAE898C1CB1F1FF9FFA6D613141FF6AC12D44792E70549699D7446511C5375A197E7'
    ).then((e: any) => {
      console.log(e);
      setResult(e);
    });
  }, []);

  return (
    <View style={styles.container}>
      <Text>Result: {result}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
