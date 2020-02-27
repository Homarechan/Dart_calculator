import 'tokens.dart';

import 'dart:io';

class Tokenizer {
  int position = 0;
  List<TokenInstance> tokenlist = [];
  String src;

  Tokenizer(this.src);

  String get now => this.src[this.position];
  bool get isNowDigit => int.tryParse(this.now) != null;

  List<TokenInstance> tokenize() {
    List<TokenInstance> result = [];

    while (true) {
      // switch (src[position])
      if (this.now == " ") {
        this.position++;
        continue;
      }

      if ("+-*/^".contains(this.now)) {
        this.addOperator();
        continue;
      }

      if ("1234567890".contains(this.now)) {
        this.addNumber();
      }
    }
  }

  addOperator() {
    this.position++;
    switch (this.now) {
      case "+":
      case "-":
      case "/":
      case "^":
        tokenlist.add(TokenInstance(Token.Operator, this.now, 0, 1));
        break;
      case "*":
        switch (this.src[this.position + 1]) {
          case "*":
            this.position++;
            tokenlist.add(TokenInstance(Token.Operator, "**", 0, 2));
            break;
          default:
            tokenlist.add(TokenInstance(Token.Operator, "*", 0, 1));
        }
        break;
      default:
        print("Error");
        exit(1);
    }
  }

  addNumber() {
    String result = "";

    while ("1234567890".contains(this.now)) {
      result += this.now;
      this.position++;
    }

    this.tokenlist.add(
        TokenInstance(Token.Number, result, int.parse(result), result.length));
  }
}
