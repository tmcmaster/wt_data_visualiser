import 'package:wt_data_visualiser/src/data_visualiser_node.dart';
import 'package:wt_data_visualiser/src/object_to_tree_node_transform.dart';

typedef TransformerMap = Map<Type, TreeNodeTransformer<dynamic, String>>;

mixin TreeNodeTransformer<O, T> {
  static final TreeNodeTransformer<dynamic, String> defaultTransformer =
      ObjectToTreeNodeTransform();

  DataVisualiserNode<T> transform(
    O object, {
    String? title,
    required TransformerMap transformerMap,
  });
}
