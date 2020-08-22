# voidpass

A flexible password manager for dealing with stateful and stateless password profiles.

voidpass has two main features:

1. New passwords generated are stateless meaning that the password is never saved, encrypted or otherwise. Passwords can be generated on any machine running voidpass only requiring a website, username, and a master password.
2. Existing passwords are encrypted (AES SIC) and the ciphertext is saved. This allows existing passwords to be migrated over if desired.

# Dependencies

- Dart 2.7.1
- [encrypt](https://pub.dev/packages/encrypt)
- [crypto](https://pub.dev/packages/crypto)

# Build the CLI

`make build-cli`

# Running the tests

`make test`

# Usage

```
Usage: ./voidpass <command>

voidpass commands

generate - Generates a new password profile (does not save password)
add - Adds an existing password (encrypts password and saves to file)
delete - Remove a password profile
list - Lists metadata for all passwords
search - Searches through password profile file and returns relevent profile entries
retrieve - Retrieves profile entry and reveals password
help - Shows this menu
```
