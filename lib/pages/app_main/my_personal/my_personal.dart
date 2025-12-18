import 'package:flutter/material.dart';
import 'package:jh_debug/jh_debug.dart';
import '../../../../routes/route_name.dart';

import 'components/head_userbox.dart';

class MyPersonal extends StatefulWidget {
  @override
  State<MyPersonal> createState() => _MyPersonalState();
}

class _MyPersonalState extends State<MyPersonal>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyPersonal页面'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          HeadUserBox(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'myPerBtn1',
        onPressed: () {
          jhDebug.showDebugBtn(); // 全局显示调试按钮
        },
        tooltip: '显示全局浮动调试按钮',
        child: const Icon(Icons.bug_report),
      ), //
    );
  }
}
