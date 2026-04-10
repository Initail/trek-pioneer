import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';
import '../models/plan.dart';

/// 每日打卡页面
class DailyCheckInPage extends StatefulWidget {
  final String planId;
  final int week;
  final int day;

  const DailyCheckInPage({
    super.key,
    required this.planId,
    required this.week,
    required this.day,
  });

  @override
  State<DailyCheckInPage> createState() => _DailyCheckInPageState();
}

class _DailyCheckInPageState extends State<DailyCheckInPage> {
  final LocalStorageService _storage = LocalStorageService();
  
  bool _isCompleted = false;
  int _actualDuration = 0;
  int _actualCalories = 0;
  String _notes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('每日打卡', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 日期信息
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFFD700), Color(0xFFFF6B6B)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text('📅', style: TextStyle(fontSize: 48)),
                  const SizedBox(height: 12),
                  Text(
                    '第${widget.week}周 · 第${widget.day}天',
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${DateTime.now().month}月${DateTime.now().day}日',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 今日任务
            const Text('今日任务', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildTaskCard('🏃 有氧训练', '快走 45 分钟', '燃脂区 (60-70%)', 300),
            const SizedBox(height: 12),
            _buildTaskCard('💪 力量训练', '核心训练 30 分钟', '无氧区 (80-90%)', 250),

            const SizedBox(height: 32),

            // 打卡表单
            const Text('打卡记录', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            
            TextField(
              decoration: InputDecoration(
                labelText: '实际时长 (分钟)',
                prefixIcon: const Icon(Icons.timer),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => _actualDuration = int.tryParse(value) ?? 0,
            ),
            const SizedBox(height: 16),
            
            TextField(
              decoration: InputDecoration(
                labelText: '消耗卡路里',
                prefixIcon: const Icon(Icons.local_fire_department),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => _actualCalories = int.tryParse(value) ?? 0,
            ),
            const SizedBox(height: 16),
            
            TextField(
              decoration: InputDecoration(
                labelText: '备注',
                prefixIcon: const Icon(Icons.notes),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
              ),
              maxLines: 3,
              onChanged: (value) => _notes = value,
            ),
            const SizedBox(height: 32),

            // 完成按钮
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _completeCheckIn,
                icon: const Icon(Icons.check_circle, size: 24),
                label: const Text('完成打卡', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00D9C0),
                  foregroundColor: const Color(0xFF1A1A2E),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(String icon, String activity, String heartRate, int calories) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 32)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity, style: const TextStyle(color: Colors.white, fontSize: 16)),
                const SizedBox(height: 4),
                Text(heartRate, style: const TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            ),
          ),
          Column(
            children: [
              Text('$calories', style: const TextStyle(color: Color(0xFFFFD700), fontSize: 18, fontWeight: FontWeight.bold)),
              const Text('kcal', style: TextStyle(color: Colors.white60, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _completeCheckIn() async {
    // TODO: 保存到数据库
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('✅ 打卡成功！'),
        backgroundColor: const Color(0xFF00D9C0),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    
    // 返回上一页
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }
}
