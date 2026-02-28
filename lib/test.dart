import 'dart:ffi';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar');
  File file = File("C:\\Users\\alaah\\Downloads\\tmp2.xlsx");
  List<int> bytes =await file.readAsBytes();
  Excel excel = Excel.decodeBytes(bytes);
  final sheet = excel.tables.values.first;

  Map<String,List<DataModel>> allData = {};
  DateTime? date;

  sheet.rows.forEach((e) {
    final row1 = e[0]?.value.toString().trim() ?? '';
    final row2 = e[1]?.value.toString().trim() ?? '';
    final row3 = e[2]?.value.toString().trim() ?? '';
    final row4 = e[3]?.value.toString().trim() ?? '';
    final row5 = e[4]?.value.toString().trim() ?? '';
    final row6 = e[5]?.value.toString().trim() ?? '';
    final row7 = e[6]?.value.toString().trim() ?? '';

    if(row5.length >3){
      date = getDate(row5);
    }else{
      final data = DataModel();
      data.category = row1;
      data.parts = int.tryParse(row2);
      data.name = row3;
      data.branch = row4;
      data.date = date;
      data.hour = int.tryParse(row5);
      data.quantity = int.tryParse(row6);
      data.price = int.tryParse(row7);
      if(data.price == 0 && data.quantity == 0 && data.hour == 0 && data.parts == 0){
        print('empty row');
      }else{
        allData[data.branch?? 'a'] ??= [];
        allData[data.branch?? 'a']!.add(data);
      }
    }
  });

  final outExcel = Excel.createExcel();
  final sheetOut = outExcel['Sheet1'];
  sheetOut.appendRow([
    TextCellValue('الصنف'),
    TextCellValue('النفر'),
    TextCellValue('اسم المنت'),
    TextCellValue('الفرع'),
    TextCellValue('التاريخ'),
    TextCellValue('الساعة'),
    TextCellValue('الكمية'),
    TextCellValue('السعر'),
    TextCellValue('اجمالي الكمية'),
  ]);

  final allOutRows = allData.values.fold([], (previousValue, element) => [...previousValue,...element],);
  allOutRows.forEach((data) {
    sheetOut.appendRow([
      TextCellValue(data.category ?? ''),
      IntCellValue(data.parts ?? 0),
      TextCellValue(data.name ?? ''),
      TextCellValue(data.branch ?? ''),
      DateCellValue.fromDateTime(data.date!),
      IntCellValue( data.hour ?? 0),
      IntCellValue(data.quantity ?? 0),
      IntCellValue(data.price ?? 0),
      IntCellValue(data.total),

    ]);
  },);

  File("C:\\Users\\alaah\\Downloads\\out.xlsx")
    ..createSync(recursive: true)
    ..writeAsBytesSync(outExcel.encode()!);

  print("C:\\Users\\alaah\\Downloads\\out.xlsx");

}

class DataModel {
   String? category;
   int? parts;
   String? name;
   String? branch;
   DateTime? date;
   int? hour;
   int? quantity;
   int? price;

   int get total => (quantity ?? 0) * (parts ?? 1);

}


DateTime? getDate(String date){
  try{
    return DateFormat('dd MMMM yyyy','ar').tryParse(date);
  }catch(e){
    return null;
  }
}