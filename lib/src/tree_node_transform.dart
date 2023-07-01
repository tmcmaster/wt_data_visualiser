import 'package:wt_data_visualiser/src/data_visualiser_node.dart';
import 'package:wt_data_visualiser/src/object_to_tree_node_transform.dart';

mixin TreeNodeTransformer<T, S> {
  static final TreeNodeTransformer<dynamic, String> defaultTransformer =
      ObjectToTreeNodeTransform();
  DataVisualiserNode<S> transform(T object, {String? title});
}
