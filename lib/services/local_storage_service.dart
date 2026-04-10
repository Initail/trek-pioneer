import 'package:hive_flutter/hive_flutter.dart';
import '../models/plan.dart';

/// 本地存储服务
class LocalStorageService {
  static final LocalStorageService _instance =
      LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  static const String _plansBoxName = 'training_plans';
  static const String _checkinsBoxName = 'daily_checkins';
  static const String _statsBoxName = 'user_stats';

  late Box<TrainingPlanHive> _plansBox;
  late Box<DailyCheckIn> _checkinsBox;
  late Box<UserStats> _statsBox;

  /// 初始化 Hive
  Future<void> init() async {
    await Hive.initFlutter();

    // 注册适配器
    Hive.registerAdapter(TrainingPlanHiveAdapter());
    Hive.registerAdapter(DailyCheckInAdapter());
    Hive.registerAdapter(UserStatsAdapter());

    // 打开 Box
    _plansBox = await Hive.openBox<TrainingPlanHive>(_plansBoxName);
    _checkinsBox = await Hive.openBox<DailyCheckIn>(_checkinsBoxName);
    _statsBox = await Hive.openBox<UserStats>(_statsBoxName);
  }

  // ========== 计划管理 ==========

  /// 保存计划
  Future<void> savePlan(TrainingPlanHive plan) async {
    await _plansBox.put(plan.id, plan);
  }

  /// 获取所有计划
  List<TrainingPlanHive> getAllPlans() {
    return _plansBox.values.toList();
  }

  /// 获取活跃计划
  List<TrainingPlanHive> getActivePlans() {
    return _plansBox.values.where((p) => p.isActive).toList();
  }

  /// 获取计划
  TrainingPlanHive? getPlan(String id) {
    return _plansBox.get(id);
  }

  /// 删除计划
  Future<void> deletePlan(String id) async {
    await _plansBox.delete(id);
    // 同时删除相关的打卡记录
    final checkins = _checkinsBox.values.where((c) => c.planId == id);
    for (final checkin in checkins) {
      await _checkinsBox.delete(checkin.key);
    }
  }

  /// 更新计划周数
  Future<void> updateCurrentWeek(String id, int week) async {
    final plan = _plansBox.get(id);
    if (plan != null) {
      plan.currentWeek = week;
      await plan.save();
    }
  }

  // ========== 打卡管理 ==========

  /// 保存打卡
  Future<void> saveCheckIn(DailyCheckIn checkin) async {
    await _checkinsBox.put(checkin.id, checkin);
  }

  /// 获取某天的打卡
  DailyCheckIn? getCheckIn(String planId, DateTime date) {
    final key = '${planId}_${date.year}-${date.month}-${date.day}';
    return _checkinsBox.get(key);
  }

  /// 获取某周的所有打卡
  List<DailyCheckIn> getWeekCheckIns(String planId, int week) {
    return _checkinsBox.values
        .where((c) => c.planId == planId && c.week == week)
        .toList();
  }

  /// 获取完成率
  double getCompletionRate(String planId) {
    final checkins =
        _checkinsBox.values.where((c) => c.planId == planId).toList();
    if (checkins.isEmpty) return 0.0;
    final completed = checkins.where((c) => c.completed).length;
    return completed / checkins.length;
  }

  // ========== 用户统计 ==========

  /// 获取用户统计
  UserStats getUserStats() {
    return _statsBox.get('user_stats') ?? UserStats();
  }

  /// 更新用户统计
  Future<void> updateStats(int duration, int calories) async {
    final stats = getUserStats();
    stats.addWorkout(duration, calories);
    await stats.save();
  }

  /// 清空数据
  Future<void> clearAll() async {
    await _plansBox.clear();
    await _checkinsBox.clear();
    await _statsBox.clear();
  }
}
