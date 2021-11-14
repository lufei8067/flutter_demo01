import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:typed_data';

class Utils {
  //md5加密
  static String MD5(String data) {
    return md5.convert(utf8.encode(data)).toString();
  }

  //获取本地时间戳
  static int GetTimeStamp() {
    return (new DateTime.now().millisecondsSinceEpoch * 0.001).toInt();
  }

  static String ToFurDigits(int n) {
    int absN = n.abs();
    String sign = n < 0 ? "-" : "";
    if (absN >= 1000) return "$n";
    if (absN >= 100) return "${sign}0$absN";
    if (absN >= 10) return "${sign}00$absN";
    return "${sign}000$absN";
  }

  static String ToThreeDigits(int n) {
    if (n >= 100) return "${n}";
    if (n >= 10) return "0${n}";
    return "00${n}";
  }

  static String ToTwoDigits(int n) {
    if (n >= 10) return "${n}";
    return "0${n}";
  }

  static String ToHex(Uint8List bArr) {
    int length;
    if (bArr == null || (length = bArr.length) <= 0) {
      return "";
    }
    Uint8List cArr = new Uint8List(length << 1);
    int i = 0;
    for (int i2 = 0; i2 < length; i2++) {
      int i3 = i + 1;
      var cArr2 = [
        '0',
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        'A',
        'B',
        'C',
        'D',
        'E',
        'F'
      ];

      var index = (bArr[i2] >> 4) & 15;
      cArr[i] = cArr2[index].codeUnitAt(0);
      i = i3 + 1;
      cArr[i3] = cArr2[bArr[i2] & 15].codeUnitAt(0);
    }
    return new String.fromCharCodes(cArr);
  }
}
