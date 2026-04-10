import 'dart:convert';

/// AI 教练服务 - 使用通义千问 (Qwen3.5-Plus) 生成训练计划
class AICoachService {
  static final AICoachService _instance = AICoachService._internal();
  factory AICoachService() => _instance;
  AICoachService._internal();

  /// 生成训练计划
  /// 
  /// [goal] 目标 (如：冈仁波齐转山)
  /// [challengeDate] 挑战日期
  /// [weeklyDays] 每周训练天数
  /// [sessionMinutes] 每次训练时长 (分钟)
  /// [fitnessLevel] 体能水平 (新手/入门/进阶/专业)
  /// [experience] 徒步经历 (无/1-2 次/3-5 次/5 次+)
  /// [healthConditions] 健康状况列表
  Future<TrainingPlan> generatePlan({
    required String goal,
    required DateTime challengeDate,
    required int weeklyDays,
    required int sessionMinutes,
    required String fitnessLevel,
    required String experience,
    required List<String> healthConditions,
  }) async {
    // 构建 Prompt
    final prompt = _buildPrompt(
      goal: goal,
      challengeDate: challengeDate,
      weeklyDays: weeklyDays,
      sessionMinutes: sessionMinutes,
      fitnessLevel: fitnessLevel,
      experience: experience,
      healthConditions: healthConditions,
    );

    // 调用 AI (使用 OpenClaw sessions_spawn)
    final aiResponse = await _callAI(prompt);

    // 解析响应
    return _parsePlan(aiResponse);
  }

  /// 构建 AI Prompt
  String _buildPrompt({
    required String goal,
    required DateTime challengeDate,
    required int weeklyDays,
    required int sessionMinutes,
    required String fitnessLevel,
    required String experience,
    required List<String> healthConditions,
  }) {
    final daysUntilChallenge = challengeDate.difference(DateTime.now()).inDays;
    final totalWeeks = (daysUntilChallenge / 7).floor();

    return '''
你是一名专业的徒步教练"卡卡"，擅长为徒步爱好者制定科学的训练计划。

## 用户信息
- **挑战目标**: $goal
- **挑战日期**: ${challengeDate.toString().split(' ')[0]} (距离今天还有 $daysUntilChallenge 天)
- **每周训练**: $weeklyDays 天
- **每次训练**: $sessionMinutes 分钟
- **当前体能**: $fitnessLevel
- **徒步经历**: $experience
- **健康状况**: ${healthConditions.isEmpty ? '无特殊状况' : healthConditions.join(', ')}

## 任务
请为用户生成一个 ${totalWeeks}周的渐进式训练计划。

## 要求
1. **科学性**: 遵循渐进超负荷原则，从低强度逐步提升
2. **个性化**: 根据用户体能水平和经历定制
3. **可执行**: 训练内容切实可行，不需要专业设备
4. **安全性**: 考虑用户健康状况，避免过度训练
5. **多样性**: 结合有氧、无氧、力量、柔韧性训练

## 输出格式
请严格按照以下 JSON 格式返回 (不要包含 Markdown 格式):

{
  "name": "计划名称",
  "description": "计划描述",
  "totalWeeks": 周数,
  "weeklyDays": $weeklyDays,
  "sessionMinutes": $sessionMinutes,
  "phases": [
    {
      "name": "阶段名称",
      "weeks": "1-4",
      "focus": "训练重点",
      "aerobicRatio": 70,
      "anaerobicRatio": 30,
      "description": "阶段描述"
    }
  ],
  "weeklySchedule": [
    {
      "week": 1,
      "theme": "本周主题",
      "days": [
        {
          "day": 1,
          "type": "有氧",
          "activity": "快走",
          "duration": 30,
          "intensity": "低",
          "heartRateZone": "热身区",
          "calories": 200,
          "tips": "训练提示"
        }
      ],
      "restDays": [5, 7],
      "totalCalories": 1500
    }
  ],
  "milestones": [
    {"week": 4, "goal": "4 周里程碑"},
    {"week": 8, "goal": "8 周里程碑"}
  ],
  "tips": ["通用建议 1", "通用建议 2"]
}

## 注意事项
- 训练强度用：低/中/高/极高
- 心率区间用：热身区 (50-60%)/燃脂区 (60-70%)/有氧区 (70-80%)/无氧区 (80-90%)
- 活动类型：快走/慢跑/徒步/登山/力量训练/拉伸/休息
- 确保计划适合$fitnessLevel 水平的用户
- 如果$experience 较少，前 2 周以适应性训练为主

现在请生成这个训练计划。
''';
  }

