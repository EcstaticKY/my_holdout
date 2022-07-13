import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 50)();

  DateTimeColumn get dueDate => dateTime().nullable()();

  BoolColumn get completed => boolean().withDefault(Constant(false))();
}

@UseMoor(tables: [Tasks], daos: [TaskDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
        path: 'db.sqlite',
        logStatements: true,
      )));

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Tasks])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  final AppDatabase db;

  TaskDao(this.db) : super(db);

  Future<List<Task>> getAllTasks() => select(tasks).get();

  Stream<List<Task>> watchAllTasks() {
    return (select(tasks)
    // Statements like orderBy and where return void => the need to use a cascading ".." operator
      ..orderBy(
        ([
          // Primary sorting by due date
              (t) =>
              OrderingTerm(expression: t.dueDate, mode: OrderingMode.desc),
          // Secondary alphabetical sorting
              (t) => OrderingTerm(expression: t.name),
        ]),
      ))
    // watch the whole select statement
        .watch();
  }

  Stream<List<Task>> watchCompletedTasks() {
    // where returns void, need to use the cascading operator
    return (select(tasks)
      ..orderBy(
        ([
          // Primary sorting by due date
              (t) =>
              OrderingTerm(expression: t.dueDate, mode: OrderingMode.desc),
          // Secondary alphabetical sorting
              (t) => OrderingTerm(expression: t.name),
        ]),
      )
      ..where((t) => t.completed.equals(true)))
        .watch();
  }

  // // Watching complete tasks with a custom query
  // Stream<List<Task>> watchCompletedTasksCustom() {
  //   return customSelectStream(
  //     'SELECT * FROM tasks WHERE completed = 1 ORDER BY due_date DESC, name;',
  //     // The Stream will emit new values when the data inside the Tasks table changes
  //     readsFrom: {tasks},
  //   )
  //   // customSelect or customSelectStream gives us QueryRow list
  //   // This runs each time the Stream emits a new value.
  //       .map((rows) {
  //     // Turning the data of a row into a Task object
  //     return rows.map((row) => Task.fromData(row.data, db)).toList();
  //   });
  // }

  Future insertTask(Insertable<Task> task) => into(tasks).insert(task);

  Future updateTask(Insertable<Task> task) => update(tasks).replace(task);

  Future deleteTask(Insertable<Task> task) => delete(tasks).delete(task);
}