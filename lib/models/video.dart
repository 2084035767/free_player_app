import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
abstract class Video with _$Video {
  const factory Video({
    @JsonKey(name: 'vod_id') required int vodId,
    @JsonKey(name: 'vod_name') required String vodName,
    @JsonKey(name: 'type_id') required int typeId,
    @JsonKey(name: 'type_name') required String typeName,
    @JsonKey(name: 'vod_pic') required String vodPic,
    @JsonKey(name: 'vod_class') required String vodClass,
    @JsonKey(name: 'vod_actor') required String vodActor,
    @JsonKey(name: 'vod_director') required String vodDirector,
    @JsonKey(name: 'vod_blurb') required String vodBlurb,
    @JsonKey(name: 'vod_time') required String vodTime,
    @JsonKey(name: 'vod_area') required String vodArea,
    @JsonKey(name: 'vod_douban_score') required String vodDoubanScore,
    @JsonKey(name: 'vod_year') required String vodYear,
    @JsonKey(name: 'vod_content') required String vodContent,
    @JsonKey(name: 'vod_remarks') required String vodRemarks,
    @JsonKey(name: 'vod_play_from') required String vodPlayFrom,
    @JsonKey(name: 'vod_play_url') required String vodPlayUrl,
    @JsonKey(name: 'vod_duration') required String vodDuration,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
}
