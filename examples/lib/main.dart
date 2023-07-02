import 'package:flutter/material.dart';
import 'package:wt_data_visualiser_examples/models/customer.dart';
import 'package:wt_data_visualiser_examples/models/delivery.dart';
import 'package:wt_data_visualiser_examples/models/driver.dart';
import 'package:wt_data_visualiser_examples/models/supplier.dart';
import 'package:wt_data_visualiser_examples/widgets/data_visualiser_page_view.dart';

void main() {
  runApp(const DataVisualiserDemo());
}

class DataVisualiserDemo extends StatelessWidget {
  const DataVisualiserDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(
          child: DataVisualiserPageView(
            dataSets: {
              'A String': 'First',
              'An Integer': 1,
              'A Double': 1.2,
              'A Boolean': false,
              'List of Scalars': const ['Cat', 1, 1.1, true],
              'Delivery': deliveryContainingModels,
              'Data Map': nestedMapContainingList,
              'Data List': listContainingModeAndMap,
              'Last Item': 'Last',
              'List Containing Mode and Map': listContainingModeAndMap,
            },
          ),
        ),
      ),
    );
  }
}

final deliveryContainingModels = Delivery(
  customer: Customer(
    id: '001',
    name: 'Customer 1',
    phone: '040400001',
    email: 'customer+1@example.com',
    address: '1 main street, Pakenham',
    postcode: 3810,
  ),
  supplier: Supplier(
    id: '001',
    name: 'Supplier 1',
    code: 'SUP1',
  ),
  driver: Driver(
    id: '001',
    name: 'Driver 1',
    phone: '0404111111',
  ),
);

final listContainingModeAndMap = [
  'First',
  deliveryContainingModels,
  nestedMapContainingList,
  'Last',
];

final nestedMap = {
  'a': 'A',
  'b': 'B',
  'c': {
    'cc': 'C',
    'dd': 'D',
    'ee': 'E',
    'ff': 'F',
  },
};

final listContainingMap = [
  'List First',
  nestedMap,
  'List Last',
];

final nestedMapContainingList = {
  'a': 'AA',
  'b': 'BB',
  'c': {
    'cc': 'CC',
    'dd': 'DD',
    'ee': listContainingMap,
    'ff': 'FF',
  },
};
