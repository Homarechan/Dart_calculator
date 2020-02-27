import 'lib/tokenizer.dart';
import 'lib/parser.dart';

void main() {
  Tokenizer tokenizer = Tokenizer("1 + 1");
  tokenizer.tokenize();

  Parser parser = Parser(tokenizer.tokenlist);
  print(parser.expr());
}
