# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**NewsLingo** 是一个基于 Flutter 框架的移动应用项目，使用了 flexible 脚手架快速搭建。该应用集成了状态管理、动态环境配置、全局主题切换、OTA更新等现代化移动应用开发功能。

## 构建和运行命令

### 开发环境运行
```bash
# 启动应用（需要先开模拟器或连接真机）
flutter run --dart-define=INIT_ENV=dev --dart-define=ANDROID_CHANNEL=flutter

# 或者使用 npm 脚本
npm run dev
```

### Web 开发
```bash
flutter run -d chrome --dart-define=INIT_ENV=dev
npm run dev:web
```

### 构建打包

#### Android APK
```bash
# 测试环境
flutter build apk --dart-define=INIT_ENV=test --dart-define=ANDROID_CHANNEL=flutter
npm run build-apk:test

# 预发布环境
flutter build apk --dart-define=INIT_ENV=pre --dart-define=ANDROID_CHANNEL=flutter
npm run build-apk:pre

# 生产环境
flutter build apk --dart-define=INIT_ENV=prod --dart-define=ANDROID_CHANNEL=flutter
npm run build-apk:prod
```

#### iOS
```bash
# 测试环境
flutter build ios --dart-define=INIT_ENV=test
npm run build-ios:test

# 预发布环境
flutter build ios --dart-define=INIT_ENV=pre
npm run build-ios:pre

# 生产环境
flutter build ios --dart-define=INIT_ENV=prod
npm run build-ios:prod
```

#### Web
```bash
# 测试环境
flutter build web --dart-define=INIT_ENV=test
npm run build-web:test

# 预发布环境
flutter build web --dart-define=INIT_ENV=pre
npm run build-web:pre

# 生产环境
flutter build web --dart-define=INIT_ENV=prod
npm run build-web:prod
```

#### Windows
```bash
# 测试环境
flutter build windows --dart-define=INIT_ENV=test
npm run build-windows:test

# 预发布环境
flutter build windows --dart-define=INIT_ENV=pre
npm run build-windows:pre

# 生产环境
flutter build windows --dart-define=INIT_ENV=prod
npm run build-windows:prod
```

### 其他实用命令
```bash
# 安装依赖
flutter pub get

# 升级 Flutter SDK
flutter upgrade
npm run upsdk

# 验证 APK 签名
keytool -printcert -jarfile ./build/app/outputs/apk/release/app-release.apk
npm run appkey

# 代码分析
flutter analyze
```

## 架构概览

### 项目结构
```
lib/
├── components/          # 共用 widget 组件
│   ├── basic_safe_area/
│   ├── custom_icons/
│   ├── exit_app_interceptor/
│   ├── layouts/
│   ├── page_loding/
│   └── update_app/
├── config/             # 全局配置参数
│   ├── app_config.dart  # APP 相关配置
│   ├── app_env.dart     # 环境变量配置
│   └── common_config.dart # 全局通用配置
├── constants/          # 常量文件夹
│   └── themes/         # 主题配置
├── models/             # 数据类型定义
├── pages/              # 页面 UI 层
│   ├── app_main/       # APP 主体页面
│   ├── splash/         # APP 闪屏页
│   ├── login/          # 登录页面
│   └── ...
├── provider/           # 全局状态管理
├── routes/             # 路由相关文件夹
├── services/           # 请求接口抽离层
└── utils/              # 工具类
    ├── dio/            # HTTP 请求封装
    ├── app_setup/      # 应用初始化
    └── tool/           # 工具函数
```

### 核心架构模式

#### 状态管理模式
- 使用 **Provider** 进行全局状态管理
- 在 `providers_config.dart` 中统一配置所有 Provider
- 支持页面级和全局状态管理

#### 路由管理
- 使用别名路由系统，支持参数传递
- 路由定义在 `routes/routes_data.dart` 中
- 支持路由拦截和错误页面处理

