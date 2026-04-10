import 'package:flutter/material.dart';
import 'dart:math';
import 'pages/plan_page_v2.dart';
import 'pages/team_page_v2.dart';

void main() {
  runApp(const TrekPioneerApp());
}

class TrekPioneerApp extends StatelessWidget {
  const TrekPioneerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '徒步先锋队',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFD700),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

// ==================== 登录页面 ====================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  int _countdown = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 冈仁波齐图标
              ClipOval(
                child: Image.asset(
                  'assets/images/kailash-icon.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '徒步先锋队',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFFD700),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '每一步，都算数',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 64),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: '手机号',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: '验证码',
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _countdown > 0 ? null : _sendCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD700),
                      foregroundColor: const Color(0xFF1A1A2E),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(_countdown > 0 ? '$_countdown s' : '获取验证码'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MainScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD700),
                    foregroundColor: const Color(0xFF1A1A2E),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('登录', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '登录即表示同意《用户协议》和《隐私政策》',
                style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendCode() {
    if (_phoneController.text.length != 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入正确的手机号')),
      );
      return;
    }
    setState(() => _countdown = 60);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('验证码已发送：123456')),
    );
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _codeController.text = '123456';
        });
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }
}

// ==================== 主界面 ====================
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const PlanPageV2(),
    const TrackPage(),
    const TeamPageV2(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) => setState(() => _selectedIndex = index),
          backgroundColor: Colors.transparent,
          elevation: 0,
          indicatorColor: const Color(0xFFFFD700).withOpacity(0.2),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home, color: Color(0xFFFFD700)), label: '首页'),
            NavigationDestination(icon: Icon(Icons.calendar_today_outlined), selectedIcon: Icon(Icons.calendar_today, color: Color(0xFFFFD700)), label: '计划'),
            NavigationDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map, color: Color(0xFFFFD700)), label: '轨迹'),
            NavigationDestination(icon: Icon(Icons.people_outlined), selectedIcon: Icon(Icons.people, color: Color(0xFFFFD700)), label: '团队'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person, color: Color(0xFFFFD700)), label: '我的'),
          ],
        ),
      ),
    );
  }
}

// ==================== 首页 ====================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Row(
            children: [
              _buildAvatar('张三'),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('早上好，张三', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  Text('冈仁波齐挑战小队 · 团长', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70)),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () => _showNotifications(context),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Container(
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
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text('🏔️', style: TextStyle(fontSize: 24)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('冈仁波齐转山', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                            Text('距离挑战还有 158 天', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(value: 0.75, backgroundColor: Colors.white24, valueColor: const AlwaysStoppedAnimation<Color>(Colors.white), minHeight: 8),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildProgressInfo(context, '个人进度', '125/320km'),
                      _buildProgressInfo(context, '团队进度', '75% 完成'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _showTodayTasks(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF1A1A2E),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('查看今日任务', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('今日概览', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text('更多')),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildStatCard('👣', '18,542', '步数', '目标 20000', context),
                _buildStatCard('🔥', '2h15m', '运动', '目标 2h', context),
                _buildStatCard('💓', '135bpm', '心率', '区间正常', context),
                _buildStatCard('😴', '7h20m', '睡眠', '目标 8h', context),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('队友动态', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                _buildActivityItem('👤 李四', '刚刚完成了 10km 徒步', '刚刚'),
                const Divider(height: 1, color: Colors.white10),
                _buildActivityItem('👤 王五', '打破了个人记录 🎉', '2 小时前'),
                const Divider(height: 1, color: Colors.white10),
                _buildActivityItem('👤 赵六', '加入了挑战', '5 小时前'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(String name) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFFFF6B6B)]),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Center(
        child: Text(
          name[0],
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildProgressInfo(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70)),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }

  Widget _buildStatCard(String emoji, String value, String label, String target, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
          Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white60)),
          const SizedBox(height: 4),
          Text(target, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white54, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String content, String time) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: const Color(0xFF6C63FF).withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
        child: const Text('👤'),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(content, style: const TextStyle(color: Colors.white70)),
      trailing: Text(time, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
    );
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('通知', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildNotificationItem('今日训练提醒', '该开始今天的训练了！', '08:00'),
            _buildNotificationItem('喝水提醒', '今天只喝了 800ml，还需要 1200ml', '10:30'),
            _buildNotificationItem('队友鼓励', '李四给你点了个赞', '14:20'),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String title, String content, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(content, style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          Text(time, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }

  void _showTodayTasks(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('今日训练任务', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildTaskItem('🏃 有氧训练', '45 分钟', '已完成', true),
                  _buildTaskItem('👣 步数', '15000 步', '进行中 12542/15000', false),
                  _buildTaskItem('💓 心率', '130-150bpm', '平均 135bpm', false),
                  _buildTaskItem('😴 睡眠', '7-8 小时', '昨晚 7h20m', true),
                  _buildTaskItem('💧 饮水', '2000ml', '已完成 1200ml', false),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('今日任务已完成！继续加油！')));
                },
                child: const Text('打卡完成'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(String icon, String task, String status, bool completed) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: completed ? Colors.green.withOpacity(0.2) : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task, style: TextStyle(fontWeight: FontWeight.bold, decoration: completed ? TextDecoration.lineThrough : null)),
                Text(status, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
              ],
            ),
          ),
          Icon(completed ? Icons.check_circle : Icons.circle_outlined, color: completed ? Colors.green : Colors.white54),
        ],
      ),
    );
  }
}

