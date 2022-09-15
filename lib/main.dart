import 'package:flutter/material.dart';
import 'center_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter MacBox'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _controller = PageController();
  final ValueNotifier<int> _selectIndex = ValueNotifier(0);
  bool _extended = false;

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _toggleExtended() {
    setState(() {
      _extended = !_extended;
    });
  }

  final List<NavigationRailDestination> destinations = const [
    NavigationRailDestination(icon: Icon(Icons.message_outlined), label: Text("消息")),
    NavigationRailDestination(icon: Icon(Icons.video_camera_back_outlined), label: Text("视频会议")),
    NavigationRailDestination(icon: Icon(Icons.book_outlined), label: Text("通讯录")),
    NavigationRailDestination(icon: Icon(Icons.cloud_upload_outlined), label: Text("云文档")),
    NavigationRailDestination(icon: Icon(Icons.games_sharp), label: Text("工作台")),
    NavigationRailDestination(icon: Icon(Icons.calendar_month), label: Text("日历"))
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
    //TODO 更新索引 + 切换界面
    print(value);
    _controller.jumpToPage(value); // tag1
    _selectIndex.value = value; //tag2
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
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
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _selectIndex.dispose();
    super.dispose();
  }
}
