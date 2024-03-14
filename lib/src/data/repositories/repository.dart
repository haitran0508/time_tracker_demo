import '../../domain/repository/repository.dart';
import '../services/network_services.dart/authentication_service.dart';

class Repository extends RepositoryInterface {
  final AuthenticationService authService;

  Repository({
    required this.authService,
  });

  @override
  Future<String> signIn({required String email, required String password}) async {
    final code = await authService.signIn(email, password);
    return code;
  }

  @override
  Future<String> signUp({required String email, required String password}) async {
    final code = await authService.signUp(email, password);
    return code;
  }

  @override
  Future<String> signOut() async {
    final code = await authService.signOut();
    return code;
  }
}
