import 'package:wt_data_visualiser/src/data_visualiser_node.dart';
import 'package:wt_data_visualiser/src/dynamic_tree_node_transformer.dart';

mixin TreeNodeTransformer<T, S> {
  static final TreeNodeTransformer<dynamic, String> defaultTransformer =
      DynamicTreeNodeTransformer();
  DataVisualiserNode<S> transform(T object, {String? title});
}
