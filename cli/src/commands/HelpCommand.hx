package commands;

class HelpCommand {
    static var commands:Array<Array<String>> = [
        ["help", "Show all the commands"],
        ["build", "Builds the application"],
        ["test", "Builds and test the application"],
        ["display", "Generates a hxml file + the Main Entry point for the program"]
    ];
    public static function command() {
        Sys.println('List of tuna commands:');
        for (command in commands){
            Sys.println('${command[0]}: ${command[1]}');
        }
    }
}