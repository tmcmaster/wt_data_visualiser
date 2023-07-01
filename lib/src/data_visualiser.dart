import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wt_data_visualiser/src/tree_node_data.dart';
import 'package:wt_data_visualiser/src/tree_node_transform.dart';

class DataVisualiser extends StatefulWidget {
  final TreeNodeTransformer? transform;
  final dynamic object;
  final TreeNode? treeNode;
  final bool showSnackBar;
  final bool expandChildrenOnReady;

  DataVisualiser({
    super.key,
    this.transform,
    this.object,
    this.treeNode,
    this.showSnackBar = false,
    this.expandChildrenOnReady = false,
  }) {
    if (!(treeNode != null || object != null && transform != null)) {
      throw Exception('Either widget.treeNode, or object and transform, need to be non null.');
    }
  }

  @override
  DataVisualiserState createState() => DataVisualiserState();
}

class DataVisualiserState extends State<DataVisualiser> {
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
  TreeNode? _treeNode;

  @override
  void initState() {
    super.initState();
    final treeNode = widget.treeNode ?? widget.transform?.transform(widget.object);
    setState(() {
      _treeNode = treeNode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _treeNode == null
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Data Visualiser'),
            ),
            floatingActionButton: ValueListenableBuilder<bool>(
              valueListenable: _treeNode!.expansionNotifier,
              builder: (context, isExpanded, _) {
                return FloatingActionButton.extended(
                  onPressed: () {
                    if (_treeNode!.isExpanded) {
                      _controller?.collapseNode(_treeNode!);
                    } else {
                      _controller?.expandAllChildren(_treeNode!);
                    }
                  },
                  label: isExpanded ? const Text('Collapse all') : const Text('Expand all'),
                );
              },
            ),
            body: TreeView.simple(
              tree: _treeNode!,
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
                if (widget.expandChildrenOnReady) controller.expandAllChildren(_treeNode!);
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