// ==================== 计划页面 ====================
class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('训练计划'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: '每日'),
              Tab(text: '每周'),
              Tab(text: '每月'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildDailyPlan(context),
            _buildWeeklyPlan(context),
            _buildMonthlyPlan(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyPlan(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildDayPlanCard(context, '今日计划', [
          _buildPlanItem('🏃 有氧训练', '45 分钟', '心率 130-150bpm', 1.0),
          _buildPlanItem('👣 步数', '15000 步', '已完成 12542 步', 0.83),
          _buildPlanItem('💪 力量训练', '30 分钟', '下肢力量', 0.0),
          _buildPlanItem('🧘 拉伸', '15 分钟', '训练后拉伸', 0.0),
        ]),
        const SizedBox(height: 16),
        _buildDayPlanCard(context, '明日计划', [
          _buildPlanItem('🏃 有氧训练', '50 分钟', '心率 135-155bpm', 0.0),
          _buildPlanItem('🚴 骑行', '40 分钟', '户外骑行', 0.0),
          _buildPlanItem('💪 力量训练', '30 分钟', '上肢力量', 0.0),
        ]),
      ],
    );
  }

  Widget _buildWeeklyPlan(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildWeekDayCard(context, '周一', '有氧训练', '45 分钟', true),
        _buildWeekDayCard(context, '周二', '力量训练', '30 分钟', true),
        _buildWeekDayCard(context, '周三', '有氧训练', '50 分钟', true),
        _buildWeekDayCard(context, '周四', '休息日', '-', false),
        _buildWeekDayCard(context, '周五', '有氧训练', '45 分钟', false),
        _buildWeekDayCard(context, '周六', '长距离徒步', '10km', false),
        _buildWeekDayCard(context, '周日', '恢复训练', '30 分钟', false),
      ],
    );
  }

  Widget _buildMonthlyPlan(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildMonthGoalCard(context, '5 月目标', '基础体能建立', [
          '每周有氧训练 3 次',
          '累计徒步 50km',
          '心率区间训练',
        ], 1.0),
        const SizedBox(height: 16),
        _buildMonthGoalCard(context, '6 月目标', '耐力提升', [
          '每周长距离徒步 1 次',
          '累计徒步 100km',
          '心率耐力训练',
        ], 0.0),
        const SizedBox(height: 16),
        _buildMonthGoalCard(context, '7 月目标', '高原适应', [
          '模拟高海拔训练',
          '累计徒步 150km',
          '心肺功能强化',
        ], 0.0),
        const SizedBox(height: 16),
        _buildMonthGoalCard(context, '8 月目标', '强度冲刺', [
          '每周 2 次长距离',
          '累计徒步 200km',
          '综合体能训练',
        ], 0.0),
      ],
    );
  }

  Widget _buildDayPlanCard(BuildContext context, String title, List<Widget> items) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ...items,
        ],
      ),
    );
  }

  Widget _buildPlanItem(String icon, String task, String detail, double progress) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(task, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              Text('${(progress * 100).toInt()}%', style: TextStyle(color: Colors.white.withOpacity(0.7))),
            ],
          ),
          const SizedBox(height: 4),
          Text(detail, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12)),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
            minHeight: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildWeekDayCard(BuildContext context, String day, String type, String duration, bool completed) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: completed ? Colors.green.withOpacity(0.2) : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(day, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text('$type · $duration', style: TextStyle(color: Colors.white.withOpacity(0.7))),
              ],
            ),
          ),
          Icon(
            completed ? Icons.check_circle : Icons.circle_outlined,
            color: completed ? Colors.green : Colors.white54,
            size: 32,
          ),
        ],
      ),
    );
  }

  Widget _buildMonthGoalCard(BuildContext context, String month, String theme, List<String> tasks, double progress) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: progress > 0 ? const LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFFFF6B6B)]) : null,
        color: progress > 0 ? null : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(month, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(20)),
                child: Text(theme, style: const TextStyle(fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...tasks.map((task) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(Icons.check, size: 16, color: Colors.white70),
                const SizedBox(width: 8),
                Text(task, style: const TextStyle(color: Colors.white70)),
              ],
            ),
          )),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 6,
          ),
        ],
      ),
    );
  }
}

