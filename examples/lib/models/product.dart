import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_models/wt_models.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product extends BaseModel<Product> with _$Product, OrderSupport {
  static final convert = DslConvert<Product>(
    titles: ['id', 'title', 'price', 'weight'],
    jsonToModel: Product.fromJson,
    none: Product.empty(),
  );

  factory Product({
    required String id,
    required String title,
    required double order,
    required double price,
    required double weight,
  }) = _Product;

  Product._();

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  factory Product.empty() => Product(
        id: '',
        title: '',
        order: 0.0,
        price: 0.0,
        weight: 0.0,
      );

  @override
  String getId() => id;

  @override
  String getTitle() => title;

  @override
  double getOrder() => order;

  @override
  List<String> getTitles() => convert.titles();
}
