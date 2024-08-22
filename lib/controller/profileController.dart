import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../apiRequest/apiServices.dart';

class ProfileController extends GetxController {
  var email = ''.obs;
  var fullName = ''.obs;
  var address = ''.obs;
  var phoneNumber = ''.obs;
  var profileData = {}.obs;

  final Dio _dio = Dio();
  final GetStorage box = GetStorage();
  var isLoadingProfile = false.obs;
  var isLoadingBarang = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getProfile() async {
    isLoadingProfile.value = true;

    final token = await box.read('token');
    if (token == null) {
      Get.snackbar('Error', 'No token found');
      return;
    }

    try {
      final response = await _dio.get(
        baseURL+'/api/profil',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Store profile data
        print("profile data :" + profileData.toString());

        profileData.value = response.data;

      } else {
        Get.snackbar('Error', 'Failed to fetch profile data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching profile data');
    } finally {
      isLoadingProfile(false);
    }
  }

  void logout() {
    GetStorage().erase(); // Clear all stored data
    Get.offAllNamed('/login'); // Navigate to login page
  }

}