// ==================== 轨迹页面 ====================
class TrackPage extends StatefulWidget {
  const TrackPage({super.key});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  bool _isRecording = false;
  String _recordTime = '00:00:00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('运动轨迹'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => _showHistoryTracks(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: _isRecording
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.my_location, size: 64, color: Color(0xFF6C63FF)),
                          const SizedBox(height: 24),
                          Text(_recordTime, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                          const SizedBox(height: 8),
                          const Text('轨迹记录中...', style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6C63FF).withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.map_outlined, size: 64, color: Color(0xFF6C63FF)),
                          ),
                          const SizedBox(height: 32),
                          Text('开始你的第一次运动', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          Text('记录轨迹、分析数据、达成目标', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                        ],
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => setState(() {
                  _isRecording = !_isRecording;
                  if (_isRecording) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('开始记录轨迹，GPS 已开启')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('轨迹已保存，5.2km / 1h23m')));
                  }
                }),
                icon: Icon(_isRecording ? Icons.stop : Icons.fiber_manual_record),
                label: Text(_isRecording ? '停止记录' : '开始运动'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isRecording ? const Color(0xFFFF6B6B) : const Color(0xFF6C63FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showHistoryTracks(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('历史轨迹', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildTrackItem('今天 09:30', '晨跑', '5.2km', '1h23m'),
                  _buildTrackItem('昨天 18:00', '夜跑', '3.8km', '45m'),
                  _buildTrackItem('04-08 07:00', '晨跑', '6.1km', '1h35m'),
                  _buildTrackItem('04-07 19:30', '骑行', '15.3km', '2h10m'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackItem(String time, String type, String distance, String duration) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: const Color(0xFF6C63FF).withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
        child: const Icon(Icons.route, color: Color(0xFF6C63FF)),
      ),
      title: Text(type),
      subtitle: Text(time),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(distance, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 16),
          Text(duration, style: TextStyle(color: Colors.white.withOpacity(0.7))),
        ],
      ),
    );
  }
}

