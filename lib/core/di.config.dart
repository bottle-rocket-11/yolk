// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;
import 'package:yolk/bloc/auth/auth_bloc.dart' as _i300;
import 'package:yolk/core/supabase_module.dart' as _i523;
import 'package:yolk/repository/auth_repository.dart' as _i136;
import 'package:yolk/repository/auth_repository_impl.dart' as _i949;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerSupabaseModule = _$RegisterSupabaseModule();
    gh.factory<_i454.Supabase>(() => registerSupabaseModule.supabase);
    gh.factory<_i136.AuthRepository>(
        () => _i949.AuthRepositoryImpl(gh<_i454.Supabase>()));
    gh.lazySingleton<_i300.AuthBloc>(
        () => _i300.AuthBloc(gh<_i136.AuthRepository>()));
    return this;
  }
}

class _$RegisterSupabaseModule extends _i523.RegisterSupabaseModule {}
