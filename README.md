# Free Play App - 项目架构说明

## 项目概述
Free Play App 是一个使用 Flutter 开发的视频流媒体应用，采用 signals_flutter 状态管理方案和 get_it 依赖注入，结合适合中小型项目的目录结构。信号被封装在 ViewModels 中进行管理。

## 当前目录结构
```
lib/
├── main.dart                    # 应用入口
├── app.dart                     # 应用根组件
├── core/                       # 核心功能
│   ├── constants/              # 常量定义
│   ├── theme/                  # 主题配置
│   ├── utils/                  # 工具函数
│   └── network/                # 网络配置
├── models/                     # 数据模型
│   ├── user.dart               # 用户模型
│   └── video.dart              # 视频模型
├── services/                   # 服务层
│   ├── api_service.dart        # API 服务
│   └── auth_service.dart       # 认证服务
├── viewmodels/                 # 视图模型 (封装信号)
│   ├── auth_viewmodel.dart     # 认证视图模型
│   └── video_viewmodel.dart    # 视频视图模型
├── di/                         # 依赖注入配置
│   └── service_locator.dart    # 服务定位器
├── screens/                    # 页面 (按功能组织)
│   ├── auth/
│   │   └── login_screen.dart   # 登录页面
│   ├── home/
│   │   └── home_screen.dart    # 首页
│   ├── video/
│   │   └── video_list_screen.dart # 视频列表
│   └── profile/
│       └── profile_screen.dart # 个人资料页
├── widgets/                    # 可复用组件
│   ├── common/                 # 通用组件
│   ├── inputs/                 # 输入组件
│   └── cards/                  # 卡片组件
└── shared/                     # 共享资源
```

## 架构特点

### 1. 状态管理 (signals_flutter + ViewModels)
- 使用 signals_flutter 进行响应式状态管理
- 信号封装在 ViewModels 中，便于管理
- 提供细粒度的依赖追踪和高效更新

### 2. 依赖注入 (get_it)
- 使用 get_it 进行依赖注入管理
- 集中配置和管理应用服务及 ViewModels
- 便于测试和解耦

### 3. ViewModels 管理策略
- 每个功能模块有对应的 ViewModel
- ViewModel 封装相关的信号和业务逻辑
- 通过依赖注入获取服务实例

### 4. 目录结构特点
- 按功能模块组织代码
- ViewModels 与 UI 分离
- 服务层与业务逻辑分离
- 依赖注入配置独立管理
- 适合中小型项目的复杂度

## 适用场景
- 中小型 Flutter 项目
- 需要响应式状态管理的应用
- 需要依赖注入管理的应用
- 团队规模较小的项目
- 快速迭代的产品

## 开发建议
- 将相关信号组织在同一个 ViewModel 中
- 使用 Watch.builder 包装需要响应信号变化的组件
- 通过依赖注入获取 ViewModel 实例
- 在 ViewModel 中合理使用 computed 信号进行派生计算
- 在适当时候调用 ViewModel 的 dispose 方法清理信号
- 保持 ViewModel 和 UI 逻辑的分离

## 路由配置
### 路由结构
- 使用扁平化路由列表，统一入口在 RouterManager
- 路由命名统一使用 RouteNames 常量

### 扩展方式
```dart
final routes = [
  RouteConfig.page(
    path: '/feature',
    name: 'feature',
    child: const FeatureScreen(),
    redirectToLogin: true,
  ),
];
```

### 导航使用
```dart
RouterManager.goNamed(
  context,
  RouteNames.player,
  pathParameters: {'id': id.toString()},
);
```
