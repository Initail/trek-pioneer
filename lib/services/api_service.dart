import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// API 服务 - 后端接口调用
class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://101.37.70.212:3000/api',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// 初始化 - 添加 Token 拦截器
  void init() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          // Token 过期，清除本地存储
          _storage.delete(key: 'auth_token');
        }
        return handler.next(error);
      },
    ));
  }

  /// 发送验证码
  Future<Map<String, dynamic>> sendCode(String phone) async {
    final response = await _dio.post('/auth/send-code',
      data: {'phone': phone},
    );
    return response.data;
  }

  /// 登录
  Future<Map<String, dynamic>> login(String phone, String code) async {
    final response = await _dio.post('/auth/login',
      data: {'phone': phone, 'code': code},
    );
    
    final data = response.data;
    if (data['success'] == true && data['token'] != null) {
      await _storage.write(key: 'auth_token', value: data['token']);
    }
    
    return data;
  }

  /// 获取用户信息
  Future<Map<String, dynamic>> getUserInfo() async {
    final response = await _dio.get('/user/info');
    return response.data;
  }

  /// 获取计划列表
  Future<List<dynamic>> getPlans() async {
    final response = await _dio.get('/plans');
    final data = response.data;
    return data['success'] == true ? data['plans'] : [];
  }

  /// 创建计划
  Future<Map<String, dynamic>> createPlan(Map<String, dynamic> plan) async {
    final response = await _dio.post('/plans', data: plan);
    return response.data;
  }

  /// 获取计划详情
  Future<Map<String, dynamic>> getPlanDetail(String planId) async {
    final response = await _dio.get('/plans/$planId');
    return response.data;
  }

  /// 更新计划
  Future<Map<String, dynamic>> updatePlan(String planId, Map<String, dynamic> data) async {
    final response = await _dio.put('/plans/$planId', data: data);
    return response.data;
  }

  /// 删除计划
  Future<Map<String, dynamic>> deletePlan(String planId) async {
    final response = await _dio.delete('/plans/$planId');
    return response.data;
  }

  /// 获取打卡记录
  Future<List<dynamic>> getCheckIns({String? planId}) async {
    final response = await _dio.get('/checkins',
      queryParameters: planId != null ? {'planId': planId} : {},
    );
    final data = response.data;
    return data['success'] == true ? data['checkins'] : [];
  }

  /// 提交打卡
  Future<Map<String, dynamic>> submitCheckIn(Map<String, dynamic> checkIn) async {
    final response = await _dio.post('/checkins', data: checkIn);
    return response.data;
  }

  /// 获取统计数据
  Future<Map<String, dynamic>> getStats() async {
    final response = await _dio.get('/stats');
    return response.data;
  }

  /// 获取团队列表
  Future<List<dynamic>> getTeams() async {
    final response = await _dio.get('/teams');
    final data = response.data;
    return data['success'] == true ? data['teams'] : [];
  }

  /// 获取团队成员
  Future<List<dynamic>> getTeamMembers(String teamId) async {
    final response = await _dio.get('/teams/$teamId/members');
    final data = response.data;
    return data['success'] == true ? data['members'] : [];
  }

  /// 获取团队动态
  Future<List<dynamic>> getTeamActivity(String teamId) async {
    final response = await _dio.get('/teams/$teamId/activity');
    final data = response.data;
    return data['success'] == true ? data['activities'] : [];
  }

  /// 发布团队动态
  Future<Map<String, dynamic>> postTeamActivity(String teamId, String type, String content) async {
    final response = await _dio.post('/teams/$teamId/activity',
      data: {'type': type, 'content': content},
    );
    return response.data;
  }

  /// 同步健康数据
  Future<Map<String, dynamic>> syncHealthData({
    int? steps,
    int? heartRate,
    double? distance,
    int? calories,
  }) async {
    final response = await _dio.post('/health/sync',
      data: {
        'steps': steps,
        'heart_rate': heartRate,
        'distance': distance,
        'calories': calories,
      },
    );
    return response.data;
  }

  /// 退出登录
  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
  }

  /// 检查是否已登录
  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'auth_token');
    return token != null;
  }

  /// 获取 Token
  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }
}
