import 'package:get_it/get_it.dart';
import 'package:time_tracker_demo/src/presentation/bloc/authentication/authentication_bloc.dart';

import '../src/data/repositories/repository.dart';
import '../src/data/services/network_services.dart/authentication_service.dart';
import '../src/domain/usecase/sign_in.dart';
import '../src/domain/usecase/sign_out.dart';
import '../src/domain/usecase/sign_up.dart';
import '../src/presentation/bloc/current_session/current_session_bloc.dart';

final getIt = GetIt.instance;

void dependencyRegister() {
  getIt.registerLazySingleton<AuthenticationService>(() {
    return AuthenticationService();
  });

  getIt.registerLazySingleton<Repository>(() {
    final authService = getIt.get<AuthenticationService>();
    return Repository(
      authService: getIt.get<AuthenticationService>(),
    );
  });

  getIt.registerLazySingleton<SignIn>(() {
    final repository = getIt.get<Repository>();
    return SignIn(repository);
  });

  getIt.registerLazySingleton<SignUp>(() {
    final repository = getIt.get<Repository>();
    return SignUp(repository);
  });

  getIt.registerLazySingleton<SignOut>(() {
    final repository = getIt.get<Repository>();
    return SignOut(repository);
  });

  getIt.registerLazySingleton(() => CurrentSessionBloc());

  getIt.registerLazySingleton<AuthenticationBloc>(() {
    final signInUsecase = getIt.get<SignIn>();
    final signUpUsecase = getIt.get<SignUp>();
    final signOutUsecase = getIt.get<SignOut>();
    return AuthenticationBloc(
      signInUsecase: signInUsecase,
      signOutUsecase: signOutUsecase,
      signUpUsecase: signUpUsecase,
    );
  });
}
