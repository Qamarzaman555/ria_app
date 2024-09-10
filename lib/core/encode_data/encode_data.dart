import 'dart:convert';
import 'dart:typed_data';

import '../../common/custom_snackbar/custom_snackbar.dart';

class EncodeWrite {
  List<int> uInt8(String values) {
    List<int> converted = [];
    bool checkBig = false;
    try {
      List<String> split = values.split(',');
      List<int> con = [];
      for (int j = 0; j < split.length; j++) {
        int p = int.parse(split[j]);
        if (p > 255 || p < 0) {
          checkBig = true;
        }
        con.add(p);
      }
      if (checkBig == false) {
        ByteData bData = Uint8List.fromList(con).buffer.asByteData();
        for (int i = 0; i <= con.length - 1; i++) {
          converted.add(bData.getUint8(i));
        }
      } else {
        showToast('Large value detected');
      }
    } catch (e) {
      showToast('Wrong data type');
    }
    return converted;
  }

  List<int> uInt16L(String values) {
    // uint-16 little endian method
    List<int> converted = [];

    bool checkBig = false;
    try {
      List<String> split = values.split(',');
      List<int> con = [];
      for (int j = 0; j < split.length; j++) {
        int p = int.parse(split[j]);
        if (p > 65535 || p < 0) {
          checkBig = true;
        }
        con.add(p);
      }
      if (checkBig == false) {
        ByteData bData = Uint16List.fromList(con).buffer.asByteData();
        for (int i = 0; i <= con.length * 2 - 1; i++) {
          converted.add(bData.getUint8(i));
        }
      } else {
        showToast('Large value detected');
      }
    } catch (e) {
      showToast('Wrong data type');
    }
    return converted;
  }

  List<int> uInt16B(String values) {
    // uint-16 method big endian
    List<int> converted = [];
    bool checkBig = false;
    try {
      List<String> split = values.split(',');
      List<int> con = [];
      List temp = [];
      for (int j = 0; j < split.length; j++) {
        int p = int.parse(split[j]);
        if (p > 65535 || p < 0) {
          checkBig = true;
        }
        con.add(p);
      }
      if (checkBig == false) {
        ByteData bData = Uint16List.fromList(con).buffer.asByteData();
        for (int i = 0; i <= con.length * 2 - 1; i++) {
          var u8 = bData.getUint8(i);
          temp.add(u8);
          if (temp.length == 2) {
            converted.add(temp[1]);
            converted.add(temp[0]);
            temp = [];
          }
        }
      } else {
        showToast('Large value detected');
      }
    } catch (e) {
      showToast('Wrong data type');
    }
    return converted;
  }

  List<int> uInt32B(String values) {
    // uint 32 method big endian
    List<int> converted = [];
    bool checkBig = false;
    try {
      List<String> split = values.split(',');
      List<int> con = [];
      List temp = [];
      for (int j = 0; j < split.length; j++) {
        int p = int.parse(split[j]);
        if (p > 4294967295 || p < 0) {
          checkBig = true;
        }
        con.add(p);
      }
      if (checkBig == false) {
        ByteData bData = Uint32List.fromList(con).buffer.asByteData();
        for (int i = 0; i <= con.length * 4 - 1; i++) {
          var u8 = bData.getUint8(i);
          temp.add(u8);
          if (temp.length == 4) {
            converted.add(temp[3]);
            converted.add(temp[2]);
            converted.add(temp[1]);
            converted.add(temp[0]);
            temp = [];
          }
        }
      } else {
        showToast('Large value detected');
      }
    } catch (e) {
      showToast('Wrong data type');
    }
    return converted;
  }

  List<int> uInt32L(String values) {
    // uint 32 method little endian
    List<int> converted = [];
    bool checkBig = false;
    try {
      List<String> split = values.split(',');
      List<int> con = [];
      for (int j = 0; j < split.length; j++) {
        int p = int.parse(split[j]);
        if (p > 4294967295 || p < 0) {
          checkBig = true;
        }
        con.add(p);
      }
      if (checkBig == false) {
        ByteData bData = Uint32List.fromList(con).buffer.asByteData();
        for (int i = 0; i <= con.length * 4 - 1; i++) {
          converted.add(bData.getUint8(i));
        }
      } else {
        showToast('Large value detected');
      }
    } catch (e) {
      showToast('Wrong data type');
    }
    return converted;
  }

  List<int> string(String values) {
    List<int> converted = [];
    try {
      converted = utf8.encode(values);
      return converted;
    } catch (e) {
      showToast('Error! wrong data type selected');
      return [];
    }
  }

  List<int> hex(String values) {
    List<int> converted = [];
    try {
      List<String> split = values.split(',');
      for (int j = 0; j < split.length; j++) {
        var en = utf8.encode(split[j]);
        for (int i = 0; i < en.length; i++) {
          converted.add(en[i]);
        }
      }
    } catch (e) {
      showToast('Error! wrong data type selected');
    }
    return converted;
  }

  List<int> byteArray(String values) {
    List<int> converted = [];
    try {
      List<String> split = values.split(',');
      for (int i = 0; i < split.length; i++) {
        converted.add(int.parse(split[i]));
      }
    } catch (e) {
      showToast('Wrong input');
    }
    return converted;
  }
}
