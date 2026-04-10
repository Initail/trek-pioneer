import 'package:flutter/material.dart';

// ==================== 计划页面 - 完整的计划制定系统 ====================
class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('训练计划', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Color(0xFFFFD700)),
            onPressed: () => _showCreatePlanWizard(context),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // AI 计划推荐卡片
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('🤖', style: TextStyle(fontSize: 28)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AI 教练 · 卡卡',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                            Text(
                              '为你定制专属训练方案',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white70,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '基于你的体能水平和目标，我推荐你开始「冈仁波齐备战计划」。这个计划将帮助你：',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 12),
                  _buildBenefitItem('✅ 提升高原耐力', context),
                  _buildBenefitItem('✅ 增强下肢力量', context),
                  _buildBenefitItem('✅ 科学配速训练', context),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _showCreatePlanWizard(context),
                          icon: const Icon(Icons.edit, color: Color(0xFF1A1A2E)),
                          label: const Text('定制计划', style: TextStyle(color: Color(0xFF1A1A2E), fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white24,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('了解更多', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 进行中的计划
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('进行中的计划', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text('查看全部')),
                ],
              ),
            ),
          ),

          // 计划卡片列表
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildPlanCard(
                    context,
                    '🏔️ 冈仁波齐转山备战',
                    'K4 进阶 · 共 60 天',
                    0.75,
                    '本周完成 3/4 节',
                    '有氧 70% | 无氧 30%',
                    Colors.white,
                  ),
                  const SizedBox(height: 12),
                  _buildPlanCard(
                    context,
                    '💪 核心力量强化',
                    'K3 中级 · 共 30 天',
                    0.67,
                    '本周完成 2/3 节',
                    '有氧 40% | 无氧 60%',
                    Colors.white70,
                  ),
                ],
              ),
            ),
          ),

          // 计划历史
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text('已完成计划', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildHistoryCard(context, '✅ 基础体能训练', '30 天', '2026-02 完成'),
                  const SizedBox(height: 8),
                  _buildHistoryCard(context, '✅ 新手入门计划', '14 天', '2026-01 完成'),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreatePlanWizard(context),
        backgroundColor: const Color(0xFFFFD700),
        foregroundColor: const Color(0xFF1A1A2E),
        icon: const Icon(Icons.add, size: 28),
        label: const Text('创建计划', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }

  Widget _buildBenefitItem(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
    );
  }

  Widget _buildPlanCard(
    BuildContext context,
    String title,
    String subtitle,
    double progress,
    String progressText,
    String ratio,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: textColor)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white60)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('进行中', style: TextStyle(color: Color(0xFFFFD700), fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFD700)),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(progressText, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70)),
              Text(ratio, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withOpacity(0.5))),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD700),
                    foregroundColor: const Color(0xFF1A1A2E),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('继续训练', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white24,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('详情', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, String title, String duration, String completedDate) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.5))),
                const SizedBox(height: 4),
                Text('$duration · $completedDate', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white30)),
              ],
            ),
          ),
          const Icon(Icons.check_circle, color: Colors.white30, size: 28),
        ],
      ),
    );
  }

  void _showCreatePlanWizard(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => CreatePlanWizard(scrollController: scrollController),
      ),
    );
  }
}

// ==================== 创建计划向导 - 4 步流程 ====================
class CreatePlanWizard extends StatefulWidget {
  final ScrollController scrollController;

  const CreatePlanWizard({super.key, required this.scrollController});

  @override
  State<CreatePlanWizard> createState() => _CreatePlanWizardState();
}

class _CreatePlanWizardState extends State<CreatePlanWizard> {
  int _currentStep = 0;

