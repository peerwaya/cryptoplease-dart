// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perf_sample.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerfSample _$PerfSampleFromJson(Map<String, dynamic> json) => PerfSample(
      slot: json['slot'] as int,
      numTransactions: json['numTransactions'] as int,
      numSlots: json['numSlots'] as int,
      samplePeriodSecs: json['samplePeriodSecs'] as int,
    );

Map<String, dynamic> _$PerfSampleToJson(PerfSample instance) =>
    <String, dynamic>{
      'slot': instance.slot,
      'numTransactions': instance.numTransactions,
      'numSlots': instance.numSlots,
      'samplePeriodSecs': instance.samplePeriodSecs,
    };
