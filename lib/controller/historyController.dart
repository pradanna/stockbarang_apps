import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stock_barang_apps/apiRequest/apiServices.dart';

class HistoryController extends GetxController {
  var orderHistory = <Map<String, dynamic>>[].obs;
  var orderHistoryKeluar = <Map<String, dynamic>>[].obs;
  final Dio _dio = Dio();
  final storage = GetStorage();
  final String apiUrl = baseURL+'/api/barang-masuk';
  var isLoadingTerima = false.obs;

  void fetchOrderHistory() async {
    try {
      final token = storage.read('token');
      final response = await _dio.get(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> history = List<Map<String, dynamic>>.from(response.data['payload']);
        orderHistory.value = history;

        print("fetch history" + history.toString());
      } else {
        print('Failed to fetch order history: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching order history: $e');
    }
  }

  void fetchOrderHistorykeluar() async {
    try {
      final token = storage.read('token');
      final response = await _dio.get(
        baseURL+'/api/barang-keluar',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> history = List<Map<String, dynamic>>.from(response.data['payload']);
        orderHistoryKeluar.value = history;

        print("fetch history" + history.toString());
      } else {
        print('Failed to fetch order history: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching order history: $e');
    }
  }

}
