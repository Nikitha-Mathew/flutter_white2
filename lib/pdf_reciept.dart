import 'package:pdf/widgets.dart' as pw;
import 'cartprovider.dart';

//receipt of the pdf
class PdfReceiptApi {
  static Future<pw.Document> generate(
    List<CartItem> cartItems,
    double totalAmount,
    String transactionId,
    DateTime purchaseDate,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            // details in pdf
            children: [
              pw.Text('Receipt', style: pw.TextStyle(fontSize: 24)),
              pw.Text('Transaction ID: $transactionId'),
              pw.Text('Date: ${purchaseDate.toLocal()}'),
              pw.SizedBox(height: 20),
              pw.Text('Items:', style: pw.TextStyle(fontSize: 18)),
              ...cartItems.map((item) => pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(item.product.name),
                      pw.Text('Qty: ${item.quantity}'),
                      pw.Text('Price: Rs. ${item.product.price}'),
                    ],
                  )),
              pw.SizedBox(height: 20),
              pw.Text('Total Amount: Rs. $totalAmount',
                  style: pw.TextStyle(fontSize: 18)),
            ],
          );
        },
      ),
    );

    return pdf;
  }
}
