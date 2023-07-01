import 'package:wt_data_visualiser/src/data_visualiser_node.dart';
import 'package:wt_data_visualiser/src/tree_node_transform.dart';

class ModelTreeNodeTransformer with TreeNodeTransformer<dynamic, String> {
  final Map<Type, TreeNodeTransformer<dynamic, String>> transformerMap;

  ModelTreeNodeTransformer({
    this.transformerMap = const {},
  });

  @override
  DataVisualiserNode<String> transform(dynamic object, {String? title}) {
    if (object is List) {
      final parentNode = DataVisualiserNode(title: title ?? 'List', value: '(${object.length})');
      parentNode.addAll(
        object.map((o) {
          final transformer =
              transformerMap[o.runtimeType] ?? TreeNodeTransformer.defaultTransformer;
          return transformer.transform(o, title: o.runtimeType.toString());
        }).toList(),
      );
      return parentNode;
    } else if (object is Map) {
      final parentNode = DataVisualiserNode(title: title ?? 'Map', value: '(${object.length}');
      // TODO: need to complete
      return parentNode;
    } else {
      final transformer =
          transformerMap[object.runtimeType] ?? TreeNodeTransformer.defaultTransformer;
      return transformer.transform(object);
    }
  }
}
