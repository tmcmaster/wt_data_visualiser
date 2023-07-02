import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:wt_data_visualiser/src/data_visualiser_node.dart';
import 'package:wt_data_visualiser/src/tree_node_transform.dart';
import 'package:wt_models/wt_models.dart';

class ObjectToTreeNodeTransform with TreeNodeTransformer<dynamic, String> {
  final TransformerMap transformerMap;

  ObjectToTreeNodeTransform({
    this.transformerMap = const {},
  });

  @override
  DataVisualiserNode<String> transform(
    dynamic object, {
    String? title,
    required TransformerMap transformerMap,
  }) {
    if (object is List) {
      final parent = DataVisualiserNode(title: title ?? 'List', value: 'List');
      _walkList(object, parent);
      return parent;
    } else if (object is Map) {
      final parent = DataVisualiserNode(title: title ?? 'Map', value: 'Map');
      _walkMap(object, parent);
      return parent;
    } else if (object is JsonSupport) {
      final jsonData = object.toJson();
      final nodeTitle =
          object is TitleSupport ? (object as TitleSupport).getTitle() : title ?? 'Object';
      final parent = DataVisualiserNode(title: nodeTitle, value: 'Model');
      parent.addAll(
        jsonData.entries.map((e) {
          return transform(e.value, title: e.key, transformerMap: transformerMap);
        }).toList(),
      );
      // _walkObject(jsonData, parent);
      return parent;
    } else {
      return DataVisualiserNode(title: title ?? 'Object', value: object.toString());
    }
  }

  void _walkMap(Map map, TreeNode parent) {
    for (final entry in map.entries) {
      if (entry.value is String ||
          entry.value is int ||
          entry.value is double ||
          entry.value is bool) {
        parent.add(
          DataVisualiserNode(
            title: entry.key.toString(),
            value: entry.value.toString(),
          ),
        );
      } else if (entry.value is Map) {
        final mapParent = DataVisualiserNode(
          title: 'Map',
          value: entry.key,
        );
        _walkMap(entry.value as Map, mapParent);
        parent.add(mapParent);
      } else if (entry.value is List) {
        final listParent = DataVisualiserNode(
          title: 'List',
          value: entry.key,
        );
        _walkList(entry.value as List, listParent);
        parent.add(listParent);
      } else if (entry.value is JsonSupport) {
        final jsonData = (entry.value as JsonSupport).toJson();
        _walkObject(jsonData, parent);
      }
    }
  }

  void _walkList(List<dynamic> list, TreeNode parent) {
    for (final item in list) {
      if (item is String || item is int || item is double || item is bool) {
        parent.add(
          DataVisualiserNode(
            title: item.toString(),
            value: item.runtimeType,
          ),
        );
      } else if (item is Map) {
        final mapParent = DataVisualiserNode(title: 'Map', value: 'map parent');
        parent.add(mapParent);
        _walkMap(item, mapParent);
      } else if (item is List) {
        final listParent = DataVisualiserNode(title: 'List', value: 'list parent');
        parent.add(listParent);
        _walkList(item, listParent);
      } else if (item is JsonSupport) {
        final jsonData = item.toJson();
        _walkObject(jsonData, parent);
      }
    }
  }

  void _walkObject(dynamic object, TreeNode parent) {
    if (object is String || object is int || object is double || object is bool) {
      parent.add(DataVisualiserNode(title: 'Object', value: object.toString()));
    } else if (object is Map) {
      final mapParent = DataVisualiserNode(title: 'Map', value: 'map parent');
      parent.add(mapParent);
      _walkMap(object, mapParent);
    } else if (object is List) {
      final listParent = DataVisualiserNode(title: 'List', value: 'list parent');
      parent.add(listParent);
      _walkList(object, listParent);
    } else {}
  }
}