  final List<String> _stepTitles = ['选择目标', '设置时间', '个人情况', 'AI 生成'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A2E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // 顶部进度条
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white70),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        _stepTitles[_currentStep],
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: (_currentStep + 1) / 4,
                                backgroundColor: Colors.white24,
                                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFD700)),
                                minHeight: 4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.white10),

          // 步骤内容
          Expanded(
            child: SingleChildScrollView(
              controller: widget.scrollController,
              padding: const EdgeInsets.all(20),
              child: _buildStepContent(),
            ),
          ),

          // 底部按钮
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E).withOpacity(0.95),
              border: Border(top: BorderSide(color: Colors.white10)),
            ),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => _currentStep--),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white70,
                        side: const BorderSide(color: Colors.white30),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('上一步', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 12),
                Expanded(
                  flex: _currentStep > 0 ? 2 : 1,
                  child: ElevatedButton(
                    onPressed: _currentStep < 3 ? () => setState(() => _currentStep++) : () => _completePlanCreation(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD700),
                      foregroundColor: const Color(0xFF1A1A2E),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(_currentStep < 3 ? '下一步' : '开始训练', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStep1SelectGoal();
      case 1:
        return _buildStep2SetTime();
      case 2:
        return _buildStep3PersonalInfo();
      case 3:
        return _buildStep4AIGenerating();
      default:
        return const SizedBox();
    }
  }

  Widget _buildStep1SelectGoal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('选择你的挑战目标', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('选择一个目标，我将为你定制专属训练计划', style: TextStyle(color: Colors.white60, fontSize: 14)),
        const SizedBox(height: 24),

        _buildGoalOption('🏔️ 冈仁波齐转山', '52km · 西藏 · 海拔 5656m', '难度：⭐⭐⭐⭐'),
        const SizedBox(height: 12),
        _buildGoalOption('🥾 雨崩徒步', '60km · 云南 · 海拔 3800m', '难度：⭐⭐⭐⭐⭐'),
        const SizedBox(height: 12),
        _buildGoalOption('⛰️ 四姑娘山大峰', '往返 18km · 四川 · 海拔 5025m', '难度：⭐⭐⭐⭐'),
        const SizedBox(height: 12),
        _buildGoalOption('🎯 自定义目标', '输入你的专属挑战', '难度：自定义'),

        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFD700).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Text('💡', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('新手建议', style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
                    Text('首次挑战建议选择难度⭐⭐⭐的路线，循序渐进提升体能', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGoalOption(String title, String subtitle, String difficulty) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 12)),
                const SizedBox(height: 4),
                Text(difficulty, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
              ],
            ),
          ),
          Radio(
            value: true,
            groupValue: false,
            onChanged: (value) {},
            activeColor: const Color(0xFFFFD700),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2SetTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('设置挑战时间', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('合理安排时间，确保充分准备', style: TextStyle(color: Colors.white60, fontSize: 14)),
        const SizedBox(height: 24),

        // 日期选择
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('挑战日期', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('📅', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('2026 年 9 月 15 日', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('距离今天还有 158 天', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today, color: Color(0xFFFFD700)),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // 每周训练天数
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('每周训练天数', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDaySelector('一', true),
                  _buildDaySelector('二', true),
                  _buildDaySelector('三', true),
                  _buildDaySelector('四', true),
                  _buildDaySelector('五', true),
                  _buildDaySelector('六', false),
                  _buildDaySelector('日', false),
                ],
              ),
              Text('建议每周至少训练 5 天', style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // 每次训练时长
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('每次训练时长', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildTimeOption('30 分钟', false),
                  _buildTimeOption('45 分钟', false),
                  _buildTimeOption('60 分钟', true),
                  _buildTimeOption('90 分钟', false),
                  _buildTimeOption('自由安排', false),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDaySelector(String day, bool isSelected) {
    return Container(
      width: 40,
      height: 50,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFFD700) : Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            color: isSelected ? const Color(0xFF1A1A2E) : Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeOption(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFFD700) : Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? const Color(0xFF1A1A2E) : Colors.white70,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStep3PersonalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('告诉我你的情况', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('这些信息帮助我更好地定制计划', style: TextStyle(color: Colors.white60, fontSize: 14)),
        const SizedBox(height: 24),

        // 当前体能水平
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('当前体能水平', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 12),
              _buildLevelOption('新手', '偶尔运动', false),
              const SizedBox(height: 8),
              _buildLevelOption('入门', '每周 1-2 次', true),
              const SizedBox(height: 8),
              _buildLevelOption('进阶', '每周 3-4 次', false),
              const SizedBox(height: 8),
              _buildLevelOption('专业', '每天训练', false),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // 过往徒步经历
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('过往徒步经历', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildExperienceOption('无', false),
                  _buildExperienceOption('1-2 次', false),
                  _buildExperienceOption('3-5 次', true),
                  _buildExperienceOption('5 次+', false),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // 健康状况
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('健康状况（多选）', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 12),
              _buildHealthOption('高原反应史', false),
              const SizedBox(height: 8),
              _buildHealthOption('心脏病史', false),
              const SizedBox(height: 8),
              _buildHealthOption('关节损伤', false),
              const SizedBox(height: 8),
              _buildHealthOption('无特殊状况', true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLevelOption(String title, String subtitle, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFFD700).withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isSelected ? const Color(0xFFFFD700) : Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(subtitle, style: TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            ),
          ),
          Icon(
            isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isSelected ? const Color(0xFFFFD700) : Colors.white30,
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceOption(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFFD700) : Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? const Color(0xFF1A1A2E) : Colors.white70,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildHealthOption(String label, bool isSelected) {
    return Row(
      children: [
        Checkbox(
          value: isSelected,
          onChanged: (value) {},
          activeColor: const Color(0xFFFFD700),
        ),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget _buildStep4AIGenerating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('AI 正在生成你的专属计划', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('基于你的情况，我将为你定制科学训练方案', style: TextStyle(color: Colors.white60, fontSize: 14)),
        const SizedBox(height: 32),

        // AI 动画
        Center(
          child: Container(
            width: 120,
            height: 120,
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
              child: Text('🤖', style: TextStyle(fontSize: 60)),
            ),
          ),
        ),

        const SizedBox(height: 40),

        // 生成内容预览
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGeneratingItem('✅ 16 周渐进式训练计划'),
              const SizedBox(height: 8),
              _buildGeneratingItem('✅ 有氧 + 力量科学结合'),
              const SizedBox(height: 8),
              _buildGeneratingItem('✅ 每周自动调整强度'),
              const SizedBox(height: 8),
              _buildGeneratingItem('✅ 实时监测恢复状态'),
              const SizedBox(height: 8),
              _buildGeneratingItem('✅ 个性化饮食建议'),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // 预计时间
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFD700).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Text('⏱️', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('计划生成中...', style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
                    Text('预计还需 30 秒', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFD700)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGeneratingItem(String text) {
    return Row(
      children: [
        Text(text, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  void _completePlanCreation(BuildContext context) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('🎉 计划创建成功！开始你的训练之旅吧！'),
        backgroundColor: const Color(0xFFFFD700),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
