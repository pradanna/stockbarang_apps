import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/profileController.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {

    controller.getProfile();

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => controller.isLoadingProfile.value ? Center(child: CircularProgressIndicator(),) : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                'Nama Lengkap:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Obx(() => Text(
                controller.profileData['payload']['nama'],
                style: TextStyle(fontSize: 16),
              )),
              SizedBox(height: 20),
              Text(
                'Alamat:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Obx(() => Text(
                controller.profileData['payload']['alamat'],
                style: TextStyle(fontSize: 16),
              )),
              SizedBox(height: 20),
              Text(
                'No HP:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Obx(() => Text(
                controller.profileData['payload']['no_hp'],
                style: TextStyle(fontSize: 16),
              )),
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika logout di sini
                    controller.logout();
                  },
                  child: Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red,
                    backgroundColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
