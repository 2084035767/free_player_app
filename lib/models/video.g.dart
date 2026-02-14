// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Video _$VideoFromJson(Map<String, dynamic> json) => _Video(
  vodId: (json['vod_id'] as num).toInt(),
  vodName: json['vod_name'] as String,
  typeId: (json['type_id'] as num).toInt(),
  typeName: json['type_name'] as String,
  vodPic: json['vod_pic'] as String,
  vodClass: json['vod_class'] as String,
  vodActor: json['vod_actor'] as String,
  vodDirector: json['vod_director'] as String,
  vodBlurb: json['vod_blurb'] as String,
  vodTime: json['vod_time'] as String,
  vodArea: json['vod_area'] as String,
  vodDoubanScore: json['vod_douban_score'] as String,
  vodYear: json['vod_year'] as String,
  vodContent: json['vod_content'] as String,
  vodRemarks: json['vod_remarks'] as String,
  vodPlayFrom: json['vod_play_from'] as String,
  vodPlayUrl: json['vod_play_url'] as String,
  vodDuration: json['vod_duration'] as String,
);

Map<String, dynamic> _$VideoToJson(_Video instance) => <String, dynamic>{
  'vod_id': instance.vodId,
  'vod_name': instance.vodName,
  'type_id': instance.typeId,
  'type_name': instance.typeName,
  'vod_pic': instance.vodPic,
  'vod_class': instance.vodClass,
  'vod_actor': instance.vodActor,
  'vod_director': instance.vodDirector,
  'vod_blurb': instance.vodBlurb,
  'vod_time': instance.vodTime,
  'vod_area': instance.vodArea,
  'vod_douban_score': instance.vodDoubanScore,
  'vod_year': instance.vodYear,
  'vod_content': instance.vodContent,
  'vod_remarks': instance.vodRemarks,
  'vod_play_from': instance.vodPlayFrom,
  'vod_play_url': instance.vodPlayUrl,
  'vod_duration': instance.vodDuration,
};
