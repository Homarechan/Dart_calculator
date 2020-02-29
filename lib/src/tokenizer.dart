library tokeniser;

import 'tokens.dart';

import 'dart:io';

class Tokenizer {
  int position = 0;
  List<TokenInstance> tokenlist = [];
  String src;

  Tokenizer(this.src);

  String get now => this.src[this.position];
  bool get isNowDigit => int.tryParse(this.now) != null;

  tokenize() {
    while (this.position < this.src.length) {
      // switch (src[position])
      if (this.now == " ") {
        this.position++;
        continue;
      }

      if (this.now == "(") {
        this.position++;
        this.tokenlist.add(TokenInstance(Token.LeftBracket, "(", 0, 1));
        continue;
      }

      if (this.now == ")") {
        this.position++;
        this.tokenlist.add(TokenInstance(Token.RightBracket, ")", 0, 1));
        continue;
      }

      if ("+-*/^".contains(this.now)) {
        this.addOperator();
        continue;
      }

      if (this.isNowDigit) {
        this.addNumber();
        continue;
      }

      print("Unknown charactor (${this.now}) at ${this.position}");
      exit(1);
    }
  }

  addOperator() {
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
    this.position++;
  }

  addNumber() {
    String result = "";

    while (this.position < this.src.length && this.isNowDigit) {
      result += this.now;
      this.position++;
    }

    this.tokenlist.add(
        TokenInstance(Token.Number, result, int.parse(result), result.length));
  }
}
