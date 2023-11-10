import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'http://18.216.45.210/api/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        print(response);
        return response.data;
      } else {
        print(response);
        return {
          'status': false,
          'error': 'Inicio de sesión fallido',
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

  Future<Map<String, dynamic>> getUserData(String token) async {
    try {
      final response = await _dio.get(
        'http://18.216.45.210/api/usuarios', // Ajusta la URL según tu API
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        print(response);
        return {
          'status': false,
          'error': 'Error al obtener datos del usuario',
        };
      }
    } catch (e) {
      print('Error: $e');
      return {
        'status': false,
        'error': 'Error de red al obtener datos del usuario',
      };
    }
  }
}

