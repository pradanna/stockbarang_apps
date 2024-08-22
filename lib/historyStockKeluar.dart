import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_barang_apps/Components/cardHistory.dart';
import 'package:stock_barang_apps/Components/cardTanggal.dart';
import 'package:stock_barang_apps/Components/helper.dart';
import 'package:stock_barang_apps/apiRequest/apiServices.dart';

import 'controller/historyController.dart';

class Historystockkeluar extends StatelessWidget {
  final HistoryController controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    controller.fetchOrderHistorykeluar();
    return Scaffold(
        appBar: AppBar(
          title: Text('Riwayat Tambah Stock'),
        ),
        body: Obx(() => (controller.orderHistoryKeluar.isEmpty
            ? Center(
                child: Text('Belum ada riwayat transaksi'),
              )
            : Container(
                child: ListView.builder(
                    itemCount: controller.orderHistoryKeluar.length,
                    itemBuilder: (context, index) {
                      var order = controller.orderHistoryKeluar[index];
                      return Cardtanggal(
                        tanggal: order['tanggal'],
                        historyCard: Container(
                          width: 500,
                          child: ListView.builder(
                              shrinkWrap: true, // Makes the inner ListView take up only the space it needs
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  controller.orderHistoryKeluar[index]['data'].length,
                              itemBuilder: (context, index2) {
                                var barangs = controller.orderHistoryKeluar[index]
                                    ['data'][index2];
                                return Cardhistory(
                                    imageUrl: baseURL +  barangs['barang']['gambar'],
                                    productName: barangs['barang']['nama'],
                                    currentStock: barangs['qty'], satuan: barangs['barang']['satuan'], keterangan: barangs['keterangan'],);
                              }),
                        ),
                      );
                    }),
              ))));
  }
}
