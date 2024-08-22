
import 'package:get/get.dart';
import 'package:stock_barang_apps/StockKeluarView.dart';
import 'package:stock_barang_apps/TambahStockView.dart';
import 'package:stock_barang_apps/barangBarcode.dart';
import 'package:stock_barang_apps/barcodeView.dart';
import 'package:stock_barang_apps/historyStockKeluar.dart';
import 'package:stock_barang_apps/historyView.dart';


import 'controller/binding/loginBinding.dart';
import 'homeView.dart';
import 'barangView.dart';
import 'login.dart';
import 'splashScreen.dart';

class RoutePage {
  List<GetPage> route = [
    GetPage(name: "/", page: () => SplashScreen()),
    GetPage(name: "/login", page: () => LoginView(), binding: LoginBinding()),
    GetPage(name: "/pesan", page: () => Barangview()),
    GetPage(name: "/barangCode", page: () => Barangbarcode()),
    GetPage(name: "/tambahStock", page: () => TambahStockView()),
    GetPage(name: "/stockKeluar", page: () => StockKeluar()),
    GetPage(name: "/home", page: () => HomeView()),
    GetPage(name: "/history", page: () => HistoryView()),
    GetPage(name: "/historykeluar", page: () => Historystockkeluar()),
    GetPage(name: "/scan", page: () => BarcodeScanPage()),
  ];
}
