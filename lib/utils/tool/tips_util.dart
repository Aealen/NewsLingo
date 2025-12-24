import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Tips {
  /// tosat常规提示
  static Future<void> info(String text, {ToastGravity? gravity}) async {
    if (kIsWeb) {
      // Web 环境使用 ScaffoldMessenger（需要传入 context）
      // 由于静态方法无法获取 context，暂时在 Web 环境下不显示提示
      print('提示: $text');
      return;
    }

    try {
      Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity ?? ToastGravity.BOTTOM, // 提示位置
        fontSize: 18, // 提示文字大小
      );
    } catch (e) {
      // Fluttertoast 初始化失败时忽略错误
      print('Toast 显示失败 ($text): $e');
    }
  }

  /// 显示 SnackBar（需要 context）
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
