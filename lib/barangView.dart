import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stock_barang_apps/Components/SearchField.dart';
import 'package:stock_barang_apps/Components/carditem.dart';
import 'package:stock_barang_apps/apiRequest/apiServices.dart';
import 'controller/barangController.dart';

class Barangview extends StatelessWidget {
  final BarangController controller = Get.put(BarangController());

  @override
  Widget build(BuildContext context) {
    controller.getProfile();
    controller.getItems("");

    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          color: Colors.white,
          height: 1.sh,
          child: Column(children: [
            Stack(
              children: [
                Container(
                  height: .23.sh,
                  width: 1.sw,
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        height: 250,
                        width: 1.sh,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            image: DecorationImage(
                              image: AssetImage('assets/images/login.jpg'),
                              fit: BoxFit
                                  .cover, // Menyesuaikan ukuran gambar sesuai dengan ukuran container
                            )),
                        child: Obx(
                          () => controller.isLoadingProfile.value
                              ? SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Center(
                                      child: CircularProgressIndicator()))
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Nama: ${controller.profileData.value['payload'] == null ? '' : controller.profileData.value['payload']['nama']} ',
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    Text(
                                        'Cabang : ${controller.profileData.value['payload'] == null ? '' : controller.profileData.value['payload']['cabang']['nama']}',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.white)),
                                  ],
                                ),
                        ),
                      ),
                      Positioned(
                          top: 20,
                          child: Container(
                            padding: EdgeInsets.all(24),
                            width: 1.sw,
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: Image.asset(
                                        'assets/images/logo.png')),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed("/scan");
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
                                      ),
                                      width: 50,
                                      height: 50,
                                      child: Icon(Icons.qr_code, size: 40.sp,)),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          
            Searchfield(onChanged: (ad) {
              controller.getItems(ad);
            }),
            // Text('Silahkan pesan menu dibawah.', style: TextStyle(color: Colorsmaster.defaultTextColor, fontWeight: FontWeight.bold), ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                        
                  return ListView.builder(
                    itemCount: controller.items.length,
                    itemBuilder: (context, index) {
                      var item = controller.items[index];
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
            ),
          ]),
        ));
  }
}
