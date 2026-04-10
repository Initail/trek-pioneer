# Phase 2 - 计划制定系统实施计划

**版本**: v1.0  
**启动时间**: 2026-04-10  
**预计完成**: 2026-04-24 (2 周)

---

## 🎯 Phase 2 目标

实现完整的 AI 计划制定功能，让用户可以：
1. 通过 4 步向导创建个性化训练计划
2. AI 自动生成科学的训练方案
3. 跟踪计划执行进度
4. 智能调整训练强度

---

## 📋 技术选型确认

### AI 服务
| 项目 | 选择 | 说明 |
|------|------|------|
| **模型** | Qwen3.5-Plus (通义千问) | OpenClaw 内置，无需额外 API Key |
| **调用方式** | 直接调用 sessions_spawn | 使用 subagent 生成计划 |
| **响应格式** | JSON | 结构化训练计划数据 |
| **成本** | 免费 | 使用现有 OpenClaw 配额 |

### 数据存储
| 项目 | 选择 | 说明 |
|------|------|------|
| **本地存储** | Hive | Flutter 轻量级 NoSQL |
| **云端存储** | 阿里云 MySQL | 用户数据/计划数据 |
| **缓存** | SharedPreferences | 简单配置项 |

### 网络请求
| 项目 | 选择 | 说明 |
|------|------|------|
| **HTTP 客户端** | Dio 5.4.0 | 支持拦截器/重试 |
| **API 格式** | RESTful JSON | 标准 REST 接口 |
| **认证** | JWT Token | 用户身份验证 |

### 状态管理
| 项目 | 选择 | 说明 |
|------|------|------|
| **方案** | Provider 6.1.1 | 简单易用，适合中小型项目 |
| **替代方案** | Riverpod | 如需更强类型安全 |

### 地图服务 (Phase 3)
| 项目 | 选择 | 说明 |
|------|------|------|
| **地图 SDK** | 高德地图 Flutter | 国内覆盖好，免费额度充足 |
| **轨迹记录** | location 5.0.0 + flutter_map | GPS 定位 + 离线地图 |

---

## 🔧 Phase 2 任务分解

### Task 1: AI 计划生成接口 (3 天)

**目标**: 实现 AI 调用生成训练计划

**子任务**:
1. [ ] 创建 AI 服务类 `lib/services/ai_coach_service.dart`
2. [ ] 实现计划生成 Prompt 模板
3. [ ] 解析 AI 返回的 JSON 计划
4. [ ] 错误处理和重试机制
5. [ ] 单元测试

**代码结构**:
```dart
// lib/services/ai_coach_service.dart
class AICoachService {
  Future<TrainingPlan> generatePlan({
    required String goal,
    required DateTime challengeDate,
    required int weeklyDays,
    required FitnessLevel level,
    required Experience experience,
  });
}

// lib/models/training_plan.dart
class TrainingPlan {
  String id;
  String name;
  int totalDays;
  List<WeekPlan> weeks;
  // ...
}
```

**AI Prompt 示例**:
```
你是一名专业的徒步教练"卡卡"。请根据用户情况生成训练计划。

用户信息:
- 目标：冈仁波齐转山 (52km, 海拔 5656m)
- 挑战日期：2026-09-15
- 当前体能：入门 (每周 1-2 次运动)
- 徒步经历：3-5 次
- 健康状况：无特殊状况

请生成一个 16 周的渐进式训练计划，包含:
1. 每周训练主题
2. 每周训练天数
3. 有氧/无氧比例
4. 预计消耗卡路里
5. 关键训练内容

以 JSON 格式返回。
```

---

### Task 2: 数据持久化 (2 天)

**目标**: 实现本地数据存储

**子任务**:
1. [ ] 添加 Hive 依赖到 `pubspec.yaml`
2. [ ] 创建数据模型 `lib/models/`
3. [ ] 实现 Hive Box 初始化
4. [ ] 实现 CRUD 操作
5. [ ] 数据迁移支持

**代码结构**:
```dart
// lib/models/plan.dart
@HiveType(typeId: 0)
class TrainingPlan extends HiveObject {
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String name;
  
  @HiveField(2)
  DateTime createdAt;
  
  @HiveField(3)
  List<WeekPlan> weeks;
}

// lib/services/local_storage_service.dart
class LocalStorageService {
  Future<void> savePlan(TrainingPlan plan);
  Future<List<TrainingPlan>> getPlans();
  Future<void> deletePlan(String id);
}
```

---

### Task 3: 计划执行跟踪 (3 天)

**目标**: 实现每日打卡和进度跟踪

**子任务**:
1. [ ] 创建打卡界面 `lib/screens/daily_checkin.dart`
2. [ ] 实现打卡数据模型
3. [ ] 进度计算逻辑
4. [ ] 完成度可视化
5. [ ] 提醒通知

