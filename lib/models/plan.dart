import 'package:hive/hive.dart';

part 'plan.g.dart';

/// 训练计划 (Hive 模型)
@HiveType(typeId: 0)
class TrainingPlanHive extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  int totalWeeks;

  @HiveField(4)
  int weeklyDays;

  @HiveField(5)
  int sessionMinutes;

  @HiveField(6)
  DateTime createdAt;

  @HiveField(7)
  int currentWeek;

  @HiveField(8)
  bool isActive;

  TrainingPlanHive({
    required this.id,
    required this.name,
    required this.description,
    required this.totalWeeks,
    required this.weeklyDays,
    required this.sessionMinutes,
    required this.createdAt,
    this.currentWeek = 1,
    this.isActive = true,
  });

  factory TrainingPlanHive.fromJson(Map<String, dynamic> json) {
    return TrainingPlanHive(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      totalWeeks: json['totalWeeks'] as int,
      weeklyDays: json['weeklyDays'] as int,
      sessionMinutes: json['sessionMinutes'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      currentWeek: json['currentWeek'] as int? ?? 1,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'totalWeeks': totalWeeks,
      'weeklyDays': weeklyDays,
      'sessionMinutes': sessionMinutes,
      'createdAt': createdAt.toIso8601String(),
      'currentWeek': currentWeek,
      'isActive': isActive,
    };
  }
}

/// 每日打卡记录
@HiveType(typeId: 1)
class DailyCheckIn extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String planId;

  @HiveField(2)
  int week;

  @HiveField(3)
  int day;

  @HiveField(4)
  DateTime date;

  @HiveField(5)
  bool completed;

  @HiveField(6)
  int actualDuration;

  @HiveField(7)
  int actualCalories;

  @HiveField(8)
  String? notes;

  @HiveField(9)
  DateTime? completedAt;

  DailyCheckIn({
    required this.id,
    required this.planId,
    required this.week,
    required this.day,
    required this.date,
    this.completed = false,
    this.actualDuration = 0,
    this.actualCalories = 0,
    this.notes,
    this.completedAt,
  });

  factory DailyCheckIn.fromJson(Map<String, dynamic> json) {
    return DailyCheckIn(
      id: json['id'] as String,
      planId: json['planId'] as String,
      week: json['week'] as int,
      day: json['day'] as int,
      date: DateTime.parse(json['date'] as String),
      completed: json['completed'] as bool? ?? false,
      actualDuration: json['actualDuration'] as int? ?? 0,
      actualCalories: json['actualCalories'] as int? ?? 0,
      notes: json['notes'] as String?,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'planId': planId,
      'week': week,
      'day': day,
      'date': date.toIso8601String(),
      'completed': completed,
      'actualDuration': actualDuration,
      'actualCalories': actualCalories,
      'notes': notes,
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  /// 标记为完成
  void markCompleted({
    required int duration,
    required int calories,
    String? notes,
  }) {
    completed = true;
    actualDuration = duration;
    actualCalories = calories;
    this.notes = notes;
    completedAt = DateTime.now();
    save();
  }
}

/// 用户统计数据
@HiveType(typeId: 2)
class UserStats extends HiveObject {
  @HiveField(0)
  int totalWorkouts;

  @HiveField(1)
  int totalDuration;

  @HiveField(2)
  int totalCalories;

  @HiveField(3)
  int longestStreak;

  @HiveField(4)
  int currentStreak;

  @HiveField(5)
  DateTime lastWorkoutDate;

  UserStats({
    this.totalWorkouts = 0,
    this.totalDuration = 0,
    this.totalCalories = 0,
    this.longestStreak = 0,
    this.currentStreak = 0,
    DateTime? lastWorkoutDate,
  }) : lastWorkoutDate = lastWorkoutDate ?? DateTime(2000);

  /// 更新统计数据
  void addWorkout(int duration, int calories) {
    totalWorkouts++;
    totalDuration += duration;
    totalCalories += calories;

    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));

    if (lastWorkoutDate.isAtSameMomentAs(yesterday) ||
        lastWorkoutDate.isAtSameMomentAs(today)) {
      currentStreak++;
      if (currentStreak > longestStreak) {
        longestStreak = currentStreak;
      }
    } else {
      currentStreak = 1;
    }

    lastWorkoutDate = today;
    save();
  }
}
