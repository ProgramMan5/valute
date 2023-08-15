import 'package:json_annotation/json_annotation.dart';
part 'currency_data.g.dart';
@JsonSerializable()
class CurrencyData {
  @JsonKey(name: 'ID')
  final String id;
  @JsonKey(name: 'NumCode')
  final String numCode;
  @JsonKey(name: 'CharCode')
  final String charCode;
  @JsonKey(name: 'Nominal')
  final int nominal;
  @JsonKey(name: 'Name')
  final String name;
  @JsonKey(name: 'Value')
  final double value;
  @JsonKey(name: 'Previous')
  final double previous;
  CurrencyData({
    required this.id,
    required this.numCode,
    required this.charCode,
    required this.nominal,
    required this.name,
    required this.value,
    required this.previous,
  });
  factory CurrencyData.fromJson(Map<String, dynamic> json) => _$CurrencyDataFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyDataToJson(this);
}