// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../domain/chat/repositories/i_chat_repository.dart' as _i742;
import '../../domain/trip/repositories/i_trip_repository.dart' as _i697;
import '../../domain/user/repositories/i_user_repository.dart' as _i453;
import '../chat/datasources/firebase_chat_datasource.dart' as _i685;
import '../chat/repositories/chat_repository_impl.dart' as _i1059;
import '../trip/datasources/firebase_trip_datasource.dart' as _i343;
import '../trip/repositories/trip_repository_impl.dart' as _i117;
import '../user/datasources/firebase_user_datasource.dart' as _i232;
import '../user/repositories/user_repository_impl.dart' as _i926;
import 'firebase_injectable_module.dart' as _i574;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseInjectableModule = _$FirebaseInjectableModule();
    gh.lazySingleton<_i59.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth,
    );
    gh.lazySingleton<_i974.FirebaseFirestore>(
      () => firebaseInjectableModule.firestore,
    );
    gh.lazySingleton<_i685.FirebaseChatDataSource>(
      () => _i685.FirebaseChatDataSource(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i343.FirebaseTripDataSource>(
      () => _i343.FirebaseTripDataSource(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i232.FirebaseUserDataSource>(
      () => _i232.FirebaseUserDataSource(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
      ),
    );
    gh.lazySingleton<_i742.IChatRepository>(
      () => _i1059.ChatRepositoryImpl(
        gh<_i685.FirebaseChatDataSource>(),
        gh<_i232.FirebaseUserDataSource>(),
      ),
    );
    gh.lazySingleton<_i453.IUserRepository>(
      () => _i926.UserRepositoryImpl(gh<_i232.FirebaseUserDataSource>()),
    );
    gh.lazySingleton<_i697.ITripRepository>(
      () => _i117.TripRepositoryImpl(
        gh<_i343.FirebaseTripDataSource>(),
        gh<_i232.FirebaseUserDataSource>(),
      ),
    );
    return this;
  }
}

class _$FirebaseInjectableModule extends _i574.FirebaseInjectableModule {}
