// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/comment/bloc/comment_bloc.dart' as _i11;
import '../../features/feed/bloc/feed_bloc.dart' as _i12;
import '../../features/login/bloc/login_bloc.dart' as _i8;
import '../datasource/local_datasource.dart' as _i3;
import '../datasource/remote_datasource.dart' as _i5;
import '../network/network_service.dart' as _i4;
import '../repository/authentication_repository.dart' as _i6;
import '../repository/comment_repository.dart' as _i7;
import '../repository/post_repository.dart' as _i9;
import '../state/user_cubit.dart' as _i10;
import 'app_module.dart' as _i13; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i7.CommentRepository>(appModule.commentRepository(
    get<_i5.RemoteDatasource>(),
    get<_i3.LocalDatasource>(),
  ));
  gh.lazySingleton<_i8.LoginBloc>(
      () => _i8.LoginBloc(get<_i6.AuthRepository>()));
  gh.singleton<_i9.PostRepository>(
      appModule.postRepository(get<_i5.RemoteDatasource>()));
  gh.singleton<_i10.UserCubit>(_i10.UserCubit(get<_i6.AuthRepository>()));
  gh.lazySingleton<_i11.CommentBloc>(() => _i11.CommentBloc(
        get<_i7.CommentRepository>(),
        get<_i6.AuthRepository>(),
      ));
  gh.singleton<_i12.FeedBloc>(_i12.FeedBloc(get<_i9.PostRepository>()));
  return get;
}

class _$AppModule extends _i13.AppModule {}
