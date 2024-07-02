// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/feed/bloc/feed_bloc.dart' as _i9;
import '../../features/login/bloc/login_bloc.dart' as _i8;
import '../datasource/local_datasource.dart' as _i3;
import '../datasource/remote_datasource.dart' as _i5;
import '../network/network_service.dart' as _i4;
import '../repository/authentication_repository.dart' as _i6;
import '../repository/post_repository.dart' as _i7;
import 'app_module.dart' as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  gh.singleton<_i3.LocalDatasource>(appModule.localDataSource());
  gh.singleton<_i4.NetworkService>(appModule.networkService());
  gh.singleton<_i5.RemoteDatasource>(
      appModule.remoteDatasource(get<_i4.NetworkService>()));
  gh.singleton<_i6.AuthRepository>(appModule.authRepository(
    get<_i5.RemoteDatasource>(),
    get<_i3.LocalDatasource>(),
  ));
  gh.singleton<_i7.PostRepository>(
      appModule.postRepository(get<_i5.RemoteDatasource>()));
  gh.factory<_i8.AuthBloc>(() => _i8.AuthBloc(get<_i6.AuthRepository>()));
  gh.factory<_i9.FeedBloc>(() => _i9.FeedBloc(get<_i7.PostRepository>()));
  return get;
}

class _$AppModule extends _i10.AppModule {}
