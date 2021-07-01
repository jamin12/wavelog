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
                    child:
                        // AboutWidget(),
                        MainWidget(
                      tempCategory: _tempCategory,
                      tempPost: _tempPost,
                    ),
                  ),
                ),
              ),
              _buildWave(size),
              _buildSide(size),
            ],
          ),
        ),
        menu: (context) => Container(
          color: COLOR_BEACH,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tooltip(
                message: 'Home',
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home_outlined,
                    color: COLOR_BLACK,
                    size: 32.0,
                  ),
                ),
              ),
              Tooltip(
                message: 'About us',
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.group_outlined,
                    color: COLOR_BLACK,
                    size: 32.0,
                  ),
                ),
              ),
            ],
          ),
        ),
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
                child: Container(),
              ),
            ),
            Expanded(
              child: Center(),
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
          'About us',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
            color: COLOR_BLACK,
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        SelectableText(
          'Kwon Tae Woong',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            color: COLOR_BACK,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        SelectableText(
          '안녕하세요 Front-End 개발자 권태웅입니다.',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20.0,
            color: COLOR_BLACK,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        _buildPersonalInformation(
            age: 24,
            email: 'kmeoung@gmail.com',
            residence: 'Republic of Korea',
            address: 'Incheon',
            phone: '+82 10-6377-7340'),
        const SizedBox(
          height: 30.0,
        ),
        SelectableText(
          'Kang Kyung Min',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            color: COLOR_BACK,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        SelectableText(
          '안녕하세요 Back-End 개발자 강경민입니다.',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20.0,
            color: COLOR_BLACK,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        _buildPersonalInformation(
            age: 23,
            email: 'rudals951004@gmail.com',
            residence: 'Republic of Korea',
            address: 'Incheon, Gyeonggi-do',
            phone: '+82 10-1234-1234'),
        const SizedBox(
          height: 50.0,
        ),
      ],
    );
  }

  /// 개인 신상정보 입력
  Column _buildPersonalInformation(
      {required int age,
      required String residence,
      required String address,
      required String email,
      required String phone}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: [
              SelectableText(
                'Age ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: COLOR_BACK,
                ),
              ),
              SelectableText(
                '$age',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                  color: COLOR_BLACK,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: [
              SelectableText(
                'Residence ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: COLOR_BACK,
                ),
              ),
              SelectableText(
                '$residence',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                  color: COLOR_BLACK,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: [
              SelectableText(
                'Address ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: COLOR_BACK,
                ),
              ),
              SelectableText(
                '$address',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                  color: COLOR_BLACK,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: [
              SelectableText(
                'e-mail ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: COLOR_BACK,
                ),
              ),
              SelectableText(
                '$email',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                  color: COLOR_BLACK,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: [
              SelectableText(
                'Phone ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: COLOR_BACK,
                ),
              ),
              SelectableText(
                '$phone',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                  color: COLOR_BLACK,
                ),
              ),
            ],
          ),
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
            color: COLOR_BLACK,
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
                          color: COLOR_BLACK,
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
                  color: COLOR_BLACK.withOpacity(0.9),
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
