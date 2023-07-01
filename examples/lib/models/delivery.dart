import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_data_visualiser_examples/models/customer.dart';
import 'package:wt_data_visualiser_examples/models/driver.dart';
import 'package:wt_data_visualiser_examples/models/supplier.dart';
import 'package:wt_models/wt_models.dart';

part 'delivery.freezed.dart';
part 'delivery.g.dart';

@freezed
class Delivery extends BaseModel<Delivery> with _$Delivery {
  static final convert = DslConvert<Delivery>(
    titles: ['customer', 'driver', 'supplier'],
    jsonToModel: Delivery.fromJson,
    none: Delivery.empty(),
  );

  factory Delivery({
    Customer? customer,
    Driver? driver,
    Supplier? supplier,
  }) = _Delivery;

  Delivery._();

  factory Delivery.fromJson(Map<String, dynamic> json) => _$DeliveryFromJson(json);

  factory Delivery.empty() => Delivery();

  @override
  String getId() => customer?.getId() ?? driver?.getId() ?? supplier?.getId() ?? '';

  @override
  String getTitle() => customer?.getTitle() ?? 'Customer';

  @override
  List<String> getTitles() => convert.titles();
}
