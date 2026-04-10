import 'package:flutter/material.dart';

// ==================== 团队页面 - 深度社交互动 ====================
class TeamPageV2 extends StatefulWidget {
  const TeamPageV2({super.key});

  @override
  State<TeamPageV2> createState() => _TeamPageV2State();
}

class _TeamPageV2State extends State<TeamPageV2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('团队', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // 团队目标卡片
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
                          color: Colors.white.withOpacity(0.24),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('🏆', style: TextStyle(fontSize: 28)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '冈仁波齐集体挑战',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                            ),
                            Text(
                              '团队目标 · 3000km',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: 0.42,
                      backgroundColor: Colors.white.withOpacity(0.24),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 10,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('已完成 1,258km', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
                      Text('还剩 1,742km', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withOpacity(0.7))),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('平均每人每周需完成：43km', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withOpacity(0.6))),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF1A1A2E),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('查看团队任务', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 团队成员列表
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('团队成员', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text('邀请成员')),
                ],
              ),
            ),
          ),

          // 队友卡片
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildTeammateCard(
                    context,
                    '张三',
                    '团长',
                    0.75,
                    '320km',
                    '✅ 本周达标',
                    'assets/images/kailash-icon.png',
                    isMe: true,
                  ),
                  const SizedBox(height: 12),
                  _buildTeammateCard(
                    context,
                    '李四',
                    '领航员',
                    0.85,
                    '450km',
                    '🥇 本周最佳',
                    'assets/images/kailash-icon.png',
                    onTap: () => _showTeammateDetail(context, '李四'),
                  ),
                  const SizedBox(height: 12),
                  _buildTeammateCard(
                    context,
                    '王五',
                    '后勤',
                    0.70,
                    '280km',
                    '⚠️ 落后 15km',
                    'assets/images/kailash-icon.png',
                    onTap: () => _showTeammateDetail(context, '王五'),
                  ),
                  const SizedBox(height: 12),
                  _buildTeammateCard(
                    context,
                    '赵六',
                    '新人',
                    0.65,
                    '208km',
                    '🔥 进步最快',
                    'assets/images/kailash-icon.png',
                    onTap: () => _showTeammateDetail(context, '赵六'),
                  ),
                ],
              ),
            ),
          ),

          // 团队动态
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text('团队动态', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildFeedItem(
                    context,
                    '李四',
                    'assets/images/kailash-icon.png',
                    '今天完成了 15km 徒步，路线推荐给大家！',
                    '刚刚',
                    12,
                    3,
                  ),
                  const SizedBox(height: 8),
                  _buildFeedItem(
                    context,
                    '张三',
                    'assets/images/kailash-icon.png',
                    '周末有人一起拉练吗？计划去西湖环湖～',
                    '2 小时前',
                    8,
                    5,
                  ),
                  const SizedBox(height: 8),
                  _buildFeedItem(
                    context,
                    '王五',
                    'assets/images/kailash-icon.png',
                    '分享一个徒步装备清单，新人必备！',
                    '5 小时前',
                    24,
                    8,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeammateCard(
    BuildContext context,
    String name,
    String role,
    double progress,
    String distance,
    String status,
    String avatar, {
    bool isMe = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isMe ? const Color(0xFFFFD700) : Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            // 头像
            ClipOval(
              child: Image.asset(
                avatar,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 60,
                  height: 60,
                  color: Colors.white.withOpacity(0.24),
                  child: Icon(Icons.person, color: Colors.white.withOpacity(0.7), size: 30),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // 信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      if (isMe)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD700).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('我', style: TextStyle(color: Color(0xFFFFD700), fontSize: 10)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(role, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withOpacity(0.6))),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white.withOpacity(0.24),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFD700)),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(distance, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withOpacity(0.7))),
                      Text(status, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withOpacity(0.6), fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),

            // 箭头
            if (onTap != null)
              const Icon(
                Icons.chevron_right,
                color: Color(0x33FFD700),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedItem(
    BuildContext context,
    String name,
    String avatar,
    String content,
    String time,
    int likes,
    int comments,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  avatar,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 40,
                    height: 40,
                    color: Colors.white.withOpacity(0.24),
                    child: Icon(Icons.person, color: Colors.white.withOpacity(0.7), size: 20),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                    Text(time, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withOpacity(0.5))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(content, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
          const SizedBox(height: 12),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite_border, size: 20),
                onPressed: () {},
                color: Colors.white.withOpacity(0.6),
              ),
              Text('$likes', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12)),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, size: 20),
                onPressed: () {},
                color: Colors.white.withOpacity(0.6),
              ),
              Text('$comments', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  void _showTeammateDetail(BuildContext context, String teammateName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeammateDetailPage(teammateName: teammateName),
      ),
    );
  }
}

// ==================== 队友详情页 - 完整数据探索 ====================
class TeammateDetailPage extends StatefulWidget {
  final String teammateName;

  const TeammateDetailPage({super.key, required this.teammateName});

  @override
  State<TeammateDetailPage> createState() => _TeammateDetailPageState();
}

class _TeammateDetailPageState extends State<TeammateDetailPage> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('${widget.teammateName}的数据', style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          // 日期选择器
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left, color: Color(0xFFFFD700)),
                        onPressed: () {
                          setState(() {
                            _selectedDate = _selectedDate.subtract(const Duration(days: 1));
                          });
                        },
                      ),
                      Column(
                        children: [
                          Text(
                            '${_selectedDate.month}月${_selectedDate.day}日',
                            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _getWeekday(_selectedDate),
                            style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right, color: Color(0xFFFFD700)),
                        onPressed: () {
                          setState(() {
                            _selectedDate = _selectedDate.add(const Duration(days: 1));
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // 日历视图
                  _buildMiniCalendar(),
                ],
              ),
            ),
          ),

          // 今日运动详情
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text('运动详情', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),

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
                      const Text('📍', style: TextStyle(fontSize: 28)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('西湖环湖徒步', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            Text('2026-04-08', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('⏱️', '2h 35m', '时长'),
                      _buildStatItem('📏', '18.5km', '距离'),
                      _buildStatItem('👣', '24,562', '步数'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('🔥', '1,450', '卡路里'),
                      _buildStatItem('💓', '142bpm', '平均心率'),
                      _buildStatItem('⛰️', '320m', '爬升'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.map, color: Color(0xFF1A1A2E)),
                      label: const Text('查看轨迹地图', style: TextStyle(color: Color(0xFF1A1A2E), fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 心率区间分布
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text('心率区间分布', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  _buildHeartRateZone('热身', 0.20, const Color(0xFF00D9C0)),
                  const SizedBox(height: 12),
                  _buildHeartRateZone('燃脂', 0.45, const Color(0xFF4A90E2)),
                  const SizedBox(height: 12),
                  _buildHeartRateZone('有氧', 0.25, const Color(0xFFFFD700)),
                  const SizedBox(height: 12),
                  _buildHeartRateZone('无氧', 0.10, const Color(0xFFFF6B6B)),
                ],
              ),
            ),
          ),

          // AI 运动报告
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('AI 运动报告', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('🤖 卡卡', style: TextStyle(color: Color(0xFFFFD700), fontSize: 12)),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('李四今天的表现太棒了！🎉', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Text('📊 数据亮点：', style: TextStyle(color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildInsightItem('• 里程比上周平均 +35%'),
                  _buildInsightItem('• 心率控制更稳定'),
                  _buildInsightItem('• 后半程配速保持优秀'),
                  const SizedBox(height: 16),
                  Text('💡 建议：', style: TextStyle(color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildInsightItem('• 注意补充水分'),
                  _buildInsightItem('• 明天建议轻松恢复'),
                  _buildInsightItem('• 可以挑战 20km+ 了'),
                  const SizedBox(height: 16),
                  Text('🏅 今日成就：', style: TextStyle(color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD700).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('个人第二好成绩', style: TextStyle(color: Color(0xFFFFD700), fontSize: 12)),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD700).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('团队今日最佳', style: TextStyle(color: Color(0xFFFFD700), fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.share, size: 18),
                          label: const Text('分享'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFD700),
                            foregroundColor: const Color(0xFF1A1A2E),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.thumb_up, size: 18),
                          label: const Text('点赞'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.24),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 历史对比
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text('近 7 天趋势', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  _buildTrendItem('4/2', 12, false),
                  const SizedBox(height: 8),
                  _buildTrendItem('4/3', 15, false),
                  const SizedBox(height: 8),
                  _buildTrendItem('4/4', 6, false, isRest: true),
                  const SizedBox(height: 8),
                  _buildTrendItem('4/5', 18, true),
                  const SizedBox(height: 8),
                  _buildTrendItem('4/6', 9, false),
                  const SizedBox(height: 8),
                  _buildTrendItem('4/7', 13, false),
                  const SizedBox(height: 8),
                  _buildTrendItem('4/8', 18.5, true),
                  const SizedBox(height: 16),
                  Divider(color: Colors.white.withOpacity(0.2)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('周总计：91.5km', style: TextStyle(color: Colors.white.withOpacity(0.7))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00D9C0).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('比上周 +22% 📈', style: TextStyle(color: Color(0xFF00D9C0), fontSize: 12)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniCalendar() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // 星期
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['一', '二', '三', '四', '五', '六', '日']
                .map((d) => SizedBox(width: 30, child: Text(d, textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12))))
                .toList(),
          ),
          const SizedBox(height: 8),
          // 日期
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCalendarDay('1', false, false),
              _buildCalendarDay('2', false, false),
              _buildCalendarDay('3', true, false),
              _buildCalendarDay('4', true, false),
              _buildCalendarDay('5', false, false),
              _buildCalendarDay('6', false, false),
              _buildCalendarDay('7', true, false),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCalendarDay('8', true, true), // 选中
              _buildCalendarDay('9', true, false),
              _buildCalendarDay('10', false, false),
              _buildCalendarDay('11', false, false),
              _buildCalendarDay('12', false, false),
              _buildCalendarDay('13', false, false),
              _buildCalendarDay('14', false, false),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCalendarDay('15', false, false),
              _buildCalendarDay('16', false, false),
              _buildCalendarDay('17', false, false),
              _buildCalendarDay('18', false, false),
              _buildCalendarDay('19', false, false),
              _buildCalendarDay('20', false, false),
              _buildCalendarDay('21', false, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarDay(String day, bool hasActivity, bool isSelected) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFFD700) : (hasActivity ? Colors.white.withOpacity(0.2) : Colors.transparent),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            color: isSelected ? const Color(0xFF1A1A2E) : Colors.white.withOpacity(0.7),
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String icon, String value, String label) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12)),
      ],
    );
  }

  Widget _buildHeartRateZone(String name, double percentage, Color color) {
    return Row(
      children: [
        SizedBox(width: 40, child: Text(name, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12))),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.white.withOpacity(0.24),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(width: 50, child: Text('${(percentage * 100).toInt()}%', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12, fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget _buildInsightItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(text, style: TextStyle(color: Colors.white.withOpacity(0.7))),
    );
  }

  Widget _buildTrendItem(String date, double km, bool isPersonalBest, {bool isRest = false}) {
    return Row(
      children: [
        SizedBox(width: 40, child: Text(date, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12))),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5 * (km / 20),
                height: 8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isPersonalBest ? [const Color(0xFFFFD700), const Color(0xFFFF6B6B)] : [const Color(0xFF00D9C0), const Color(0xFF4A90E2)],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('${km}km', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
              if (isPersonalBest) const SizedBox(width: 4),
              if (isPersonalBest) const Text('📍', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  String _getWeekday(DateTime date) {
    const weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return weekdays[date.weekday - 1];
  }
}
