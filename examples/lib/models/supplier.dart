import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_models/wt_models.dart';

part 'supplier.freezed.dart';
part 'supplier.g.dart';

@freezed
class Supplier extends BaseModel<Supplier> with _$Supplier {
  static final convert = DslConvert<Supplier>(
    titles: ['id', 'name'],
    jsonToModel: Supplier.fromJson,
    none: Supplier.empty(),
  );

  factory Supplier({
    required String id,
    required String name,
    required String code,
  }) = _Supplier;

  Supplier._();

  factory Supplier.fromJson(Map<String, dynamic> json) => _$SupplierFromJson(json);

  factory Supplier.empty() => Supplier(
        id: '',
        name: '',
        code: '',
      );

  @override
  String getId() => id;

  @override
  String getTitle() => name;

  @override
  List<String> getTitles() => convert.titles();
}
