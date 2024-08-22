import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stock_barang_apps/Components/SearchField.dart';
import 'package:stock_barang_apps/Components/carditem.dart';
import 'package:stock_barang_apps/apiRequest/apiServices.dart';
import 'controller/barangController.dart';

class Barangbarcode extends StatelessWidget {
  final BarangController controller = Get.put(BarangController());

  @override
  Widget build(BuildContext context) {
    final String code = Get.arguments['barcode'];
    controller.getItemsbarcode(code);

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('Hasil Scan Barcode'),
        ),
        body: Container(
          height: double.infinity,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(children: [

              Searchfield(onChanged: (ad) {
                controller.getItemsbarcode(code);
              }),
              // Text('Silahkan pesan menu dibawah.', style: TextStyle(color: Colorsmaster.defaultTextColor, fontWeight: FontWeight.bold), ),
              Container(
                height: .40.sh,
                padding: EdgeInsets.all(8),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: controller.itemsbarcoded.length,
                    itemBuilder: (context, index) {
                      var item = controller.itemsbarcoded[index];
                      return CardItem(
                        onTambahStock: (){
                          Get.toNamed("/tambahStock", arguments: {
                            'id': item['id']
                          });
                        },
                        onStockKeluar: (){
                          Get.toNamed("/stockKeluar", arguments: {
                            'id': item['id']
                          });
                        },
                        imageUrl: baseURL + item['gambar'],
                        productName: item['nama'],
                        currentStock: item['total_stock'],
                      );
                    },
                  );
                }),
              ),
            ]),
          ),
        ));
  }
}
