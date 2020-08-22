CLI_COMPILER := dart2native
CLI_MAINFILE := cli/main.dart
CLI_OUTPUT := -o voidpass

TESTS_COMPILER := dart
TESTS_MAINFILE := tests/main.dart

build-cli:
	pub get && $(CLI_COMPILER) $(CLI_MAINFILE) $(CLI_OUTPUT)

test:
	pub get && $(TESTS_COMPILER) $(TESTS_MAINFILE)
