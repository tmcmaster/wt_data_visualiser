import 'package:flutter/material.dart';
import 'package:wt_data_visualiser/wt_data_visualiser.dart';

class DataVisualiserPageView extends StatefulWidget {
  final Map<String, dynamic> dataSets;

  const DataVisualiserPageView({
    super.key,
    required this.dataSets,
  });
  @override
  State<DataVisualiserPageView> createState() => _DataVisualiserPageViewState();
}

class _DataVisualiserPageViewState extends State<DataVisualiserPageView> {
  final _controller = PageController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: PageView(
        controller: _controller,
        children: widget.dataSets.entries
            .map(
              (e) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: DataVisualiser(
                      title: e.key,
                      object: e.value,
                      objectLabel: (e.value is Type)
                          ? (e.value as Type).runtimeType.toString()
                          : e.value.toString(),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
