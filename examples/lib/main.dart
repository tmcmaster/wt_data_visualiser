import 'package:flutter/material.dart';
import 'package:wt_data_visualiser/wt_data_visualiser.dart';
import 'package:wt_data_visualiser_examples/models/customer.dart';
import 'package:wt_data_visualiser_examples/models/delivery.dart';
import 'package:wt_data_visualiser_examples/models/driver.dart';
import 'package:wt_data_visualiser_examples/models/supplier.dart';

void main() {
  runApp(const DataVisualiserDemo());
}

class DataVisualiserDemo extends StatelessWidget {
  const DataVisualiserDemo({super.key});

  static final delivery = Delivery(
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

  // static final dataList1 = ['First', delivery, dataMap2, 'Last'];

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

  static final objectsToView = <String, dynamic>{
    'First Item': 'First',
    'Delivery': delivery,
    'Data Map': dataMap2,
    'Last Item': 'Last',
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
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: DataVisualiser(
                    // treeNode: DeliveryTreeNodeTransform().transform(delivery),
                    // treeNode: ObjectToTreeNodesTransform().transform(dataList1),
                    treeNode: DynamicTreeNodeTransformer().transform(objectsToView),
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
