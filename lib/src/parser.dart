/// A simple library which serve parser
library test;

import 'dart:math';
import 'dart:io';

import 'tokens.dart';

class Parser {
  int position = 0;
  List<TokenInstance> tokenlist;

  Parser(this.tokenlist);

  TokenInstance get now => this.tokenlist[this.position];

  ///
  /// expr ::= term
  ///        | term '+' expr
  ///        | term '-' expr
  ///        ;
  ///
  int expr() {
    int left = this.term();

    if (this.position + 1 >= this.tokenlist.length) {
      return left;
    }

    switch (this.now.str) {
      case '+':
        this.position++;
        return left + this.term();
      case '-':
        this.position++;
        return left - this.term();
    }

    return left;
  }

  ///
  /// term ::= factor
  ///        | factor '*' term
  ///        | factor '/' term
  ///        | factor '^' term
  ///        | factor '**' term
  ///        ;
  ///
  int term() {
    int left = this.factor();

    if (this.position + 1 >= this.tokenlist.length) {
      return left;
    }

    switch (this.now.str) {
      case "*":
        this.position++;
        return left * this.term();
      case "/":
        this.position++;
        int right = this.term();
        
        if (right == 0) {
          print("Can't devide by 0");
          exit(1);
        }
        
        return left ~/ right;
      case "**":
      case "^":
        this.position++;
        return pow(left, this.term());
    }
    return left;
  }

  ///
  /// factor ::= DIGIT
  ///          | '(' expr ')'
  ///          ;
  ///
  int factor() {
    switch (this.now.token) {
      case Token.LeftBracket:
        this.position++;
        int innerExpr = this.expr();

        if (this.now.token != Token.RightBracket) {
          print("Unpaired bracket");
          exit(1);
        }

        this.position++;
        return innerExpr;
      case Token.Number:
        return this.digit();
      default:
        print("Unexpexted token");
        exit(1);
    }
  }

  ///
  /// DIGIT ::= [1-9][0-9]+
  ///         ;
  ///
  int digit() {
    int now_ = this.now.number;
    this.position++;
    return now_;
  }
}
