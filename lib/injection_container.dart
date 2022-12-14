import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:my_holdout/number_trivia/data/number_trivia_local_data_source.dart';
import 'package:my_holdout/number_trivia/data/number_trivia_remote_data_source.dart';
import 'package:my_holdout/number_trivia/data/number_trivia_repository.dart';
import 'package:my_holdout/number_trivia/data/number_trivia_repository_impl.dart';
import 'package:my_holdout/number_trivia/domain/get_concrete_number_trivia.dart';
import 'package:my_holdout/number_trivia/domain/get_random_number_trivia.dart';
import 'package:my_holdout/number_trivia/presentation/number_trivia_bloc.dart';
import 'package:my_holdout/shared/network_info.dart';
import 'package:my_holdout/shared/util/input_converter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  sl.registerFactory(() => NumberTriviaBloc(concrete: sl(), random: sl(), converter: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));
  
  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(() => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(() => NumberTriviaRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(() => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(checker: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}