**界面设计**:
```
┌─────────────────────────────────────┐
│  ← 今日训练                         │
├─────────────────────────────────────┤
│                                     │
│  第 3 周 · 第 2 天                    │
│  ━━━━━━━━━━━━━━ 18.75%            │
│                                     │
│  今日任务                           │
│  ┌─────────────────────────────┐   │
│  │ 🏃 有氧训练 45 分钟          │   │
│  │ 心率区间：燃脂 (60-70%)     │   │
│  │                             │   │
│  │ [开始训练]  [已完成]        │   │
│  └─────────────────────────────┘   │
│                                     │
│  本周进度                           │
│  ┌─────────────────────────────┐   │
│  │ 周一  ✅ 45 分钟 有氧        │   │
│  │ 周二  📍 进行中             │   │
│  │ 周三  ⏳ 待完成             │   │
│  │ 周四  ⏳ 待完成             │   │
│  │ 周五  - 休息日              │   │
│  │ 周六  ⏳ 待完成             │   │
│  │ 周日  - 休息日              │   │
│  └─────────────────────────────┘   │
│                                     │
└─────────────────────────────────────┘
```

---

### Task 4: 智能调整算法 (4 天)

**目标**: 根据完成情况动态调整计划

**子任务**:
1. [ ] 完成度分析算法
2. [ ] 强度调整逻辑
3. [ ] 恢复状态评估
4. [ ] AI 重新生成计划
5. [ ] 用户反馈收集

**调整规则**:
```dart
// lib/services/plan_adjuster.dart
class PlanAdjuster {
  // 完成度 > 90% → 提升强度
  if (completionRate > 0.9) {
    increaseIntensity(10%);
  }
  
  // 完成度 < 60% → 降低强度
  if (completionRate < 0.6) {
    decreaseIntensity(15%);
  }
  
  // 连续 3 天未完成 → 重新评估
  if (missedDays >= 3) {
    regeneratePlan();
  }
  
  // 心率过高 → 建议休息
  if (avgHeartRate > maxSafeHR) {
    suggestRest();
  }
}
```

---

### Task 5: UI 优化与集成 (2 天)

**目标**: 完善用户体验

**子任务**:
1. [ ] 加载动画 (Lottie)
2. [ ] 成功/失败反馈
3. [ ] 空状态设计
4. [ ] 错误提示优化
5. [ ] 性能优化

---

## 📅 时间表

| 周次 | 日期 | 任务 | 交付物 |
|------|------|------|--------|
| **Week 1** | 04-10 ~ 04-16 | AI 接口 + 数据持久化 | ✅ AI 生成计划可用 |
| **Week 2** | 04-17 ~ 04-23 | 执行跟踪 + 智能调整 | ✅ 完整计划系统 |
| **验收** | 04-24 | 测试与修复 | ✅ v5 APK 发布 |

---

## 📦 依赖更新

### pubspec.yaml

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # 状态管理
  provider: ^6.1.1
  
  # 本地存储
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # 网络请求
  dio: ^5.4.0
  
  # 图表
  fl_chart: ^0.65.0
  
  # 动画
  lottie: ^2.7.0
  
  # 其他
  cupertino_icons: ^1.0.8
  share_plus: ^7.2.1
  vibration: ^1.8.4
```

---

## 🧪 测试计划

### 单元测试
- [ ] AI 服务测试
- [ ] 数据模型测试
- [ ] 存储服务的 CRUD 测试
- [ ] 调整算法测试

### 集成测试
- [ ] 完整计划创建流程
- [ ] 打卡流程
- [ ] 数据同步

### 用户测试
- [ ] 5 人小范围内测
- [ ] 收集反馈
- [ ] 优化体验

---

## 📊 验收标准

### 功能验收
- [ ] 可以创建训练计划
- [ ] AI 生成合理的 16 周计划
- [ ] 可以每日打卡
- [ ] 进度准确计算
- [ ] 智能调整生效

### 性能验收
- [ ] 计划生成 < 5 秒
- [ ] 打卡响应 < 1 秒
- [ ] 数据加载 < 2 秒
- [ ] 无明显卡顿

### 质量验收
- [ ] 无崩溃
- [ ] 无数据丢失
- [ ] 错误提示清晰
- [ ] UI 流畅

---

## 🎯 下一步行动

**立即执行**:

1. **今天 (04-10)**:
   - [ ] 创建 AI 服务类
   - [ ] 实现 Prompt 模板
   - [ ] 测试 AI 调用

2. **明天 (04-11)**:
   - [ ] 添加 Hive 依赖
   - [ ] 创建数据模型
   - [ ] 实现存储服务

3. **本周日 (04-16)**:
   - [ ] 完成 AI 计划生成
   - [ ] 完成数据持久化
   - [ ] 构建 v5 APK

---

**负责人**: 虾家三少 · 严谨专业版  
**启动时间**: 2026-04-10 12:00  
**预计完成**: 2026-04-24
