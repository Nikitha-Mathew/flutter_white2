import 'package:flutter/material.dart';
import 'package:flutter_white2/pdf_api.dart';
import 'package:flutter_white2/pdf_reciept.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'cartprovider.dart';

// checkout screen
class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: Color.fromARGB(255, 189, 134, 219),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Cart Items',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 158, 0, 243),
                  ),
            ),
            SizedBox(height: 10),
            // selected item
            Expanded(
              child: ListView.builder(
                itemCount: cart.cartItems.length,
                itemBuilder: (ctx, i) {
                  final cartItem = cart.cartItems[i];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(cartItem.product.imageUrl,
                            width: 60, height: 60, fit: BoxFit.cover),
                      ),
                      title: Text(
                        cartItem.product.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Quantity: ${cartItem.quantity}'),
                      trailing: Text(
                        'Rs. ${cartItem.product.price * cartItem.quantity}',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount:',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  'Rs. ${cart.totalAmount}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 74, 132, 232),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            //To generate the pdf
            ElevatedButton(
              onPressed: () async {
                print('Buy Now button pressed');
                // Simulate payment process
                String transactionId = "TX123456";
                DateTime purchaseDate = DateTime.now();

                try {
                  print('Generating PDF...');
                  final pdf = await PdfReceiptApi.generate(
                    cart.cartItems,
                    cart.totalAmount,
                    transactionId,
                    purchaseDate,
                  );

                  print('Saving PDF...');
                  final file = await PdfApi.saveDocument(
                    name: 'receipt.pdf',
                    pdf: pdf,
                  );

                  print('PDF saved: ${file.path}');

                  // Provide option to share the PDF
                  if (await file.exists()) {
                    await Share.shareXFiles([XFile(file.path)],
                        text: 'Check out this receipt!');
                  } else {
                    throw Exception("File not found");
                  }
                } catch (e) {
                  print('Error generating or opening PDF: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error generating receipt: $e')),
                  );
                }
              },
              child: Text('Buy Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 189, 134, 219),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
