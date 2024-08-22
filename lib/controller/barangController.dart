import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stock_barang_apps/apiRequest/apiServices.dart';

class BarangController extends GetxController {
  var userName = ''.obs;
  var phoneNumber = ''.obs;
  var isLoading = false.obs,
      isLoadingBarang = false.obs,
      isLoadingBarangbarcode = false.obs,
      isLoadingProfile = false.obs,
      isLoadingDetail = false.obs,
      isLoadingTambahStock = false.obs;
  var selectedCategory = 0.obs;
  final dio.Dio _dio = dio.Dio();
  final GetStorage box = GetStorage();
  var profileData = {}.obs;
  var items = <dynamic>[].obs;
  var itemsbarcoded = <dynamic>[].obs;
  var detailBarang = {
  }.obs;

  var categories = ['Semua', 'Makanan', 'Minuman', 'Lain-lain'].obs;

  var cartItemsCount = 0.obs;

  void addToCart(String item) {
    cartItemsCount.value++;
  }

  Future<void> getProfile() async {
    final token = await box.read('token');
    if (token == null) {
      Get.snackbar('Error', 'No token found');
      return;
    }

    isLoadingProfile(true);

    try {
      final response = await _dio.get(
        baseURL + '/api/profil',
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Store profile data
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

  Future<void> getItems(param) async {
    final token = await box.read('token');
    if (token == null) {
      Get.snackbar('Error', 'No token found');
      return;
    }

    isLoadingBarang(true);
    try {
      final response = await _dio.get(
        baseURL + '/api/barang?nama=' + param,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Store profile data
        items.value = response.data['payload'];

        print(" fetch barang  " + response.data['payload'].toString());
      } else {
        Get.snackbar('Error', 'Failed to fetch Items data');
        print("error fetch barang ");
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching Items data');
      print("error fetch barang " + e.toString());
    } finally {
      isLoadingBarang(false);
    }
  }

  Future<void> getDetailBarang(param) async {
    final token = await box.read('token');
    if (token == null) {
      Get.snackbar('Error', 'No token found');
      return;
    }

    isLoadingDetail(true);
    try {
      final response = await _dio.get(
        baseURL + '/api/barang/' + param,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Store profile data
        detailBarang.value = response.data['payload'];

        print(" detail barang  " + response.data['payload'].toString());
      } else {
        Get.snackbar('Error', 'Failed to fetch Items data');
        print("error fetch barang ");
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching Items data');
      print("error fetch barang " + e.toString());
    } finally {
      isLoadingDetail(false);
    }
  }

  Future<void> tambahStock(int id, int qty, String keterangan) async {
    isLoadingTambahStock.value = true;

    final formData = dio.FormData.fromMap({
      'barang': id,
      'qty': qty,
      'keterangan': keterangan,
    });
    try {
      final token = box.read('token');

      final response = await _dio.post('$baseURL/api/barang-masuk',
          options: dio.Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            },
          ),
          data: formData);

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Stock berhasil ditambahkan',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        Get.snackbar('Error', 'Gagal menerima pesanan: ${response.statusCode}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);

        print('error gagal');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      print('error ' + e.toString());
    } finally {
      isLoadingTambahStock.value = false;
    }
  }

  Future<void> stockKeluar(int id, int qty, String keterangan) async {
    isLoadingTambahStock.value = true;

    final formData = dio.FormData.fromMap({
      'barang': id,
      'qty': qty,
      'keterangan': keterangan,
    });
    try {
      final token = box.read('token');

      final response = await _dio.post('$baseURL/api/barang-keluar',
          options: dio.Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            },
          ),
          data: formData);

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Stock berhasil ditambahkan',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        Get.snackbar('Error', 'Gagal menerima pesanan: ${response.statusCode}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);

        print('error gagal');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      print('error ' + e.toString());
    } finally {
      isLoadingTambahStock.value = false;
    }
  }

  Future<void> getItemsbarcode(param) async {
    final token = await box.read('token');
    if (token == null) {
      Get.snackbar('Error', 'No token found');
      return;
    }

    isLoadingBarangbarcode(true);
    try {
      final response = await _dio.get(
        baseURL + '/api/scanbarcode?barcode=' + param,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Store profile data
        itemsbarcoded.value = response.data['payload'];

        print(" fetch barang  " + response.data['payload'].toString());
      } else {
        Get.snackbar('Error', 'Failed to fetch Items data');
        print("error fetch barang ");
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching Items data');
      print("error fetch barang " + e.toString());
    } finally {
      isLoadingBarangbarcode(false);
    }
  }
}
