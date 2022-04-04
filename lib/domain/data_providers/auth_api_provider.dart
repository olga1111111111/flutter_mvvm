abstract class AuthApiProviderError {}

class AuthApiProviderIncorectLoginDataError {}

// фейковый api для запросов в сеть
class AuthApiProvider {
  Future<String> login(String login, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    final isSuccess = login == 'admin' && password == '12345';
    if (isSuccess) {
      return ';lkjl;kj;lkj;kjlkjkjkjkjkjkjff090ikojkj';
    } else {
      throw AuthApiProviderIncorectLoginDataError();
    }
  }
}
