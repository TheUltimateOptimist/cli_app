import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path/path.dart';

void main(List<String> arguments) async{
  await runApp();
}

String? input(String message){
  stdout.write(message);
  return stdin.readLineSync();
}

Future<void> runApp() async{
  printUnderlined("Wilkommen zu diesem Tool!\n");
  print('Um mehr zu erfahren gebe den Befehl "hilfe" ein.\n');
  while(true){
    String? userInput = input(">: ");
    if(userInput == "berechne"){
      await execute();
    }
    else if(userInput == "hilfe"){
      print("Irgendein Text der die Befehle erklärt.");
    }
    else if(userInput == "exit"){
      return;
    }
    else{
      print("ERROR: Unbekannter Befehl!");
    }
  }
}

Future<void> execute() async{
  await printProgressIndicator("Erstelle Excel Datei", 10);
  var excel = Excel.createExcel();
  excel.sheets["Sheet1"]?.updateCell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), 100);
  var encoded = excel.encode();
  const String fileName = "test.xlsx";
  File(fileName)..createSync()..writeAsBytesSync(encoded!);
  print("\x1B[38;5;154m$fileName(Excel) wurde erfolgreich erstellt\x1B[0m");
  print("\x1B[38;5;154mDu findes $fileName unter: $current\x1B[0m");
}

Future<void> printProgressIndicator(String message, int seconds, [List<String> symbols = const [".", "..", "..."]]) async{
  int index = 0;
  for(int i = 0; i < seconds; i++){
    if(!(index < symbols.length)){
      index = 0;
    }
    stdout.write(message + " " + symbols[index]);
    index++;
    await Future.delayed(Duration(milliseconds: 500));
    stdout.write("\x1B[2K\r");
  }
}

void printBold(String text){
  printStyled(text, 1);
}

void printItalic(String text){
  printStyled(text, 3);
}

void printUnderlined(String text){
  printStyled(text, 4);
}

void printReversed(String text){
  printStyled(text, 7);
}

void printInvisible(String text){
  printStyled(text, 8);
}
void printStrikethrough(String text){
  printStyled(text, 9);
}







void printStyled(String text, int styleNumber){
  final int resetNumber;
  if(styleNumber == 1){
    resetNumber = 2;
  }
  else{
    resetNumber = styleNumber;
  }
  print("\x1B[${styleNumber}m");
  print("\x1B[2A");
  print(text);
  print("\x1B[2${resetNumber}m");
  print("\x1B[2A");
}


