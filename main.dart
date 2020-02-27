import 'lib/tokenizer.dart';
import 'lib/parser.dart';

import 'dart:io';

void main() {
  Tokenizer tokenizer;
  Parser parser;

  while (true) {
    tokenizer = Tokenizer(stdin.readLineSync());
    tokenizer.tokenize();

    parser = Parser(tokenizer.tokenlist);
    print(parser.expr());
  }
}
