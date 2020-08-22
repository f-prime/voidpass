import 'dart:io';

import 'fileio.dart';

import '../lib/createPassword.dart';
import '../lib/encryptPassword.dart';

String input(String inputString, {bool hidden: false}) {
  stdout.write(inputString);
  stdin.echoMode = !hidden;
  final String input = stdin.readLineSync();
  if (hidden) {
    print("\n");
  }
  stdin.echoMode = true;

  return input;
}

void execSearch() async {
  final String search = input("Search: ");

  final Map data = await loadFile();

  data.forEach((key, value) {
    List results = [];
    value.forEach((item) {
      final String username = item["username"];
      final String searchable = "${key} ${username}";

      if (searchable.indexOf(search) > -1) {
        results.add(username);
      }
    });

    if (results.length > 0) {
      print("${key}:");
      print("  usernames:");
      results.forEach((username) => print("    ${username}"));
    }
  });
}

void execDelete() async {
  final String username = input("Username: ").trim();
  final String website = input("Website: ").trim();

  final Map data = await loadFile();

  final List websiteData = data[website];

  if (websiteData == null) {
    return;
  }

  List newWebsiteData = [];

  websiteData.forEach((item) {
    if (item["username"] != username) {
      newWebsiteData.add(item);
    }
  });

  data[website] = newWebsiteData;
  await saveFile(data);
}

void execHelp() {
  print("""
voidpass commands

generate - Generates a new password profile (does not save password)
add - Adds an existing password (encrypts password and saves to file)
delete - Remove a password profile
list - Lists metadata for all passwords
search - Searches through password profile file and returns relevent profile entries
retrieve - Retrieves profile entry and reveals password
help - Shows this menu
        """);
}

void execRetrieve() async {
  final String username = input("Username: ").trim();
  final String website = input("Website: ").trim();
  final String masterPassword = input("Master Password: ", hidden: true);

  final Map data = await loadFile();

  bool exists = false;

  final List websiteData = data[website];

  if (websiteData != null) {
    websiteData.forEach((item) {
      if (item["username"] == username) {
        String password;
        if (item["isGenerated"]) {
          final bool uppercase = item["uppercase"];
          final bool lowercase = item["lowercase"];
          final bool digits = item["digits"];
          final bool punctuation = item["punctuation"];
          final int length = item["length"];

          password = createPassword(
            username, 
            website, 
            masterPassword,
            uppercase: uppercase,
            lowercase: lowercase,
            digits: digits,
            punctuation: punctuation,
            length: length
          );
        } else {
          password = decryptPassword(item["cipherText"], masterPassword);
        }

        print("\nPassword: ${password}");
        exists = true;
      }
    });
  }

  if (!exists) {
    print("Password profile does not exist.");
  }
}

void execList() async {
  final Map file = await loadFile();
  if (file.toString() == "{}") {
    print("You have not created any password profiles yet.");
    return;
  }

  file.forEach((key, value) {
    print("${key}:");

    if (value.length == 0) {
      print("   There are no profiles under this website.");
      return;
    }

    print("  usernames:");
    value.forEach((item) {
      final String username = item["username"];
      final String isSaved = !item["isGenerated"] ? "is" : "is not";

      print("    ${username} (${isSaved} saved)");
    });
  });
}

void execAdd() async {
  final String username = input("Username: ").trim();
  final String website = input("Website: ").trim();
  final String masterPassword = input("Master Password: ", hidden: true);
  final String password = input("Password: ", hidden: true);

  if (username.length == 0) {
    print("Username cannot be empty");
    return;
  }

  if (website.length == 0) {
    print("Website cannot be empty");
    return;
  }

  if (masterPassword.length < 8) {
    print("Master Password cannot be less than 8 chars");
    return;
  }

  if (password.length == 0) {
    print("Password cannot be empty");
    return;
  }

  final String encryptedPwd = encryptPassword(password, masterPassword);

  print("Password saved!");

  await addFileEntry(
      username: username,
      website: website,
      length: -1,
      cipherText: encryptedPwd,
      isGenerated: false);
}

void execGenerate() async {
  final String username = input("Username: ");
  final String website = input("Website: ");
  final String masterPassword = input("Master Password: ", hidden: true);
  final bool digits =
      input("Include digits?[yes]: ").toLowerCase().trim() != "no";
  final bool uppercase =
      input("Include uppercase?[yes]: ").toLowerCase().trim() != "no";
  final bool lowercase =
      input("Include lowercase?[yes]: ").toLowerCase().trim() != "no";
  final bool punctuation =
      input("Include punctuation?[yes]: ").toLowerCase().trim() != "no";
  final String lengthInp = input("Length[20]: ");
  final int length = lengthInp.length > 0 ? int.parse(lengthInp) : 20;

  if (username.length == 0) {
    print("Username cannot be empty");
    return;
  }

  if (website.length == 0) {
    print("Website cannot be empty");
    return;
  }

  if (masterPassword.length < 8) {
    print("Master Password cannot be less than 8 chars");
    return;
  }

  final String password = createPassword(
    username,
    website,
    masterPassword,
    digits: digits,
    uppercase: uppercase,
    lowercase: lowercase,
    punctuation: punctuation,
    length: length,
  );

  print("\nPassword: ${password}");

  await addFileEntry(
    username: username,
    website: website,
    length: length,
    isGenerated: true,
    uppercase: uppercase,
    lowercase: lowercase,
    punctuation: punctuation,
    digits: digits,
  );
}
