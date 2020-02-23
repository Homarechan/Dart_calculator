import 'dart:io';
import 'lib/test.dart' as t;

void main() {
  t.Parser parser;
  while (true) {
    stdout.write("> ");
    parser = t.Parser(stdin.readLineSync(retainNewlines: true));
    print(parser.expr());
  }
}
