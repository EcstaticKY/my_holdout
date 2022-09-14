import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Same string should be equal', () {
    final s0 = '2b0eb2272ba0b4ba0e540616b83598ac';
    final s1 = '2b0eb2272ba0b4ba0e540616b83598ac';

    expect(s0 != s1, false);
  });
}
