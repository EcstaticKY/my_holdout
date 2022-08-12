import 'package:equatable/equatable.dart';
import 'package:sqflite/sqflite.dart';

class UserInfo extends Equatable {
  final int userId;
  final String userName;
  final String userAvatar;

  UserInfo({this.userId = 0, this.userName = '', this.userAvatar = ''});

  @override
  List<Object> get props => [userId, userName, userAvatar];
}

class UserInfoDbProvider {
  final String tableName = 'Userinfo';
  final String columnUserId = 'userId';
  final String columnUserName = 'userName';
  final String columnUserAvatar = 'userAvatar';

  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
              create table $tableName (
                $columnUserId integer primary key,
                $columnUserName text,
                $columnUserAvatar text
              )
      ''');
    });
  }

  Future insertUserInfo(UserInfo userInfo) async {
    await db.insert(tableName, _userInfoToMap(userInfo));
  }

  Future<UserInfo> getUserInfo(int userId) async {
    List<Map> maps = await db.query(tableName,
        where: '$columnUserId = ?', whereArgs: [userId]);
    if (maps.length > 0) {
      return _userInfoFromMap(maps.first);
    }
    return null;
  }

  // Mapper
  Map<String, Object> _userInfoToMap(UserInfo userInfo) {
    return {
      columnUserId: userInfo.userId,
      columnUserName: userInfo.userName,
      columnUserAvatar: userInfo.userAvatar,
    };
  }

  UserInfo _userInfoFromMap(Map<String, Object> map) {
    final userId = map[columnUserId] != null ? map[columnUserId] as int : 0;
    final userName =
        map[columnUserName] != null ? map[columnUserName] as String : 0;
    final userAvatar =
        map[columnUserAvatar] != null ? map[columnUserAvatar] as String : 0;
    return UserInfo(userId: userId, userName: userName, userAvatar: userAvatar);
  }
}
