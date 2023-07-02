import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wt_data_visualiser/src/tree_node_data.dart';
import 'package:wt_data_visualiser/src/tree_node_transform.dart';
import 'package:wt_models/wt_models.dart';

class DataVisualiser extends StatelessWidget {
  final String title;
  final bool showSnackBar;
  final bool expandChildrenOnReady;
  final TreeNode _treeNode;
  DataVisualiser({
    super.key,
    dynamic object,
    TransformerMap transformMap = const {},
    String? objectLabel,
    this.title = 'Data Visualiser',
    this.showSnackBar = false,
    this.expandChildrenOnReady = false,
  }) : _treeNode = _getParentTreeNode(transformMap, object, objectLabel);

  static Type _getType(dynamic object) {
    return object is TypeSupport ? object.getType() : object.runtimeType;
  }

  static TreeNode _getParentTreeNode(
    TransformerMap transformerMap,
    dynamic object,
    String? objectLabel,
  ) {
    return _getTransformer(transformerMap, object).transform(
      object,
      transformerMap: transformerMap,
      title: objectLabel,
    );
  }

  static TreeNodeTransformer _getTransformer(TransformerMap transformerMap, dynamic object) {
    return transformerMap[_getType(object)] ?? TreeNodeTransformer.defaultTransformer;
  }

  @override
  Widget build(BuildContext context) {
    return _DataVisualiserWidget(
      title: title,
      treeNode: _treeNode,
      showSnackBar: false,
      expandChildrenOnReady: true,
    );
  }
}

class _DataVisualiserWidget extends StatefulWidget {
  final String title;
  final TreeNode treeNode;
  final bool showSnackBar;
  final bool expandChildrenOnReady;

  const _DataVisualiserWidget({
    required this.title,
    required this.treeNode,
    this.showSnackBar = false,
    this.expandChildrenOnReady = false,
  });

  @override
  DataVisualiserWidgetState createState() => DataVisualiserWidgetState();
}

class DataVisualiserWidgetState extends State<_DataVisualiserWidget> {
  static final Map<int, Color> _colorMapper = {
    0: Colors.white,
    1: Colors.blueGrey[50]!,
    2: Colors.blueGrey[100]!,
    3: Colors.blueGrey[200]!,
    4: Colors.blueGrey[300]!,
    5: Colors.blueGrey[400]!,
    6: Colors.blueGrey[500]!,
    7: Colors.blueGrey[600]!,
    8: Colors.blueGrey[700]!,
    9: Colors.blueGrey[800]!,
    10: Colors.blueGrey[900]!,
  };

  TreeViewController? _controller;

  @override
  Widget build(BuildContext context) {
    final treeNode = widget.treeNode;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: treeNode.expansionNotifier,
        builder: (context, isExpanded, _) {
          return FloatingActionButton.extended(
            onPressed: () {
              if (treeNode.isExpanded) {
                _controller?.collapseNode(treeNode);
              } else {
                _controller?.expandAllChildren(treeNode);
              }
            },
            label: isExpanded ? const Text('Collapse all') : const Text('Expand all'),
          );
        },
      ),
      body: TreeView.simple(
        tree: treeNode,
        showRootNode: true,
        expansionIndicatorBuilder: (context, node) => ChevronIndicator.rightDown(
          tree: node,
          color: Colors.blue[700],
          padding: const EdgeInsets.all(8),
        ),
        indentation: const Indentation(
          style: IndentStyle.squareJoint,
        ),
        onItemTap: (item) {
          if (kDebugMode) print('Item tapped: ${item.key}');

          if (widget.showSnackBar) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Item tapped: ${item.key}'),
                duration: const Duration(milliseconds: 750),
              ),
            );
          }
        },
        onTreeReady: (controller) {
          _controller = controller;
          if (widget.expandChildrenOnReady) controller.expandAllChildren(treeNode);
        },
        builder: (context, TreeNode node) {
          final data = node.data as TreeNodeData;
          return Card(
            color: _colorMapper[node.level.clamp(0, _colorMapper.length - 1)],
            child: ListTile(
              title: Text(data.title),
              subtitle: Text(data.value.toString()),
            ),
          );
        },
      ),
    );
  }
}