#### 环境配置
- 动态环境变量通过 `dart-define` 注入
- 环境配置文件：`config/app_env.dart`
- 支持开发、测试、预发布、生产四个环境

#### HTTP 请求封装
- 基于 Dio 封装的请求工具类
- 支持请求/响应拦截器
- 统一错误处理和日志记录

### 关键文件说明

#### 应用入口
- **`lib/main.dart`** - 应用程序入口，配置 Provider、主题、路由等
- **`lib/config/app_config.dart`** - 应用基础配置，包括调试开关、代理设置等

#### 路由系统
- **`lib/routes/routes_data.dart`** - 路由映射表，支持参数传递
- **`lib/routes/route_name.dart`** - 路由名称常量定义
- **`lib/routes/generate_route.dart`** - 路由生成器

#### 状态管理
- **`lib/providers_config.dart`** - Provider 统一配置
- **`lib/provider/global.p.dart`** - 全局状态管理
- **`lib/provider/theme_store.p.dart`** - 主题状态管理

#### 网络请求
- **`lib/utils/dio/request.dart`** - Dio 封装的请求工具类
- **`lib/utils/dio/interceptors/`** - 请求/响应拦截器

#### 工具类
- **`lib/utils/tool/sp_util.dart`** - SharedPreferences 封装
- **`lib/utils/tool/log_util.dart`** - 日志工具
- **`lib/utils/tool/deviceInfo_util.dart`** - 设备信息获取

## 开发指南

### 环境变量使用
```dart
import 'config/app_env.dart' show appEnv;
appEnv.baseUrl        // 获取当前环境的 URL
appEnv.getAppChannel() // 获取渠道参数
```

### 全局 Context 使用
```dart
import 'config/common_config.dart' show commonConfig;
commonConfig.getGlobalKey // 获取全局 context 对象
```

### 添加新的状态管理
1. 创建 Provider 类（例如在 `pages/app_main/home/provider/` 目录下）
2. 在 `providers_config.dart` 中注册新的 Provider
3. 在页面中使用 `Provider.of<T>(context)` 或 `context.watch<T>()`

### 添加新页面
1. 在 `pages/` 目录下创建页面文件
2. 在 `routes/route_name.dart` 中添加路由名称常量
3. 在 `routes/routes_data.dart` 中添加路由映射
4. 使用 `Navigator.pushNamed()` 进行页面跳转

### 主题切换
```dart
import 'constants/themes/index_theme.dart' show themeBlueGrey;
import 'provider/theme_store.p.dart';

ThemeStore _theme = Provider.of<ThemeStore>(context);
_theme.setTheme(themeBlueGrey); // 切换主题
```

### HTTP 请求使用
```dart
import 'utils/dio/request.dart';

// GET 请求
Map resData = await Request.get('url', queryParameters: {'key': 'value'});

// POST 请求
Map resData = await Request.post('url', data: {'version': version});
```

## 依赖说明

### 核心依赖
- **provider**: 6.1.5+1 - 状态管理
- **dio**: 5.9.0 - HTTP 客户端
- **flutter_screenutil**: 5.9.3 - 屏幕适配
- **shared_preferences**: 2.5.3 - 本地存储

### 功能依赖
- **jh_debug**: 2.0.1 - 调试工具
- **ana_page_loop**: 1.0.1 - 页面统计
- **ota_update**: 7.0.2 - OTA 更新
- **package_info_plus**: 9.0.0 - 应用信息获取
- **permission_handler**: 12.0.1 - 权限管理

## 开发注意事项

### 代码规范
- 遵循 Flutter 官方代码规范
- 使用 `flutter_lints` 进行代码检查
- 文件命名使用 snake_case

### 调试
- 使用 `jh_debug` 进行调试，浮动按钮可在真机上显示错误信息
- 调试开关在 `app_config.dart` 中的 `DEBUG` 和 `printFlag`

### 权限配置
Android 权限需要在 `android/app/src/main/AndroidManifest.xml` 中配置
- 存储权限（用于 OTA 更新）
- 网络权限（用于 API 请求）