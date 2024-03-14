abstract class RepositoryInterface {
  Future<String> signIn({required String email, required String password});
  Future<String> signUp({required String email, required String password});
  Future<String> signOut();
}
