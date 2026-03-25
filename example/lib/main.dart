/*
Name: Akshath Jain
Date: 3/18/2019 - 4/26/2021
Purpose: Example app that implements the package: sliding_up_panel_plus
Copyright: © 2021, Akshath Jain. All rights reserved.
Licensing: See LICENSE in the project root.
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel_plus/sliding_up_panel_plus.dart';

void main() => runApp(const SlidingUpPanelPlusExample());

class SlidingUpPanelPlusExample extends StatelessWidget {
  const SlidingUpPanelPlusExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFFF1F5F9),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Color(0xFFE2E8F0),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SlidingUpPanel Plus Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F766E)),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double _panelHeightClosed = 112.0;
  static const double _fabBaseHeight = 144.0;

  final PanelController _panelController = PanelController();

  double _fabHeight = _fabBaseHeight;
  double _panelHeightOpen = 0.0;

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * 0.72;

    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            controller: _panelController,
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: 0.18,
            backdropEnabled: true,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x260F172A),
                blurRadius: 24,
                offset: Offset(0, -6),
              ),
            ],
            body: _body(),
            collapsed: _collapsedPanel(),
            panelBuilder: _panel,
            onPanelSlide: (double position) {
              setState(() {
                _fabHeight =
                    position * (_panelHeightOpen - _panelHeightClosed) +
                        _fabBaseHeight;
              });
            },
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 20,
            right: 20,
            child: _topBar(),
          ),
          Positioned(
            right: 20,
            bottom: _fabHeight,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF0F766E),
              onPressed: () {
                if (_panelController.isAttached &&
                    _panelController.isPanelOpen) {
                  _panelController.close();
                } else if (_panelController.isAttached) {
                  _panelController.open();
                }
              },
              child: const Icon(Icons.tune),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBar() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x140F172A),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Color(0xFFCCFBF1),
              foregroundColor: Color(0xFF0F766E),
              child: Icon(Icons.explore),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'SlidingUpPanel Plus',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '一个不依赖第三方地图包的可运行示例',
                    style: TextStyle(color: Color(0xFF475569)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _collapsedPanel() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0xFFCBD5E1),
                borderRadius: BorderRadius.all(Radius.circular(999)),
              ),
              child: SizedBox(width: 36, height: 5),
            ),
          ),
          SizedBox(height: 16),
          Text(
            '设计任务概览',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 6),
          Text(
            '上滑查看更多卡片、进度和操作按钮。',
            style: TextStyle(color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  Widget _panel(ScrollController controller) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: controller,
        padding: const EdgeInsets.fromLTRB(24, 18, 24, 32),
        children: <Widget>[
          const Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0xFFCBD5E1),
                borderRadius: BorderRadius.all(Radius.circular(999)),
              ),
              child: SizedBox(width: 36, height: 5),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '项目控制面板',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            '这个示例保留了 panelBuilder、拖拽、吸附和遮罩等核心能力，同时移除了旧版依赖带来的空安全报错。',
            style: TextStyle(color: Color(0xFF64748B), height: 1.5),
          ),
          const SizedBox(height: 24),
          Row(
            children: const <Widget>[
              Expanded(
                child: _MetricCard(
                  title: '本周任务',
                  value: '12',
                  subtitle: '3 项等待确认',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  title: '完成率',
                  value: '86%',
                  subtitle: '较上周 +14%',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            '快捷操作',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              _actionChip('新建面板', Icons.add_box_outlined),
              _actionChip('同步进度', Icons.sync_outlined),
              _actionChip('分享预览', Icons.ios_share_outlined),
              _actionChip('导出数据', Icons.download_outlined),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            '最近更新',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          const _TimelineTile(
            title: '交互示例已更新',
            description: '移除过时依赖后，example 可以直接在 Flutter 3.35.7 下运行。',
          ),
          const _TimelineTile(
            title: '空安全兼容完成',
            description: 'Dart SDK 约束已放宽到 <4.0.0，避免 Dart 3 环境下直接报红。',
          ),
          const _TimelineTile(
            title: '保留滚动联动能力',
            description: '示例继续使用 panelBuilder 和 ListView，便于验证手势与滚动协作。',
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_panelController.isAttached) {
                  _panelController.close();
                }
              },
              icon: const Icon(Icons.keyboard_arrow_down),
              label: const Text('收起面板'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFECFEFF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 18, color: const Color(0xFF0F766E)),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFFCCFBF1),
            Color(0xFFE2E8F0),
            Color(0xFFF8FAFC),
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 112, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                '拖动底部面板查看完整内容',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '这个页面专门用于验证 sliding_up_panel_plus 在新版本 Flutter 下的基础可用性。',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Color(0xFF334155),
                ),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: Row(
                  children: const <Widget>[
                    Expanded(
                      child: _ShowcaseCard(
                        title: '手势拖拽',
                        value: 'Smooth',
                        icon: Icons.pan_tool_alt_outlined,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _ShowcaseCard(
                        title: '滚动联动',
                        value: 'Linked',
                        icon: Icons.swap_vert_circle_outlined,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const _InfoBanner(),
              SizedBox(height: _panelHeightClosed + 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.subtitle,
  });

  final String title;
  final String value;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: const TextStyle(color: Color(0xFF64748B))),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(subtitle, style: const TextStyle(color: Color(0xFF0F766E))),
        ],
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  const _TimelineTile({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              color: Color(0xFF14B8A6),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    height: 1.5,
                    color: Color(0xFF475569),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShowcaseCard extends StatelessWidget {
  const _ShowcaseCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x120F172A),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(icon, color: const Color(0xFF0F766E)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              Text(title, style: const TextStyle(color: Color(0xFF475569))),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: <Widget>[
          Icon(Icons.info_outline, color: Colors.white),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              '如果你只想验证包本身，这个 example 已经足够，不再受旧版地图生态影响。',
              style: TextStyle(color: Colors.white, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
