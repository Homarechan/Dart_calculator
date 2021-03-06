library tokens;

enum Token { Number, Operator, LeftBracket, RightBracket }

class TokenInstance {
  Token token;
  String str;
  int number; // Set if token is Token.Number
  int length;

  TokenInstance(this.token, this.str, this.number, this.length);
}
