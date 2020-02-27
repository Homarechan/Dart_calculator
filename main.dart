import 'lib/tokenizer.dart';

void main() {
  Tokenizer tokenizer = Tokenizer("1 + 1");
  tokenizer.tokenize();
  print(tokenizer.tokenlist[1].str);
}
