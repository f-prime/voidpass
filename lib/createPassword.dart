import 'package:crypto/crypto.dart';
import "dart:math" show Random;
import "dart:convert";

const String UPPERCASE = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
const String LOWERCASE = "abcdefghijklmnopqrstuvwxyz";
const String DIGITS = "1234567890";
const String PUNCTUATION = "!\"#\$%&\'()*+,-./:;<=>?@[\\]^_`{|}~";

String generatePassword(List<int> seed, int length, String charChoices) {
  String password = "";

  for (int i = 0; i < length; i += 1) {
    final int seedOn = seed[i % seed.length];
    final Random randomizer = Random(seedOn);
    final int charIndex = randomizer.nextInt(charChoices.length);
    password = "${password}${charChoices[charIndex]}";
  }

  return password;
}

List<int> generateSeed(String masterPass, String name, String domain) {
  final String trimmedName = name.trim();
  final String trimmedDomain = domain.trim();

  final List<int> stringSeed = utf8.encode("${masterPass}${name}${domain}");
  final hashed = sha256.convert(stringSeed);

  return hashed.bytes;
}

String createPassword(String name, String domain, String masterPass,
    {bool uppercase: true,
    bool lowercase: true,
    bool digits: true,
    bool punctuation: true,
    int length: 20}) {
  String charChoices = "";

  // WARNING: Changing the order in which charChoices is built will completely break all generated passwords.

  if (uppercase) {
    charChoices = "${charChoices}${UPPERCASE}";
  }
  if (lowercase) {
    charChoices = "${charChoices}${LOWERCASE}";
  }
  if (digits) {
    charChoices = "${charChoices}${DIGITS}";
  }
  if (punctuation) {
    charChoices = "${charChoices}${PUNCTUATION}";
  }

  final List<int> seed = generateSeed(masterPass, name, domain);

  final String password = generatePassword(seed, length, charChoices);

  return password;
}