// ==================== 队友页面 ====================
class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('队友'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => _showInviteDialog(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTeamMember(context, '张三 (我)', '团长', '125/320km', '75%', true, 'avatar_zhang.png'),
          _buildTeamMember(context, '李四', '队员', '180/320km', '90%', false, 'avatar_li.png'),
          _buildTeamMember(context, '王五', '队员', '150/320km', '85%', false, 'avatar_wang.png'),
          _buildTeamMember(context, '赵六', '队员', '100/320km', '65%', false, 'avatar_zhao.png'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showTeamRanking(context),
        icon: const Icon(Icons.leaderboard),
        label: const Text('排行榜'),
        backgroundColor: const Color(0xFF6C63FF),
      ),
    );
  }

  Widget _buildTeamMember(BuildContext context, String name, String role, String progress, String percent, bool isMe, String avatar) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildMemberAvatar(name, isMe),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(role, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(percent, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF00D9C0))),
                  Text(progress, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: double.parse(percent.replaceAll('%', '')) / 100,
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00D9C0)),
            minHeight: 6,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: OutlinedButton.icon(onPressed: () => _showMemberData(context, name), icon: const Icon(Icons.visibility, size: 18), label: const Text('查看数据'), style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Color(0xFF6C63FF))))),
              const SizedBox(width: 12),
              Expanded(child: OutlinedButton.icon(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('给${name.split(' ')[0]}发送了鼓励 ❤️'))), icon: const Icon(Icons.favorite, size: 18), label: const Text('鼓励'), style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Color(0xFFFF6B6B))))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMemberAvatar(String name, bool isMe) {
    final colors = [const Color(0xFF6C63FF), const Color(0xFFFF6B6B), const Color(0xFF00D9C0), const Color(0xFFFFD93D)];
    final color = colors[name.hashCode % colors.length];
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withOpacity(0.7)]),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Center(child: Text(name[0], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
    );
  }

  void _showMemberData(BuildContext context, String name) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildDataRow('今日步数', '18,542 步', Icons.directions_walk),
                  _buildDataRow('运动时长', '2h15m', Icons.timer),
                  _buildDataRow('平均心率', '135bpm', Icons.favorite),
                  _buildDataRow('消耗卡路里', '850kcal', Icons.local_fire_department),
                  _buildDataRow('睡眠时长', '7h20m', Icons.bed),
                  _buildDataRow('训练天数', '15/30 天', Icons.calendar_today),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF6C63FF)),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.white70)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _showInviteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('邀请队友'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('分享邀请码或链接给好友'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: const Text('邀请码：PEAK2026', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('关闭')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('邀请码已复制')));
            },
            child: const Text('复制邀请码'),
          ),
        ],
      ),
    );
  }

  void _showTeamRanking(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('团队排行榜', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildRankingItem('🥇', '李四', '180km', '90%'),
                  _buildRankingItem('🥈', '王五', '150km', '85%'),
                  _buildRankingItem('🥉', '张三 (我)', '125km', '75%'),
                  _buildRankingItem('4', '赵六', '100km', '65%'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankingItem(String rank, String name, String distance, String percent) {
    return ListTile(
      leading: Text(rank, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      title: Text(name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(distance, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFF00D9C0).withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
            child: Text(percent, style: const TextStyle(color: Color(0xFF00D9C0), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// ==================== 我的页面 ====================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: 24),
          _buildMenuSection(context, '我的挑战', [
            _buildMenuItem('冈仁波齐转山', '进行中', Icons.landscape),
            _buildMenuItem('四姑娘山长坪沟', '已完成', Icons.check_circle),
          ]),
          const SizedBox(height: 16),
          _buildMenuSection(context, '设置', [
            _buildMenuItem('个人信息', '', Icons.person),
            _buildMenuItem('通知设置', '', Icons.notifications),
            _buildMenuItem('隐私设置', '', Icons.lock),
            _buildMenuItem('华为健康绑定', '已绑定', Icons.watch),
          ]),
          const SizedBox(height: 16),
          _buildMenuSection(context, '帮助', [
            _buildMenuItem('帮助中心', '', Icons.help),
            _buildMenuItem('关于我们', '', Icons.info),
          ]),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
              icon: const Icon(Icons.logout),
              label: const Text('退出登录'),
              style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFFFF6B6B)]),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: const Center(child: Text('张', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold))),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('张三', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('138****8888', style: TextStyle(color: Colors.white.withOpacity(0.7))),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFF6C63FF).withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    child: const Text('团长', style: TextStyle(fontSize: 12)),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFF00D9C0).withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                    child: const Text('Lv.5', style: TextStyle(fontSize: 12, color: Color(0xFF00D9C0))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection(BuildContext context, String title, List<Widget> items) {
    return Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white70)),
          ),
          ...items,
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, String subtitle, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF6C63FF)),
      title: Text(title),
      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.white54),
    );
  }
}
