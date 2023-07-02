import 'package:wt_data_visualiser/src/data_visualiser_node.dart';
import 'package:wt_data_visualiser/src/tree_node_transform.dart';
import 'package:wt_models/wt_models.dart';

class DynamicTreeNodeTransformer with TreeNodeTransformer<dynamic, String> {
  final Map<Type, TreeNodeTransformer<dynamic, String>> transformerMap;

  DynamicTreeNodeTransformer({
    this.transformerMap = const {},
  });

  @override
  DataVisualiserNode<String> transform(dynamic object, {String? title}) {
    if (object is List) {
      final parentNode = DataVisualiserNode(title: title ?? 'List', value: '(${object.length})');
      parentNode.addAll(
        object.map((o) {
          final dataTitle = getDataTitle(o);
          final transformer =
              transformerMap[o.runtimeType] ?? TreeNodeTransformer.defaultTransformer;
          return transformer.transform(o, title: dataTitle);
        }).toList(),
      );
      return parentNode;
    } else if (object is Map) {
      final parentNode = DataVisualiserNode(title: title ?? 'Map', value: '(${object.length})');
      parentNode.addAll(
        object.entries.map((e) {
          final data = e.value;
          final transformer =
              transformerMap[data.runtimeType] ?? TreeNodeTransformer.defaultTransformer;
          final dataTitle = getDataTitle(data, title: e.key);
          return transformer.transform(data, title: dataTitle);
        }).toList(),
      );
      return parentNode;
    } else {
      final transformer =
          transformerMap[object.runtimeType] ?? TreeNodeTransformer.defaultTransformer;
      return transformer.transform(object);
    }
  }

  String getDataTitle(dynamic data, {dynamic title}) {
    return data is TitleSupport
        ? data.getTitle()
        : data is Map
            ? 'Map (${data.length})'
            : data is List
                ? 'List (${data.length})'
                : title?.toString() ?? data.toString();
  }
}
