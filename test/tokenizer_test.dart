import 'package:test/test.dart';

import '../lib/shelf.dart';

main() {
  test("Tokenizer.tokenize() tokenize the string to list of TokenInstance", () {
    String string = "1 + 1";
    Tokenizer tokenizer = Tokenizer(string);
    tokenizer.tokenize();
    expect(tokenizer.tokenlist, [
      TokenInstance(Token.Number, "1", 1, 1),
      TokenInstance(Token.Operator, "+", 0, 1),
      TokenInstance(Token.Number, "1", 1, 1)
    ]);
  });
}
