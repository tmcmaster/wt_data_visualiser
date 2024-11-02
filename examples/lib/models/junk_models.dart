import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_models/wt_models.dart';

part 'junk_models.freezed.dart';
part 'junk_models.g.dart';

@freezed
class Experience extends BaseModel<Experience> with _$Experience {
  static final convert = DslConvert<Experience>(
    titles: ['yearsOfExperience', 'jobFunction', 'techFunction'],
    jsonToModel: Experience.fromJson,
    none: Experience.empty(),
  );

  factory Experience({
    @JsonKey(name: 'yearsOfExperience') required String? yearsOfExperience,
    @JsonKey(name: 'jobFunction') required JobFunction? jobFunction,
    @JsonKey(name: 'techFunction') required TechFunction? techFunction,
  }) = _Experience;

  Experience._();

  factory Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);

  factory Experience.empty() => Experience(
        yearsOfExperience: '',
        jobFunction: null,
        techFunction: null,
      );

  @override
  String getId() => yearsOfExperience ?? '';

  @override
  String getTitle() => '';

  @override
  List<String> getTitles() => convert.titles();
}

@freezed
class JobFunction extends BaseModel<JobFunction> with _$JobFunction {
  static final convert = DslConvert<JobFunction>(
    titles: ['skills'],
    jsonToModel: JobFunction.fromJson,
    none: JobFunction.empty(),
  );

  factory JobFunction({
    @JsonKey(name: 'skills') required List<Skill>? skills,
  }) = _JobFunction;

  JobFunction._();

  factory JobFunction.fromJson(Map<String, dynamic> json) => _$JobFunctionFromJson(json);

  factory JobFunction.empty() => JobFunction(skills: null);

  @override
  String getId() => '';

  @override
  String getTitle() => '';

  @override
  List<String> getTitles() => convert.titles();
}

@freezed
class TechFunction extends BaseModel<TechFunction> with _$TechFunction {
  static final convert = DslConvert<TechFunction>(
    titles: ['skills'],
    jsonToModel: TechFunction.fromJson,
    none: TechFunction.empty(),
  );

  factory TechFunction({
    @JsonKey(name: 'skills') required List<Skill>? skills,
  }) = _TechFunction;

  TechFunction._();

  factory TechFunction.fromJson(Map<String, dynamic> json) => _$TechFunctionFromJson(json);

  factory TechFunction.empty() => TechFunction(skills: null);

  @override
  String getId() => '';

  @override
  String getTitle() => '';

  @override
  List<String> getTitles() => convert.titles();
}

@freezed
class Skill extends BaseModel<Skill> with _$Skill {
  static final convert = DslConvert<Skill>(
    titles: ['name', 'proficiency'],
    jsonToModel: Skill.fromJson,
    none: Skill.empty(),
  );

  factory Skill({
    @JsonKey(name: 'name') required String? name,
    @JsonKey(name: 'proficiency') required Proficiency? proficiency,
  }) = _Skill;

  Skill._();

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);

  factory Skill.empty() => Skill(name: '', proficiency: null);

  @override
  String getId() => name ?? '';

  @override
  String getTitle() => '';

  @override
  List<String> getTitles() => convert.titles();
}

@freezed
class Proficiency extends BaseModel<Proficiency> with _$Proficiency {
  static final convert = DslConvert<Proficiency>(
    titles: [
      'years_rating',
      'achieved_rating',
      'status_rating',
      'potential_rating',
      'upskill_rating'
    ],
    jsonToModel: Proficiency.fromJson,
    none: Proficiency.empty(),
  );

  factory Proficiency({
    @JsonKey(name: 'years_rating') required int? yearsRating,
    @JsonKey(name: 'achieved_rating') required int? achievedRating,
    @JsonKey(name: 'status_rating') required int? statusRating,
    @JsonKey(name: 'potential_rating') required int? potentialRating,
    @JsonKey(name: 'upskill_rating') required int? upskillRating,
  }) = _Proficiency;

  Proficiency._();

  factory Proficiency.fromJson(Map<String, dynamic> json) => _$ProficiencyFromJson(json);

  factory Proficiency.empty() => Proficiency(
        yearsRating: null,
        achievedRating: null,
        statusRating: null,
        potentialRating: null,
        upskillRating: null,
      );

  @override
  String getId() => '';

  @override
  String getTitle() => '';

  @override
  List<String> getTitles() => convert.titles();
}
