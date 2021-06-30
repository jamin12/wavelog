import 'package:blog/const.dart';
import 'package:blog/views/common_components/layout/web_layout.dart';
import 'package:blog/views/page_class_wrapper/page_class.dart';
import 'package:blog/wave_animation.dart';
import 'package:flutter/material.dart';

class MainScreen extends PageClass {
  final List<String> _tempCategory = [
    'All',
    'Category 1',
    'Category 2',
    'Category 3'
  ];

  final List<String> _tempPost = [
    'All',
    'Post 1',
    'Post 2',
    'Post 3',
    'Post 4',
    'Post 5',
    'Post 6',
    'Post 7',
    'Post 8',
    'Post 9',
    '이게 뭔가 가치있는 제목인것 같아 보이게 한다 ㅋㅋ 근데 아마 의도대로는 되지 않을것이다.',
  ];
  @override
  Widget appScaffold(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

  @override
  Widget webScaffold(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: WebLayout(
        mainContents: (context) => Container(
          color: COLOR_BEACH,
          child: Stack(
            children: [
              _buildWave(size),
              _buildSide(size),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: size.width / 6 * 3,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80.0),
                    child: MainWidget(
                      tempCategory: _tempCategory,
                      tempPost: _tempPost,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        menu: (context) => Container(),
      ),
    );
  }

  AnimatedContainer _buildWave(Size size) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 10),
      child: SizedBox(
        width: size.width / 6,
        child: RotatedBox(
          quarterTurns: 1,
          child: WaveAnimation(
            waveSpeed: 2,
            reverse: false,
          ),
        ),
      ),
    );
  }

  Positioned _buildSide(Size size) {
    return Positioned(
      left: 0,
      top: 0,
      bottom: 0,
      width: size.width / 6,
      child: Container(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: size.width / 12,
                height: size.width / 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: COLOR_BEACH,
                  border: Border.all(
                      color: COLOR_BACK, style: BorderStyle.solid, width: 10.0),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(5.0, 5.0),
                      color: COLOR_BEACH,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: size.width / 8,
                  height: size.width / 40,
                  decoration: BoxDecoration(
                      color: COLOR_BEACH,
                      border: Border.all(
                        color: COLOR_DARK,
                        style: BorderStyle.solid,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(100.0)),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: ElevatedButton(onPressed: () {}, child: Text('Hello')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50.0,
        ),
        SelectableText(
          'About',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
            color: COLOR_DARK,
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        const SizedBox(
          height: 50.0,
        ),
      ],
    );
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({
    Key? key,
    required List<String> tempCategory,
    required List<String> tempPost,
  })  : _tempCategory = tempCategory,
        _tempPost = tempPost,
        super(key: key);

  final List<String> _tempCategory;
  final List<String> _tempPost;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50.0,
        ),
        SelectableText(
          'Post',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
            color: COLOR_DARK,
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: _tempCategory
                .map(
                  (String category) => TextButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: COLOR_DARK,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
            childAspectRatio: 5 / 4,
          ),
          itemCount: _tempPost.length,
          itemBuilder: (context, index) => ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Icon(
                    Icons.water_rounded,
                    size: 300.0,
                  ),
                ),
                Container(
                  color: COLOR_DARK.withOpacity(0.9),
                  child: Center(
                    child: Text(
                      _tempPost[index],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 50.0,
        ),
      ],
    );
  }
}
