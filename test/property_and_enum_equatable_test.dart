import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

class Inner {
  final int number;
  Inner({this.number});
}

class Outer extends Equatable {
  final int number;
  final Inner inner;
  Outer({this.number, this.inner});

  @override
  List<Object> get props => [number, inner];
}

class EquatableInner extends Equatable {
  final int number;
  EquatableInner({this.number});

  @override
  List<Object> get props => [number];
}

class AnotherOuter extends Equatable {
  final int number;
  final EquatableInner inner;
  AnotherOuter({this.number, this.inner});

  @override
  List<Object> get props => [number, inner];
}

class EnumContainer extends Equatable {
  final int number;
  final MyEnum myEnum;
  EnumContainer({this.number, this.myEnum});

  @override
  List<Object> get props => [number, myEnum];
}

enum MyEnum {
  created,
  joined,
}

void main() {
  test("Outers are not equal if Inner is not extended 'Equatable'", () {
    final Outer outer1 = Outer(number: 1, inner: Inner(number: 2));
    final Outer outer2 = Outer(number: 1, inner: Inner(number: 2));
    expect(outer1 != outer2, true);
  });

  test("AnotherOuters are equal if Inner is extended 'Equatable'", () {
    final AnotherOuter outer1 = AnotherOuter(number: 1, inner: EquatableInner(number: 2));
    final AnotherOuter outer2 = AnotherOuter(number: 1, inner: EquatableInner(number: 2));
    expect(outer1, equals(outer2));
  });

  test("EnumContainers should be equal", () {
    final container1 = EnumContainer(number: 1, myEnum: MyEnum.joined);
    final container2 = EnumContainer(number: 1, myEnum: MyEnum.joined);
    expect(container1, equals(container2));
  });
}