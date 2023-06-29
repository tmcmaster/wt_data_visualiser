import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wt_models/wt_models.dart';

final Map<int, Color> colorMapper = {
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

class DataVisualiserDemo extends StatelessWidget {
  final dynamic data;
  const DataVisualiserDemo({
    super.key,
    required this.data,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Animated Tree Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DataVisualiser(data: data),
    );
  }
}

class DataVisualiser extends StatefulWidget {
  final dynamic data;
  final bool showSnackBar;
  final bool expandChildrenOnReady;

  const DataVisualiser({
    super.key,
    required this.data,
    this.showSnackBar = false,
    this.expandChildrenOnReady = false,
  });

  @override
  DataVisualiserState createState() => DataVisualiserState();
}

class DataVisualiserState extends State<DataVisualiser> {
  TreeViewController? _controller;
  int keyIndex = 0;
  TreeNode? sampleTree;

  @override
  void initState() {
    super.initState();
    sampleTree = _createTreeNode(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return sampleTree == null
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Data Visualiser'),
            ),
            floatingActionButton: ValueListenableBuilder<bool>(
              valueListenable: sampleTree!.expansionNotifier,
              builder: (context, isExpanded, _) {
                return FloatingActionButton.extended(
                  onPressed: () {
                    if (sampleTree!.isExpanded) {
                      _controller?.collapseNode(sampleTree!);
                    } else {
                      _controller?.expandAllChildren(sampleTree!);
                    }
                  },
                  label: isExpanded ? const Text("Collapse all") : const Text("Expand all"),
                );
              },
            ),
            body: TreeView.simple(
              tree: sampleTree!,
              showRootNode: true,
              expansionIndicatorBuilder: (context, node) => ChevronIndicator.rightDown(
                tree: node,
                color: Colors.blue[700],
                padding: const EdgeInsets.all(8),
              ),
              indentation: const Indentation(style: IndentStyle.squareJoint),
              onItemTap: (item) {
                if (kDebugMode) print("Item tapped: ${item.key}");

                if (widget.showSnackBar) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Item tapped: ${item.key}"),
                      duration: const Duration(milliseconds: 750),
                    ),
                  );
                }
              },
              onTreeReady: (controller) {
                _controller = controller;
                if (widget.expandChildrenOnReady) controller.expandAllChildren(sampleTree!);
              },
              builder: (context, node) => Card(
                color: colorMapper[node.level.clamp(0, colorMapper.length - 1)]!,
                child: ListTile(
                  title: Text(node.data?.toString() ?? ''),
                  subtitle: const Text(''),
                ),
              ),
            ),
          );
  }

  String nextKey() {
    return (++keyIndex).toString();
  }

  TreeNode _createTreeNode(dynamic object) {
    if (object is List) {
      final parent = TreeNode(key: nextKey(), data: 'List');
      _walkList(object, parent);
      return parent;
    }
    if (object is Map) {
      final parent = TreeNode(key: nextKey(), data: 'Map');
      _walkMap(object, parent);
      return parent;
    }
    if (object is JsonSupport) {
      final jsonData = object.toJson();
      final parent = TreeNode(key: nextKey(), data: 'JsonSupport');
      _walkObject(jsonData, parent);
      return parent;
    } else {
      return TreeNode(key: nextKey(), data: object.toString());
    }
  }

  // TreeNode _listToTreeNode(List<dynamic> list) {
  //   final parent = TreeNode(key: nextKey(), data: 'Root Node');
  //   _walkList(list, parent);
  //   return parent;
  // }
  //
  // TreeNode _mapToTreeNode(Map map) {
  //   final parent = TreeNode(key: nextKey(), data: 'Root Node');
  //   _walkMap(map, parent);
  //   return parent;
  // }

  void _walkMap(Map map, TreeNode parent) {
    for (final entry in map.entries) {
      if (entry.value is String ||
          entry.value is int ||
          entry.value is double ||
          entry.value is bool) {
        parent.add(TreeNode(key: nextKey(), data: '${entry.key} : ${entry.value}'));
      } else if (entry.value is Map) {
        final mapParent = TreeNode(key: nextKey(), data: 'Map : ${entry.key}');
        _walkMap(entry.value as Map, mapParent);
        parent.add(mapParent);
      } else if (entry.value is List) {
        final listParent = TreeNode(key: nextKey(), data: 'List : ${entry.key}');
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
        parent.add(TreeNode(key: nextKey(), data: item));
      } else if (item is Map<String, dynamic>) {
        final mapParent = TreeNode(key: nextKey(), data: 'Map');
        parent.add(mapParent);
        _walkMap(item, mapParent);
      } else if (item is List) {
        final listParent = TreeNode(key: nextKey(), data: 'List');
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
      parent.add(TreeNode(key: nextKey(), data: object.toString()));
    } else if (object is Map) {
      final mapParent = TreeNode(key: nextKey(), data: 'Map');
      parent.add(mapParent);
      _walkMap(object, mapParent);
    } else if (object is List) {
      final listParent = TreeNode(key: nextKey(), data: 'List');
      parent.add(listParent);
      _walkList(object, listParent);
    } else {}
  }
}
