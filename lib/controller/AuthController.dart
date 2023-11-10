import 'package:proy1/Service/AuthService.dart';

class AuthController {
  final authService = AuthService();

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await authService.login(
        username,
        password,
      );

      print('Respuesta del servidor: $response');

      if (response != null) {
        final userData = response['usuario'];
        if (userData != null) {
          final userId = userData['id'];
          if (userId != null) {
            print('Inicio de sesión exitoso');
            print('ID del usuario: $userId');
            return response;
          } else {
            return {
              'status': false,
              'error': 'No se encontró el ID del usuario en la respuesta',
            };
          }
        } else {
          return {
            'status': false,
            'error': 'No se encontró información del usuario en la respuesta',
          };
        }
      } else {
        return {
          'status': false,
          'error': 'La respuesta del servidor es nula',
        };
      }
    } catch (e) {
      print('Error: $e');
      return {
        'status': false,
        'error': 'Error de red',
      };
    }
  }
}
