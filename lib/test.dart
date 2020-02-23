import 'dart:math';
import 'dart:io';

class Parser {
  int pos = 0;
  String src;

  Parser(this.src);

  String get now => this.src[this.pos];
  bool get isNowDigit => int.tryParse(this.now) != null;

  void error() {
    print("Unknown token at ${this.pos + 1}");
    exit(1);
  }

  void skipWhiteSpace() {
    while (this.now == ' ') {
      this.pos++;
    }
  }

  /**
   * expr ::= term
   *        | term '+' expr
   *        | term '-' expr
   *        ;
   */
  int expr() {
    int left = this.term();

    while (true) {
      switch (this.now) {
        case '+':
          this.pos++;
          return left + this.expr();
        case '-':
          this.pos++;
          return left - this.expr();
        case ' ':
          this.pos++;
          break;
        default:
          return left;
      }
    }
  }

  /**
   * term ::= factor
   *        | factor '*' term
   *        | factor '/' term
   *        ;
   */
  int term() {
    int left = this.factor();

    while (true) {
      switch (this.now) {
        case '*':
          this.pos++;
          if (this.now == '*') {
              this.pos++;
              return pow(left, this.term());
          }
          return left * this.term();
        case '/':
          this.pos++;
          return left ~/ this.term();
        case '^':
          this.pos++;
          return pow(left, this.term());
        case ' ':
          this.pos++;
          break;
        default:
          return left;
      }
    }
  }

  /**
   * factor ::= DIGIT
   *          | '(' expr ')'
   *          ;
   */
  int factor() {
    while (true) {
      switch (this.now) {
        case '(':
          this.pos++;
          int innerExpr = this.expr();

          if (this.now != ')') {
            this.error();
          }

          this.pos++;
          return innerExpr;

        case ' ':
          this.pos++;
          break;

        default:
          return this.digit();
      }
    }
  }

  /**
   * DIGIT ::= [1-9][0-9]+
   *         ;
   */
  int digit() {
    String result = "";

    while (this.isNowDigit) {
      result += this.now;
      this.pos++;
    }

    if (result.isNotEmpty) {
      return int.parse(result);
    }
    return 0;
  }
}
