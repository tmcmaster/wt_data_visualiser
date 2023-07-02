import 'package:wt_models/wt_models.dart';

class TreeNodeData<T> {
  final String title;
  final T value;
  final Type type;

  TreeNodeData({
    required this.title,
    required this.value,
  }) : type = value is TypeSupport ? value.getType() : value.runtimeType;
}
