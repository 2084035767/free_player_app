import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:fox_player/core/local/prefs.dart';
import 'package:fox_player/models/user.dart';
import 'package:uuid/uuid.dart';

class DeviceUserManager {
  static DeviceUserManager? _instance;
  static DeviceUserManager get instance => _instance ??= DeviceUserManager._();

  DeviceUserManager._();

  static const String _keyUser = 'app_default_user';
  static const String _keyInitialized = 'app_user_initialized';

  User? _currentUser;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void>? _initFuture;

  Future<void> init() async {
    // 防止重复初始化
    if (_isInitialized) return;
    if (_initFuture != null) return _initFuture!; // 返回正在进行的初始化

    _initFuture = _performInitialization();
    await _initFuture;
  }

  Future<void> _performInitialization() async {
    try {
      // 1. 尝试加载缓存
      final userJson = Prefs.getString(_keyUser);
      if (userJson.isNotEmpty) {
        try {
          final map = jsonDecode(userJson) as Map<String, dynamic>;
          _currentUser = User.fromJson(map);
          debugPrint('✅ 已加载缓存用户: ${_currentUser!.username}');
        } catch (e) {
          debugPrint('⚠️ 解析缓存失败: $e');
          await Prefs.remove(_keyUser);
        }
      }

      // 2. 如果缓存没有，创建新用户
      if (_currentUser == null) {
        final deviceId = await _generateDeviceFingerprint();
        _currentUser = User(
          userId: const Uuid().v4().replaceAll('-', '').substring(0, 16),
          deviceId: deviceId,
          username: _generateDefaultUsername(deviceId),
          avatar: 'default_${DateTime.now().millisecondsSinceEpoch % 10}',
          createdAt: DateTime.now(),
          watchHistory: ["95310","94648"],
          favorites: [],
          watchLater: [],
        );

        // 持久化新用户
        await Prefs.setString(_keyUser, jsonEncode(_currentUser!.toJson()));
        debugPrint('✅ 新用户已创建: ${_currentUser!.username}');
      }

      _isInitialized = true;
    } catch (e) {
      debugPrint('❌ 初始化失败: $e');
      // 🔥 关键：即使失败也标记为已初始化，避免无限重试
      _isInitialized = true;
      rethrow; // 让调用方决定如何处理
    }
  }

  /// ✅ 获取用户（同步，但要求先 init()）
  User? get currentUser {
    if (!_isInitialized) {
      debugPrint(
        '⚠️ 尝试在初始化前访问 currentUser，请先调用 await DeviceUserManager.instance.init()',
      );
      return null;
    }
    return _currentUser;
  }

  /// ✅ 兼容旧版：如果没 init() 过，自动触发初始化（懒加载兜底）
  Future<User> getOrCreateDefaultUser() async {
    if (!_isInitialized) {
      await init(); // 自动兜底
    }
    return _currentUser!;
  }

  /// 生成设备指纹（跨平台唯一标识）
  Future<String> _generateDeviceFingerprint() async {
    final deviceInfo = DeviceInfoPlugin();
    String identifier = '';

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        identifier = [
          androidInfo.brand,
          androidInfo.model,
          androidInfo.device,
          androidInfo.id,
        ].where((s) => s.isNotEmpty).join('_');
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        identifier = [
          iosInfo.identifierForVendor,
          iosInfo.model,
          iosInfo.systemName,
          iosInfo.systemVersion,
        ].where((s) => s != null && s.isNotEmpty).join('_');
      } else if (Platform.isWindows) {
        final winInfo = await deviceInfo.windowsInfo;
        identifier = '${winInfo.deviceId}_${winInfo.computerName}';
      } else if (Platform.isMacOS) {
        final macInfo = await deviceInfo.macOsInfo;
        identifier = '${macInfo.systemGUID}_${macInfo.model}';
      } else if (Platform.isLinux) {
        final linuxInfo = await deviceInfo.linuxInfo;
        identifier = '${linuxInfo.machineId}_${linuxInfo.name}';
      }
    } catch (e) {
      debugPrint('⚠️ 获取设备信息失败: $e');
      identifier =
          'fallback_${DateTime.now().millisecondsSinceEpoch}_${const Uuid().v4()}';
    }
    return _simpleHash(identifier);
  }

  /// 简单哈希函数（返回固定 32 位 16 进制字符串）
  String _simpleHash(String input) {
    var hash = 0;
    for (var i = 0; i < input.length; i++) {
      hash = input.codeUnitAt(i) + ((hash << 5) - hash);
    }
    // 转 16 进制，确保至少 8 位，然后重复 4 次保证 32 位
    final hex = hash.toRadixString(16).padLeft(8, '0');
    return (hex * 4).substring(0, 32);
  }

  /// 生成默认用户名
  String _generateDefaultUsername(String deviceId) {
    final prefix = ['游客', '用户'];
    final suffix = deviceId.substring(0, min(6, deviceId.length)).toUpperCase();
    return '${prefix[deviceId.hashCode.abs() % prefix.length]}_$suffix';
  }

  /// 更新用户并持久化
  Future<void> updateUser(User user) async {
    _currentUser = user;
    try {
      await Prefs.setString(_keyUser, jsonEncode(user.toJson()));
    } catch (e) {
      debugPrint('❌ 更新用户失败: $e');
    }
  }

  /// 清除用户数据
  Future<void> clearUser() async {
    await Prefs.remove(_keyUser);
    await Prefs.remove(_keyInitialized);
    _currentUser = null;
    _isInitialized = false;
    debugPrint('用户数据已清除');
  }
}
