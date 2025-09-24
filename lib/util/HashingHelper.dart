import 'dart:convert';
import 'package:crypto/crypto.dart';

class Hashinghelper {
  String hashString(String input) {
    final bytes = utf8.encode(input); // convert string to bytes
    final digest = sha256.convert(bytes); // hash bytes
    return digest.toString();
  }
}
