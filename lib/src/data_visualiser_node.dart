import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:wt_data_visualiser/src/tree_node_data.dart';

class DataVisualiserNode<S> extends TreeNode<TreeNodeData<S>> {
  static int _nodeKey = 0;

  DataVisualiserNode({
    required String title,
    required S value,
  }) : super(
          key: (++_nodeKey).toString(),
          data: TreeNodeData(title: title, value: value),
        );
}
