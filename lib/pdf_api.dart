import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

// for save the pdf
class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/$name');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
