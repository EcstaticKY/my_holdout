import 'package:flutter_test/flutter_test.dart';
import 'package:my_holdout/features/simple_list_page/data/userinfo_db_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

final sut = UserInfoDbProvider();

void main() {
  // Setup sqflite_common_ffi for flutter test
  setUpAll(() async {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;

    await sut.open(inMemoryDatabasePath);
  });

  test('Should insert userinfo correctly', () async {
    final firstResult = await sut.getUserInfo(0);

    final userInfo = UserInfo(userId: 0);
    await sut.insertUserInfo(userInfo);

    final secondResult = await sut.getUserInfo(0);

    expect(firstResult, null);
    expect(secondResult, equals(userInfo));
  });
}