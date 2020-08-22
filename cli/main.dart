import 'commands.dart';

void parseCommand(String command) async {
  switch (command.toLowerCase()) {
    case "generate":
      {
        execGenerate();
      }
      break;

    case "add":
      {
        execAdd();
      }
      break;

    case "delete":
      {
        execDelete();
      }
      break;

    case "list":
      {
        execList();
      }
      break;

    case "retrieve":
      {
        execRetrieve();
      }
      break;

    case "search":
      {
        execSearch();
      }
      break;

    case "help":
      {
        execHelp();
      }
      break;

    default:
      {
        print("Unrecognized command ${command}");
      }
  }
}

void main(List<String> args) async {
  if (args.length < 1) {
    print("Usage: ./voidpass <command>\n");
    parseCommand("help");
    return;
  }

  final String command = args[0];
  parseCommand(command);
}
