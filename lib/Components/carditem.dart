import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final int currentStock;
  final VoidCallback onTambahStock;
  final VoidCallback onStockKeluar;

  CardItem({
    required this.imageUrl,
    required this.productName,
    required this.currentStock,
    required this.onTambahStock,
    required this.onStockKeluar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16.0), // Space between image and text
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Sisa Stok: $currentStock',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
                Row(
                  children: [
                    // Button for "Tambah Stock"
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onTambahStock,
                        icon: Icon(Icons.arrow_downward),
                        // Icon pointing downward
                        label: Text('Tambah Stock'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Green background
                          foregroundColor: Colors.white, // White text
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30), // Circular radius
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Add some space between the buttons
                    // Button for "Stock Keluar"
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onStockKeluar,

                        icon: Icon(Icons.arrow_upward), // Icon pointing upward
                        label: Text('Stock Keluar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Red background
                          foregroundColor: Colors.white, // White text
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30), // Circular radius
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
