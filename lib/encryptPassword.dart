import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

String encryptPassword(String password, String rawKey, {bool decrypt: false}) {
  final Digest hashedKey = md5.convert(utf8.encode(rawKey));
  final Key key = Key.fromUtf8("${hashedKey}");
  final IV iv = IV.fromLength(16);
  final Encrypter encrypter = Encrypter(AES(key));

  if (!decrypt) {
    final encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64;
  }

  try {
    final Encrypted encrypted = Encrypted.fromBase64(password);
    return encrypter.decrypt(encrypted, iv: iv);
  } catch (e) {
    return null;
  }
}

String decryptPassword(String password, String key) {
  return encryptPassword(password, key, decrypt: true);
}
