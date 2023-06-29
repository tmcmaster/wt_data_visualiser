import 'package:flutter/material.dart';
import 'package:wt_data_visualiser/wt_data_visualiser.dart';
import 'package:wt_data_visualiser_examples/models/customer.dart';
import 'package:wt_data_visualiser_examples/models/delivery.dart';
import 'package:wt_data_visualiser_examples/models/driver.dart';
import 'package:wt_data_visualiser_examples/models/supplier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final customer = Customer(
    id: '001',
    name: 'Customer 1',
    phone: '040400001',
    email: 'customer+1@example.com',
    address: '1 main street, Pakenham',
    postcode: 3810,
  );

  static final supplier = Supplier(id: '001', name: 'Supplier 1', code: 'SUP1');
  static final driver = Driver(id: '001', name: 'Driver 1', phone: '0404111111');
  static final delivery = Delivery(
    customer: customer,
    supplier: supplier,
    driver: driver,
  );
  static final dataList1 = ['First', dataMap2, 'Last', delivery];

  static final dataMap1 = {
    'a': 'A',
    'b': 'B',
    'c': {
      'cc': 'C',
      'dd': 'D',
      'ee': 'E',
      'ff': 'F',
    },
  };

  static final dataList2 = ['AAA', dataMap1, 'CCC'];

  static final dataMap2 = {
    'a': 'AA',
    'b': 'BB',
    'c': {
      'cc': 'CC',
      'dd': 'DD',
      'ee': dataList2,
      'ff': 'FF',
    },
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: DataVisualiser(
                  data: dataList1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}