  /// 调用 AI
  /// 
  /// 使用 OpenClaw sessions_spawn 调用 Qwen3.5-Plus
  Future<String> _callAI(String prompt) async {
    // TODO: 实现 OpenClaw sessions_spawn 调用
    // 这里使用模拟数据用于开发测试
    
    await Future.delayed(const Duration(seconds: 2));
    
    // 返回模拟的测试数据
    return _getMockPlan();
  }

  /// 解析 AI 响应
  TrainingPlan _parsePlan(String jsonResponse) {
    try {
      final data = json.decode(jsonResponse);
      return TrainingPlan.fromJson(data);
    } catch (e) {
      throw Exception('解析 AI 响应失败：$e');
    }
  }

  /// 模拟数据 (开发测试用)
  String _getMockPlan() {
    return json.encode({
      "name": "冈仁波齐转山备战计划",
      "description": "16 周渐进式训练，帮助你完成冈仁波齐转山挑战",
      "totalWeeks": 16,
      "weeklyDays": 5,
      "sessionMinutes": 60,
      "phases": [
        {
          "name": "基础适应期",
          "weeks": "1-4",
          "focus": "建立有氧基础，适应训练节奏",
          "aerobicRatio": 80,
          "anaerobicRatio": 20,
          "description": "以低强度有氧训练为主，逐步建立运动习惯"
        },
        {
          "name": "能力提升期",
          "weeks": "5-8",
          "focus": "提升心肺功能和肌肉耐力",
          "aerobicRatio": 70,
          "anaerobicRatio": 30,
          "description": "增加训练强度和时长，加入力量训练"
        },
        {
          "name": "强化突破期",
          "weeks": "9-12",
          "focus": "模拟高原环境，强化专项能力",
          "aerobicRatio": 60,
          "anaerobicRatio": 40,
          "description": "增加爬升训练和长距离徒步"
        },
        {
          "name": "赛前调整期",
          "weeks": "13-16",
          "focus": "减量调整，保持状态",
          "aerobicRatio": 70,
          "anaerobicRatio": 30,
          "description": "逐步减少训练量，保持训练强度"
        }
      ],
      "weeklySchedule": List.generate(16, (index) => {
        "week": index + 1,
        "theme": "第${index + 1}周训练主题",
        "days": List.generate(5, (d) => {
          "day": d + 1,
          "type": d < 3 ? "有氧" : "力量",
          "activity": d < 3 ? "快走/慢跑" : "核心训练",
          "duration": 60,
          "intensity": ["低", "中", "高"][d % 3],
          "heartRateZone": ["热身区", "燃脂区", "有氧区"][d % 3],
          "calories": 300 + d * 50,
          "tips": "保持正确姿势，注意呼吸节奏"
        }),
        "restDays": [6, 7],
        "totalCalories": 2000 + index * 100
      }),
      "milestones": [
        {"week": 4, "goal": "连续运动 30 分钟无压力"},
        {"week": 8, "goal": "完成 10km 徒步"},
        {"week": 12, "goal": "完成 20km 长距离拉练"},
        {"week": 16, "goal": "达到最佳竞技状态"}
      ],
      "tips": [
        "训练前充分热身，训练后拉伸放松",
        "保持充足睡眠和营养摄入",
        "记录训练数据，及时调整计划",
        "如有不适立即停止并休息"
      ]
    });
  }
}

/// 训练计划模型
class TrainingPlan {
  final String id;
  final String name;
  final String description;
  final int totalWeeks;
  final int weeklyDays;
  final int sessionMinutes;
  final List<TrainingPhase> phases;
  final List<WeekPlan> weeklySchedule;
  final List<Milestone> milestones;
  final List<String> tips;
  final DateTime createdAt;

  TrainingPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.totalWeeks,
    required this.weeklyDays,
    required this.sessionMinutes,
    required this.phases,
    required this.weeklySchedule,
    required this.milestones,
    required this.tips,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory TrainingPlan.fromJson(Map<String, dynamic> json) {
    return TrainingPlan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      totalWeeks: json['totalWeeks'] ?? 0,
      weeklyDays: json['weeklyDays'] ?? 0,
      sessionMinutes: json['sessionMinutes'] ?? 0,
      phases: (json['phases'] as List?)
              ?.map((p) => TrainingPhase.fromJson(p))
              .toList() ??
          [],
      weeklySchedule: (json['weeklySchedule'] as List?)
              ?.map((w) => WeekPlan.fromJson(w))
              .toList() ??
          [],
      milestones: (json['milestones'] as List?)
              ?.map((m) => Milestone.fromJson(m))
              .toList() ??
          [],
      tips: (json['tips'] as List?)?.map((t) => t.toString()).toList() ?? [],
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
      'phases': phases.map((p) => p.toJson()).toList(),
      'weeklySchedule': weeklySchedule.map((w) => w.toJson()).toList(),
      'milestones': milestones.map((m) => m.toJson()).toList(),
      'tips': tips,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

/// 训练阶段
class TrainingPhase {
  final String name;
  final String weeks;
  final String focus;
  final int aerobicRatio;
  final int anaerobicRatio;
  final String description;

  TrainingPhase({
    required this.name,
    required this.weeks,
    required this.focus,
    required this.aerobicRatio,
    required this.anaerobicRatio,
    required this.description,
  });

  factory TrainingPhase.fromJson(Map<String, dynamic> json) {
    return TrainingPhase(
      name: json['name'] ?? '',
      weeks: json['weeks'] ?? '',
      focus: json['focus'] ?? '',
      aerobicRatio: json['aerobicRatio'] ?? 0,
      anaerobicRatio: json['anaerobicRatio'] ?? 0,
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'weeks': weeks,
      'focus': focus,
      'aerobicRatio': aerobicRatio,
      'anaerobicRatio': anaerobicRatio,
      'description': description,
    };
  }
}

/// 周计划
class WeekPlan {
  final int week;
  final String theme;
  final List<DayPlan> days;
  final List<int> restDays;
  final int totalCalories;

  WeekPlan({
    required this.week,
    required this.theme,
    required this.days,
    required this.restDays,
    required this.totalCalories,
  });

  factory WeekPlan.fromJson(Map<String, dynamic> json) {
    return WeekPlan(
      week: json['week'] ?? 0,
      theme: json['theme'] ?? '',
      days: (json['days'] as List?)
              ?.map((d) => DayPlan.fromJson(d))
              .toList() ??
          [],
      restDays: (json['restDays'] as List?)?.map((d) => d as int).toList() ?? [],
      totalCalories: json['totalCalories'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'week': week,
      'theme': theme,
      'days': days.map((d) => d.toJson()).toList(),
      'restDays': restDays,
      'totalCalories': totalCalories,
    };
  }
}

/// 日计划
class DayPlan {
  final int day;
  final String type;
  final String activity;
  final int duration;
  final String intensity;
  final String heartRateZone;
  final int calories;
  final String tips;

  DayPlan({
    required this.day,
    required this.type,
    required this.activity,
    required this.duration,
    required this.intensity,
    required this.heartRateZone,
    required this.calories,
    required this.tips,
  });

  factory DayPlan.fromJson(Map<String, dynamic> json) {
    return DayPlan(
      day: json['day'] ?? 0,
      type: json['type'] ?? '',
      activity: json['activity'] ?? '',
      duration: json['duration'] ?? 0,
      intensity: json['intensity'] ?? '',
      heartRateZone: json['heartRateZone'] ?? '',
      calories: json['calories'] ?? 0,
      tips: json['tips'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'type': type,
      'activity': activity,
      'duration': duration,
      'intensity': intensity,
      'heartRateZone': heartRateZone,
      'calories': calories,
      'tips': tips,
    };
  }
}

/// 里程碑
class Milestone {
  final int week;
  final String goal;

  Milestone({
    required this.week,
    required this.goal,
  });

  factory Milestone.fromJson(Map<String, dynamic> json) {
    return Milestone(
      week: json['week'] ?? 0,
      goal: json['goal'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'week': week,
      'goal': goal,
    };
  }
}
