enum Token { Number, Operator }

class TokenInstance {
  Token token;
  String str;
  int length;

  TokenInstance(this.token, this.str, this.length);
}
