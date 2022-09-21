import 'package:flutter/material.dart';
import 'center_text.dart';

class MenuToolView extends StatefulWidget {
  const MenuToolView({Key? key}) : super(key: key);

  @override
  State<MenuToolView> createState() => _MenuToolViewState();
}

class _MenuToolViewState extends State<MenuToolView> {
  final PageController _controller = PageController();
  final ValueNotifier<int> _selectIndex = ValueNotifier(0);
  bool _extended = false;

  void _toggleExtended() {
    setState(() {
      _extended = !_extended;
    });
  }

  final List<NavigationRailDestination> destinations = const [
    NavigationRailDestination(
        icon: Icon(Icons.message_outlined), label: Text("消息")),
    NavigationRailDestination(
        icon: Icon(Icons.video_camera_back_outlined), label: Text("视频会议")),
    NavigationRailDestination(
        icon: Icon(Icons.book_outlined), label: Text("通讯录")),
    NavigationRailDestination(
        icon: Icon(Icons.cloud_upload_outlined), label: Text("云文档")),
    NavigationRailDestination(
        icon: Icon(Icons.games_sharp), label: Text("工作台")),
    NavigationRailDestination(
        icon: Icon(Icons.calendar_month), label: Text("日历"))
  ];

  Widget _buildLeading() {
    return GestureDetector(onTap: _toggleExtended, child: FlutterLogo());
  }

  Widget _buildLeftNavigation(int index) {
    return NavigationRail(
      extended: _extended,
      leading: _buildLeading(),
      onDestinationSelected: _onDestinationSelected,
      destinations: destinations,
      selectedIndex: index,
      minExtendedWidth: 200,
    );
  }

  void _onDestinationSelected(int value) {
    _controller.jumpToPage(value);
    _selectIndex.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ValueListenableBuilder(
            valueListenable: _selectIndex,
            builder: (_, index, __) => _buildLeftNavigation(index),
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              children: const [
                CenterText(title: '消息'),
                CenterText(title: '视频会议'),
                CenterText(title: '通讯录'),
                CenterText(title: '云文档'),
                CenterText(title: '工作台'),
                CenterText(title: '日历'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _selectIndex.dispose();
    super.dispose();
  }
}
