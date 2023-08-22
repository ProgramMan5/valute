// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyData _$CurrencyDataFromJson(Map<String, dynamic> json) => CurrencyData(
      id: json['ID'] as String,
      numCode: json['NumCode'] as String,
      charCode: json['CharCode'] as String,
      nominal: json['Nominal'] as int,
      name: json['Name'] as String,
      value: (json['Value'] as num).toDouble(),
      previous: (json['Previous'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrencyDataToJson(CurrencyData instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'NumCode': instance.numCode,
      'CharCode': instance.charCode,
      'Nominal': instance.nominal,
      'Name': instance.name,
      'Value': instance.value,
      'Previous': instance.previous,
    };