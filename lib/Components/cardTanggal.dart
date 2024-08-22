import 'package:flutter/material.dart';
import 'package:stock_barang_apps/Components/cardHistory.dart';

class Cardtanggal extends StatelessWidget {
  final String tanggal;
  final Widget historyCard;

  Cardtanggal({
    required this.tanggal,
    required this.historyCard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Tanggal :" + tanggal),
          Container(child: historyCard)
        ],
      ),
    );
  }
}
