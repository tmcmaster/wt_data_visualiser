import 'package:wt_data_visualiser/wt_data_visualiser.dart';
import 'package:wt_data_visualiser_examples/models/customer.dart';
import 'package:wt_data_visualiser_examples/models/driver.dart';
import 'package:wt_data_visualiser_examples/models/supplier.dart';

class CustomerTreeNodeTransformer with TreeNodeTransformer<Customer, String> {
  @override
  DataVisualiserNode<String> transform(
    Customer customer, {
    String? title,
    required TransformerMap transformerMap,
  }) {
    final treeNode = DataVisualiserNode(title: title ?? 'Customer', value: customer.name);
    treeNode.addAll([
      DataVisualiserNode(title: 'email', value: customer.email),
      DataVisualiserNode(title: 'phone', value: customer.phone),
    ]);
    return treeNode;
  }
}

class SupplierTreeNodeTransformer with TreeNodeTransformer<Supplier, String> {
  @override
  DataVisualiserNode<String> transform(
    Supplier supplier, {
    String? title,
    required TransformerMap transformerMap,
  }) {
    final treeNode = DataVisualiserNode(title: title ?? 'Supplier', value: supplier.name);
    treeNode.addAll([
      DataVisualiserNode(title: 'code', value: supplier.code),
    ]);
    return treeNode;
  }
}

class DriverTreeNodeTransformer with TreeNodeTransformer<Driver, String> {
  @override
  DataVisualiserNode<String> transform(
    Driver driver, {
    String? title,
    required TransformerMap transformerMap,
  }) {
    final treeNode = DataVisualiserNode(title: title ?? driver.name, value: 'Driver');
    treeNode.addAll([
      DataVisualiserNode(title: 'Phone', value: driver.phone),
    ]);
    return treeNode;
  }
}
