import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:uuid/uuid.dart';
import 'package:wt_data_visualiser/src/tree_node_data.dart';

class DataVisualiserNode<S> extends TreeNode<TreeNodeData<S>> {
  static const Uuid uuid = Uuid();

  DataVisualiserNode({
    required String title,
    required S value,
  }) : super(
          key: uuid.v4(),
          data: TreeNodeData(title: title, value: value),
        );
}
