import 'package:wt_data_visualiser/wt_data_visualiser.dart';
import 'package:wt_data_visualiser_examples/models/customer.dart';
import 'package:wt_data_visualiser_examples/models/delivery.dart';
import 'package:wt_data_visualiser_examples/models/driver.dart';
import 'package:wt_data_visualiser_examples/models/supplier.dart';

class DeliveryTreeNodeTransformers with TreeNodeTransformer<Delivery, String> {
  @override
  DataVisualiserNode<String> transform(Delivery delivery, {String? title}) {
    final parentNode = DataVisualiserNode(title: title ?? 'Delivery', value: '001');
    parentNode.addAll([
      if (delivery.customer != null) CustomerTreeNodeTransformers().transform(delivery.customer!),
      if (delivery.driver != null) DriverTreeNodeTransformers().transform(delivery.driver!),
      if (delivery.supplier != null) SupplierTreeNodeTransformers().transform(delivery.supplier!),
    ]);
    return parentNode;
  }
}

class CustomerTreeNodeTransformers with TreeNodeTransformer<Customer, String> {
  @override
  DataVisualiserNode<String> transform(Customer customer, {String? title}) {
    final treeNode = DataVisualiserNode(title: title ?? 'Customer', value: customer.name);
    treeNode.addAll([
      DataVisualiserNode(title: 'email', value: customer.email),
      DataVisualiserNode(title: 'phone', value: customer.phone),
    ]);
    return treeNode;
  }
}

class SupplierTreeNodeTransformers with TreeNodeTransformer<Supplier, String> {
  @override
  DataVisualiserNode<String> transform(Supplier supplier, {String? title}) {
    final treeNode = DataVisualiserNode(title: title ?? 'Supplier', value: supplier.name);
    treeNode.addAll([
      DataVisualiserNode(title: 'code', value: supplier.code),
    ]);
    return treeNode;
  }
}

class DriverTreeNodeTransformers with TreeNodeTransformer<Driver, String> {
  @override
  DataVisualiserNode<String> transform(Driver driver, {String? title}) {
    final treeNode = DataVisualiserNode(title: title ?? 'Driver', value: driver.name);
    treeNode.addAll([
      DataVisualiserNode(title: 'phone', value: driver.phone),
    ]);
    return treeNode;
  }
}
