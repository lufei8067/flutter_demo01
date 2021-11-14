import 'dart:convert';
import 'dart:ffi';
import 'ByteUtils.dart';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'dart:math';
import 'Utils.dart';
import 'NetClient.dart';

export 'dart:typed_data';
export 'package:ffi/ffi.dart';

class ReceiveData extends Struct {
  @Int32()
  int iMsgLen;

  Pointer<Uint8> vtBuffer;
}

class MsgPacket {
  MsgPacket({this.pReceiveData = null, this.bEncryption = false}) {
    if (this.pReceiveData == null) {
      iMsgLen = 0;
      initWriter();
    } else {
      this.receiveData = this.pReceiveData.ref;
      iMsgLen = receiveData.iMsgLen;
      initReader();
    }
  }

  void initWithResponse(Response response, {bool bDecrypt = false}) {
    final Uint8List nativeString = response.bodyBytes;
    reader = ByteDataReader(endian: Endian.little);
    reader.add(nativeString);
    iMsgLen = nativeString.length;

    if (bDecrypt) {
      randDecrypt(nativeString);
    }
  }

  void destroy() {
    if (this.pReceiveData != null) {
      free(receiveData.vtBuffer);
      free(pReceiveData);
    }
  }

  //随机加密
  void randEncryption() {
    var rng = new Random();

    int iKey = rng.nextInt(999999) + Utils.GetTimeStamp();
    writeInt32(iKey); //key放在最后
    String strKey = iKey.toString();
    encryption(strKey);
  }

  void randDecrypt(final Uint8List nativeString) //解密随机加密
  {
    if (iMsgLen < 4) {
      return;
    }

    int iKey = reader.readDecryptKey();
    String strKey = iKey.toString();
    iMsgLen -= 4; //去掉最后的key
    int iKeyLen = strKey.length;

    for (int iIndex = 0; iIndex < iMsgLen; iIndex++) {
      nativeString[iIndex] ^= strKey.codeUnitAt(iIndex % iKeyLen);
    }
  }

  void encryption(String strKey) {
    int iKeyLen = strKey.length;
    if (iKeyLen > 0) {
      encryptionList = writer.toBytes();
      bEncryption = true;
      iMsgLen = encryptionList.length;
      for (int iIndex = 0; iIndex < iMsgLen - 4; iIndex++) {
        encryptionList[iIndex] ^= strKey.codeUnitAt(iIndex % iKeyLen);
//        mStorage[iIndex] ^= _strKey[iIndex%iKeyLen];
      }
    }
  }

  ReceiveData receiveData;
  ByteDataReader reader;
  ByteDataWriter writer;
  Pointer<ReceiveData> pReceiveData;

  int iOpcode;
  int iMsgLen;
  bool bEncryption; //是否已经加密
  Uint8List encryptionList; //已经加密的数据

  void initReader() {
    reader = ByteDataReader(endian: Endian.little);
    final Uint8List nativeString =
        receiveData.vtBuffer.asTypedList(receiveData.iMsgLen);
    reader.add(nativeString);
  }

  void initWriter() {
    writer = ByteDataWriter(endian: Endian.little);
  }

  void initSendMsg(int iOpcode) {
    this.iOpcode = iOpcode;
    writeUint16(iOpcode);
  }

  void initWithByteData(List<int> data) {
    reader = ByteDataReader(endian: Endian.little);
    reader.add(data);
  }

  void writeFloat32(double value) {
    writer.writeFloat32(value);
  }

  void writeString(String value) {
    writer.writeString(value ?? "");
  }

  //长度小于255的字符串
  void write255String(String value) {
    writer.write255String(value ?? "");
  }

  void writeFloat64(double value) {
    writer.writeFloat64(value);
  }

  void writeInt8(int value) {
    writer.writeInt8(value);
  }

  void writeInt16(int value) {
    writer.writeInt16(value);
  }

  void writeInt32(int value) {
    writer.writeInt32(value);
  }

  void writeInt64(int value) {
    writer.writeInt64(value);
  }

  void writeUint8(int value) {
    writer.writeUint8(value);
  }

  void writeCharByString(String value) {
    if (value.isEmpty)
      writer.writeUint8(0);
    else {
      var chL = Utf8Encoder().convert(value);
      writer.writeUint8(chL[0]);
    }
  }

  void writeBytes(Uint8List bytes) {
    writer.write(bytes);
  }

  void writeUint16(int value) {
    writer.writeUint16(value);
  }

  void writeUint32(int value) {
    writer.writeUint32(value);
  }

  void writeUint64(int value) {
    writer.writeUint64(value);
  }

  void writeBoolean(bool value) {
    writer.writeUint8(value ? 1 : 0);
  }

  String readString() {
    return reader.readString();
  }

  Uint8List readChar(int iLen) {
    return reader.read(iLen);
  }

  String readCharToString(int iLen) {
    return String.fromCharCodes(reader.read(iLen));
  }

  String readCString2() {
    int fact_len = 0;
    Uint8List val = readChar(1);
    if (val.isEmpty) return "";

    int data = val[0];
    final bitmask = (1 << 7);
    if ((data & bitmask) != 0) {
      fact_len = data & 0x7f;
      fact_len += readChar(1)[0] * 0x80;
    } else {
      fact_len = data;
    }

    if (fact_len <= 0) return "";
    return readCharToString(fact_len);
  }

  double readFloat32() {
    return reader.readFloat32();
  }

  double readFloat64() {
    return reader.readFloat64();
  }

  int readInt8() {
    return reader.readInt8();
  }

  int readInt16() {
    return reader.readInt16();
  }

  int readInt32() {
    return reader.readInt32();
  }

  int readInt64() {
    return reader.readInt64();
  }

  int readUint8() {
    return reader.readUint8();
  }

  int readUint16() {
    return reader.readUint16();
  }

  int readUint32() {
    return reader.readUint32();
  }

  int readUint64() {
    return reader.readUint64();
  }

  bool readBoolean() {
    return reader.readUint8() == 0 ? false : true;
  }

  int getOpcode() {
    if (iOpcode == null) {
      iOpcode = readUint16();
    }
    return iOpcode;
  }

  Pointer<Uint8> _bytesFromList(Uint8List ints) {
    final Pointer<Uint8> ptr = allocate(count: ints.length);
    final Uint8List list = ptr.asTypedList(ints.length);
    list.setAll(0, ints);
    return ptr;
  }

  Pointer<Uint8> getContent() {
    if (bEncryption) {
      return _bytesFromList(encryptionList);
    } else {
      Uint8List list = writer.toBytes();
      iMsgLen = list.length;
      return _bytesFromList(list);
    }
  }

  Uint8List getUint8Content() {
    if (bEncryption) {
      return encryptionList;
    } else {
      return writer.toBytes();
    }
  }
}
