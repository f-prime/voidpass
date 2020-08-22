import '../lib/createPassword.dart';

void testGeneratePassword() {
  const String pw = "*33*33*33*33*33";

  String password = generatePassword([60, 62, 65], 15, "abc123*()");
  print("TGP ${password} ${password == pw}");
}

void testGenerateSeed() {
  const List<int> correctSeed = [
    15,
    216,
    239,
    153,
    162,
    139,
    5,
    76,
    154,
    57,
    232,
    18,
    19,
    143,
    67,
    149,
    197,
    128,
    191,
    112,
    254,
    118,
    145,
    251,
    174,
    255,
    42,
    223,
    246,
    12,
    154,
    32
  ];
  List<int> seed = generateSeed("password", "test", "test.com");

  print("TGS ${correctSeed.toString() == seed.toString()}");
}

void testCreatePassword() {
  const String pw1 = '"qU~ucPHF|m9BP9LD=1F';
  const String pw2 = "TC1[Q)a^\\pb`&L\\)U5V\\";
  const String pw3 = "KOZ^?k9`rke)PO3*r\\Yj";
  const String pw4 = ':*{sJy/StUV`"]*<jf;P';
  const String pw5 = "x]m/-:kz\$}x|<!ir+'qb";
  const String pw6 = "')\\+/\$):2`9-}0;#5`2#";

  String password1 = createPassword(
    "test1",
    "test1.com",
    "password1",
  );

  String password2 = createPassword(
    "test2",
    "test2.com",
    "password2",
  );

  String password3 = createPassword(
    "test3",
    "test3.com",
    "password3",
  );

  String password4 =
      createPassword("test4", "test4.com", "password4", digits: false);

  String password5 = createPassword(
    "test5",
    "test5.com",
    "password5",
    digits: false,
    uppercase: false,
  );

  String password6 = createPassword(
    "test6",
    "test6.com",
    "password6",
    uppercase: false,
    lowercase: false,
  );

  print("TCP1 ${password1} ${pw1 == password1}");
  print("TCP2 ${password2} ${pw2 == password2}");
  print("TCP3 ${password3} ${pw3 == password3}");
  print("TCP4 ${password4} ${pw4 == password4}");
  print("TCP5 ${password5} ${pw5 == password5}");
  print("TCP6 ${password6} ${pw6 == password6}");
}
