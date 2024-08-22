import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stock_barang_apps/apiRequest/apiServices.dart';

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  final Dio _dio = Dio();
  final GetStorage box = GetStorage();

  Future<void> login() async {
    isLoading(true);
    try {
      final response = await _dio.post(
        baseURL+'/api/auth/login',
        data: {
          'username': username.value,
          'password': password.value,
        },
      );

      if (response.statusCode == 200) {
        // Simpan token ke GetStorage
        await box.write('token', response.data['payload']['access_token']);
        // Handle successful login
        Get.snackbar('Success', 'Login successful');
        // Navigate to home or dashboard
        Get.offAllNamed('/home');
      } else {
        // Handle unsuccessful login
        Get.snackbar('Error', 'Login failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
      print(e);
    } finally {
      isLoading(false);
    }
  }

  // Fungsi untuk mendapatkan token dari GetStorage
  String?  getToken()  {
    return box.read('token');
  }
}
