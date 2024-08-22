import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_barang_apps/apiRequest/apiServices.dart';
import 'package:stock_barang_apps/controller/barangController.dart';

import 'Components/helper.dart';

class TambahStockView extends StatelessWidget {
  BarangController controller = Get.put(BarangController());
  final TextEditingController _keteranganController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final qty = 1.obs;
    final int id = Get.arguments['id'];
    controller.getDetailBarang(id.toString());

    return Scaffold(
        appBar: AppBar(title: Text('Tambah Stock')),
        body: Obx(() => (controller.isLoadingBarang.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar besar di atas
                    Image.network(
                      controller.detailBarang.value == null
                          ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2BNGImiFNXoEc3ONE3biDks4T4Y9JkCJCMA&s'
                          : baseURL +
                              controller.detailBarang.value['gambar'].toString(),
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20),
                    // Nama menu
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        controller.detailBarang.value['nama'].toString(),
                        style:
                            TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Nama menu
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        controller.detailBarang.value['stock'] == null
                            ? 'Sisa Stock: 0 ' +
                                controller.detailBarang.value['satuan'].toString()
                            : 'Sisa Stock: ' +
                                controller.detailBarang.value['stock']!['qty']
                                    .toString() +
                                " " +
                                controller.detailBarang.value['satuan']
                                    .toString(),
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Harga menu
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'harga ' +
                            formatRupiah(
                                controller.detailBarang.value['harga'] as num),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.green),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Pengaturan quantity
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Text('Quantity:', style: TextStyle(fontSize: 18)),
                          SizedBox(width: 20),
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              if (qty.value > 1) {
                                qty.value--;
                              }
                            },
                          ),
                          Obx(() => Text(qty.value.toString(),
                              style: TextStyle(fontSize: 18))),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              qty.value++;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Tombol untuk memasukkan ke keranjang
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      // Add vertical margin for spacing
                      child: TextField(
                        controller: _keteranganController,
                        decoration: InputDecoration(
                          labelText: 'keterangan',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(8.0), // Rounded corners
                            borderSide:
                                BorderSide(color: Colors.grey), // Border color
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(8.0), // Rounded corners
                            borderSide: BorderSide(
                                color: Colors.blue), // Border color when focused
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10), // Padding inside the TextField
                        ),
                      ),
                    ),
                    controller.isLoadingTambahStock.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            margin: EdgeInsets.all(10), // Margin of 10
                            child: ElevatedButton(
                              onPressed: () {

                                  controller.tambahStock(
                                      id, qty.value,
                                      _keteranganController.text ?? "");
                                  Get.offAndToNamed('/home');

                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                // Blue background
                                foregroundColor: Colors.white,
                                // White text
                                minimumSize: Size(double.infinity, 50),
                                // Full width
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30), // Circular radius
                                ),
                                padding: EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: Text('Submit'),
                            ),
                          )
                  ],
                ),
            ))));
  }
}
