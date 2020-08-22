import 'dart:io';
import 'dart:convert';

/*

File Structure

{
  <website>: [
    ...{
      "username":<string>,
      "length": <int>,
      "cipherText": <string?>,
      "isGenerated": <bool>,
      "uppercase": <bool>,
      "lowercase": <bool>,
      "punctuation": <bool>,
      "digits": <bool>
    }
  ]
}

*/

Future<Map> loadFile() async {
  final File dataFile = File("voidpass.db");
  if (!await dataFile.exists()) {
    return {};
  }

  return json.decode(await dataFile.readAsString());
}

Future<void> saveFile(Map data) async {
  final File dataFile = File("data.json");
  dataFile.writeAsString(json.encode(data));
}

void addFileEntry({
  String username,
  String website,
  int length,
  String cipherText,
  bool isGenerated,
  bool uppercase: true,
  bool lowercase: true,
  bool punctuation: true,
  bool digits: true,
}) async {
  final Map data = await loadFile();

  bool exists = false;

  List websiteProfiles = data[website];

  if (websiteProfiles == null) {
    data[website] = [];
    websiteProfiles = data[website];
  } else {
    for (Map item in websiteProfiles) {
      if (item["username"] == username) {
        exists = true;
        break;
      }
    }
  }

  if (!exists) {
    data[website].add({
      "username": username,
      "length": length,
      "cipherText": cipherText,
      "isGenerated": isGenerated,
      "uppercase": uppercase,
      "lowercase": lowercase,
      "punctuation": punctuation,
      "digits": digits,
    });

    await saveFile(data);
  }
}
