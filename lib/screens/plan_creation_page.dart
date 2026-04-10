import 'package:flutter/material.dart';
import '../services/ai_coach_service.dart';
import '../services/local_storage_service.dart';
import '../models/plan.dart';

/// 计划创建确认页面
class PlanCreationPage extends StatefulWidget {
  final String goal;
  final DateTime challengeDate;
  final int weeklyDays;
  final int sessionMinutes;
  final String fitnessLevel;
  final String experience;
  final List<String> healthConditions;

  const PlanCreationPage({
    super.key,
    required this.goal,
    required this.challengeDate,
    required this.weeklyDays,
    required this.sessionMinutes,
    required this.fitnessLevel,
    required this.experience,
    required this.healthConditions,
  });

  @override
  State<PlanCreationPage> createState() => _PlanCreationPageState();
}

class _PlanCreationPageState extends State<PlanCreationPage> {
  final AICoachService _aiService = AICoachService();
  final LocalStorageService _storage = LocalStorageService();
  
  bool _isGenerating = false;
  TrainingPlan? _generatedPlan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('创建训练计划', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: _isGenerating ? _buildGeneratingUI() : _buildConfirmUI(),
    );
  }

  /// 生成中 UI
  Widget _buildGeneratingUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // AI 动画
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFD700), Color(0xFFFF6B6B)],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFD700).withOpacity(0.4),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Center(
              child: Text('🤖', style: TextStyle(fontSize: 80)),
            ),
          ),
          const SizedBox(height: 40),
          
          // 进度提示
          const Text(
            'AI 教练正在为你定制计划...',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            '基于你的情况生成${_getWeeksUntilChallenge()}周训练方案',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 32),
          
          // 生成内容预览
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildGeneratingItem('✅ 个性化训练阶段'),
                const SizedBox(height: 8),
                _buildGeneratingItem('✅ 每周详细安排'),
                const SizedBox(height: 8),
                _buildGeneratingItem('✅ 心率区间指导'),
                const SizedBox(height: 8),
                _buildGeneratingItem('✅ 里程碑目标'),
              ],
            ),
          ),
          const SizedBox(height: 32),
          
          // 加载动画
          const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFD700)),
            ),
          ),
        ],
      ),
    );
  }

  /// 确认 UI
  Widget _buildConfirmUI() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头部
          const Text(
            '确认你的挑战目标',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'AI 将基于以下信息生成训练计划',
            style: TextStyle(color: Colors.white60, fontSize: 14),
          ),
          const SizedBox(height: 24),
          
          // 目标卡片
          _buildInfoCard(
            '🎯 挑战目标',
            widget.goal,
            '📅 ${widget.challengeDate.year}年${widget.challengeDate.month}月${widget.challengeDate.day}日',
          ),
          const SizedBox(height: 16),
          
          _buildInfoCard(
            '📋 训练安排',
            '每周${widget.weeklyDays}天 · 每次${widget.sessionMinutes}分钟',
            '适合${widget.fitnessLevel}水平',
          ),
          const SizedBox(height: 16),
          
          _buildInfoCard(
            '💪 个人情况',
            '徒步经历：${widget.experience}',
            widget.healthConditions.isEmpty ? '健康状况：无特殊状况' : '健康状况：${widget.healthConditions.join(', ')}',
          ),
          const SizedBox(height: 32),
          
          // 生成按钮
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _generatePlan,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD700),
                foregroundColor: const Color(0xFF1A1A2E),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('开始生成计划', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 12),
          
          Text(
            '预计需要 3-5 秒',
            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String line1, String line2) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          Text(line1, style: const TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 4),
          Text(line2, style: TextStyle(color: Colors.white60, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildGeneratingItem(String text) {
    return Row(
      children: [
        Text(text, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  int _getWeeksUntilChallenge() {
    final days = widget.challengeDate.difference(DateTime.now()).inDays;
    return (days / 7).floor();
  }

  Future<void> _generatePlan() async {
    setState(() => _isGenerating = true);

    try {
      // 生成计划
      final plan = await _aiService.generatePlan(
        goal: widget.goal,
        challengeDate: widget.challengeDate,
        weeklyDays: widget.weeklyDays,
        sessionMinutes: widget.sessionMinutes,
        fitnessLevel: widget.fitnessLevel,
        experience: widget.experience,
        healthConditions: widget.healthConditions,
      );

      // 保存到本地存储
      final hivePlan = TrainingPlanHive(
        id: plan.id,
        name: plan.name,
        description: plan.description,
        totalWeeks: plan.totalWeeks,
        weeklyDays: plan.weeklyDays,
        sessionMinutes: plan.sessionMinutes,
        createdAt: plan.createdAt,
      );
      
      await _storage.savePlan(hivePlan);

      setState(() => _generatedPlan = plan);

      // 显示成功
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('🎉 计划生成成功！'),
            backgroundColor: const Color(0xFF00D9C0),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );

        // 跳转到计划详情页
        // Navigator.pushReplacement(...)
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ 生成失败：$e'),
            backgroundColor: const Color(0xFFFF6B6B),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isGenerating = false);
      }
    }
  }
}
