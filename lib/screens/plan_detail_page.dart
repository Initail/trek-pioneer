import 'package:flutter/material.dart';
import '../models/plan.dart';
import '../services/local_storage_service.dart';

/// 计划详情页 - 展示完整训练计划
class PlanDetailPage extends StatefulWidget {
  final String planId;

  const PlanDetailPage({super.key, required this.planId});

  @override
  State<PlanDetailPage> createState() => _PlanDetailPageState();
}

class _PlanDetailPageState extends State<PlanDetailPage> {
  final LocalStorageService _storage = LocalStorageService();
  TrainingPlanHive? _plan;
  int _selectedWeek = 1;

  @override
  void initState() {
    super.initState();
    _loadPlan();
  }

  Future<void> _loadPlan() async {
    final plan = _storage.getPlan(widget.planId);
    setState(() => _plan = plan);
  }

  @override
  Widget build(BuildContext context) {
    if (_plan == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(_plan!.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          // 计划概览
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFFD700), Color(0xFFFF6B6B)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFD700).withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('📋', style: TextStyle(fontSize: 32)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _plan!.name,
                              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '第${_plan!.currentWeek}周 / 共${_plan!.totalWeeks}周',
                              style: const TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: _plan!.currentWeek / _plan!.totalWeeks,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 训练阶段
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text('训练阶段', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildPhaseCard('基础适应期', '1-4 周', '建立有氧基础', const Color(0xFF00D9C0)),
                  const SizedBox(height: 12),
                  _buildPhaseCard('能力提升期', '5-8 周', '提升心肺功能', const Color(0xFF4A90E2)),
                  const SizedBox(height: 12),
                  _buildPhaseCard('强化突破期', '9-12 周', '模拟高原环境', const Color(0xFFFFD700)),
                  const SizedBox(height: 12),
                  _buildPhaseCard('赛前调整期', '13-16 周', '减量调整', const Color(0xFFFF6B6B)),
                ],
              ),
            ),
          ),

          // 周选择器
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('周计划', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left, color: Color(0xFFFFD700)),
                        onPressed: _selectedWeek > 1 ? () => setState(() => _selectedWeek--) : null,
                      ),
                      Text('第$_selectedWeek 周', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.chevron_right, color: Color(0xFFFFD700)),
                        onPressed: _selectedWeek < _plan!.totalWeeks ? () => setState(() => _selectedWeek++) : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 周计划详情
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildDayCard('周一', '有氧训练', '快走 45 分钟', '燃脂区', 300),
                  const SizedBox(height: 8),
                  _buildDayCard('周二', '力量训练', '核心训练 30 分钟', '无氧区', 250),
                  const SizedBox(height: 8),
                  _buildDayCard('周三', '有氧训练', '慢跑 60 分钟', '有氧区', 450),
                  const SizedBox(height: 8),
                  _buildDayCard('周四', '休息日', '充分休息', '-', 0),
                  const SizedBox(height: 8),
                  _buildDayCard('周五', '有氧训练', '徒步训练 90 分钟', '燃脂区', 600),
                  const SizedBox(height: 8),
                  _buildDayCard('周六', '休息日', '充分休息', '-', 0),
                  const SizedBox(height: 8),
                  _buildDayCard('周日', '长距离', '长距离徒步 120 分钟', '有氧区', 800),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DailyCheckInPage(
                planId: _plan!.id,
                week: _plan!.currentWeek,
                day: 1,
              ),
            ),
          );
        },
        backgroundColor: const Color(0xFFFFD700),
        foregroundColor: const Color(0xFF1A1A2E),
        icon: const Icon(Icons.check_circle),
        label: const Text('今日打卡', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildPhaseCard(String name, String weeks, String focus, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('$weeks · $focus', style: const TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayCard(String day, String type, String activity, String heartRate, int calories) {
    final isRest = type == '休息日';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isRest ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isRest ? Colors.white10 : const Color(0xFFFFD700).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(day, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(type, style: TextStyle(color: isRest ? Colors.white.withOpacity(0.4) : Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity, style: const TextStyle(color: Colors.white, fontSize: 14)),
                const SizedBox(height: 4),
                Text('心率：$heartRate', style: const TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('$calories', style: const TextStyle(color: Color(0xFFFFD700), fontSize: 16, fontWeight: FontWeight.bold)),
                const Text('kcal', style: TextStyle(color: Colors.white60, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
