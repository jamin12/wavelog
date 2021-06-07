import 'package:blog/const.dart';
import 'package:blog/screen/main_page.dart';
import 'package:blog/widget/wave_animation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainBody extends StatefulWidget {
  final PAGE_TYPE pageType;
  final Size bodySize;
  late Function changePage;
  MainBody({required this.pageType, required this.bodySize});

  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> with TickerProviderStateMixin {
  late double bodyHeight;

  // 기본 색상 지정
  late final Color _bgColor = COLOR_BEACH;
  late final Color _waveColor = COLOR_SEA;
  final _categoryList = [
    'ALL',
    'Life',
    'Study',
    'Project',
    'Information',
    'Free'
  ];

  // 애니메이션 컨트롤러
  late Map<ANIMATION_TYPE, AnimationController> _controllers;
  // 애니메이션
  late Map<ANIMATION_TYPE, Animation<double>?> _animations;

  late ANIMATION_TYPE _animationType;

  late PAGE_TYPE _currentPageType;

  @override
  void initState() {
    super.initState();
    bodyHeight = widget.bodySize.height;
    _currentPageType = widget.pageType;

    widget.changePage = (PAGE_TYPE type) {
      _currentPageType = type;
      initAnimation(initialType: ANIMATION_TYPE.CHANGE);
    };

    initAnimation();
  }

  initAnimation({ANIMATION_TYPE initialType = ANIMATION_TYPE.START}) {
    // 애니메이션 초기 설정 (시작 애니메이션)
    _animationType = initialType;

    _controllers = {
      ANIMATION_TYPE.START: AnimationController(
          vsync: this, duration: Duration(seconds: 1), value: 0),
      ANIMATION_TYPE.CHANGE: AnimationController(
          vsync: this, duration: Duration(milliseconds: 500), value: 0),
    };

    _animations = {
      ANIMATION_TYPE.START: Tween<double>(
              begin: (_currentPageType == PAGE_TYPE.SEA)
                  ? -bodyHeight * 0.3
                  : -bodyHeight * 1.6,
              end: (_currentPageType == PAGE_TYPE.SEA)
                  ? -bodyHeight * 0.6
                  : -bodyHeight * 1.35)
          .animate(CurvedAnimation(
              parent: _controllers[ANIMATION_TYPE.START]!,
              curve: Curves.decelerate))
            ..addListener(() {
              if (_controllers[ANIMATION_TYPE.START]!.isCompleted &&
                  _animationType != ANIMATION_TYPE.NONE) {
                _animationType = ANIMATION_TYPE.NONE;
                setState(() {});
              }
            }),
      ANIMATION_TYPE.CHANGE: Tween<double>(
              begin: (_currentPageType != PAGE_TYPE.SEA)
                  ? -bodyHeight * 0.6
                  : -bodyHeight * 1.35,
              end: (_currentPageType != PAGE_TYPE.SEA)
                  ? -bodyHeight * 1.6
                  : -bodyHeight * 0.3)
          .animate(_controllers[ANIMATION_TYPE.CHANGE]!)
            ..addListener(() {
              if (_controllers[ANIMATION_TYPE.CHANGE]!.isCompleted &&
                  _animationType == ANIMATION_TYPE.CHANGE) {
                _animationType = ANIMATION_TYPE.START;
                _controllers[ANIMATION_TYPE.START]!.forward();
                setState(() {});
              }
            }),
    };
    _controllers[_animationType]!.forward();
  }

  @override
  void didUpdateWidget(covariant MainBody oldWidget) {
    bodyHeight = widget.bodySize.height;
    widget.changePage = (PAGE_TYPE type) {
      _currentPageType = type;
      initAnimation(initialType: ANIMATION_TYPE.CHANGE);
    };
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controllers.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  // 파도 애니메이션 빌드
  List<Widget> buildWaveAnimation() {
    late double animationValue = _currentPageType == PAGE_TYPE.SEA
        ? -bodyHeight * 0.6
        : -bodyHeight * 1.35;
    List<Widget> _list = [];

    if (_animationType == ANIMATION_TYPE.START)
      animationValue = _animations[ANIMATION_TYPE.START]!.value;
    else if (_animationType == ANIMATION_TYPE.CHANGE)
      animationValue = _animations[ANIMATION_TYPE.CHANGE]!.value;

    _list.add(
      Positioned(
        left: 0,
        right: 0,
        bottom: (_currentPageType == PAGE_TYPE.BEACH) ? null : animationValue,
        top: (_currentPageType == PAGE_TYPE.SEA) ? null : animationValue,
        child: Container(
          height: bodyHeight * 1.5,
          child: RotatedBox(
            quarterTurns: (_currentPageType == PAGE_TYPE.BEACH) ? 2 : 0,
            child: WaveAnimation(
              waveColor: _waveColor.withBlue(255).withOpacity(0.4),
              waveSpeed: 5,
            ),
          ),
        ),
      ),
    );

    _list.add(
      Positioned(
        left: 0,
        right: 0,
        bottom: (_currentPageType == PAGE_TYPE.BEACH) ? null : animationValue,
        top: (_currentPageType == PAGE_TYPE.SEA) ? null : animationValue,
        child: Container(
          height: bodyHeight * 1.5,
          child: RotatedBox(
            quarterTurns: (_currentPageType == PAGE_TYPE.BEACH) ? 2 : 0,
            child: WaveAnimation(
              waveColor: _waveColor.withBlue(200).withOpacity(0.4),
              waveSpeed: 4,
            ),
          ),
        ),
      ),
    );

    _list.add(
      Positioned(
        left: 0,
        right: 0,
        bottom: (_currentPageType == PAGE_TYPE.BEACH) ? null : animationValue,
        top: (_currentPageType == PAGE_TYPE.SEA) ? null : animationValue,
        child: Container(
          height: bodyHeight * 1.5,
          child: RotatedBox(
            quarterTurns: (_currentPageType == PAGE_TYPE.BEACH) ? 2 : 0,
            child: WaveAnimation(
              waveColor: _waveColor.withOpacity(0.4),
              waveSpeed: 3,
            ),
          ),
        ),
      ),
    );

    return _list;
  }

  Container _buildCategoryItem(
      {required Color iconColor, required String title}) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
      height: 100,
      decoration: BoxDecoration(
        color: COLOR_BEACH,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: COLOR_DRAWABLE, width: 1),
        // boxShadow: [
        //   BoxShadow(
        //     color: COLOR_BEACH,
        //     offset: Offset(10, 10),
        //     blurRadius: 30.0,
        //   ),
        // ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: CircleAvatar(
              radius: widget.bodySize.width < 1000
                  ? widget.bodySize.width / 25
                  : widget.bodySize.width / 50,
              backgroundColor: iconColor,
              child: SvgPicture.asset(
                _currentPageType == PAGE_TYPE.BEACH
                    ? 'assets/umbrella.svg'
                    : 'assets/fish.svg',
                color: COLOR_BEACH,
                width: widget.bodySize.width < 1000
                    ? widget.bodySize.width / 25
                    : widget.bodySize.width / 50,
                height: widget.bodySize.width < 1000
                    ? widget.bodySize.width / 25
                    : widget.bodySize.width / 50,
              ),
            ),
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                color: COLOR_DRAWABLE,
                fontWeight: FontWeight.bold,
                fontSize: widget.bodySize.width < 1000
                    ? widget.bodySize.width / 25
                    : widget.bodySize.width / 50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.bodySize.width,
      height: bodyHeight,
      color: _bgColor,
      child: Stack(children: [
        AnimatedBuilder(
          animation: _animationType == ANIMATION_TYPE.START
              ? _animations[ANIMATION_TYPE.START]!
              : _animations[ANIMATION_TYPE.CHANGE]!,
          builder: (context, child) => Stack(
            children: buildWaveAnimation(),
          ),
        ), // 여기서 카테고리 List 추가
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: bodyHeight * 0.2,
              ),
              GridView.builder(
                itemCount: _categoryList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.bodySize.width < 1000 ? 1 : 2,
                    childAspectRatio: 5 / 1), // Ratio = Width / Height
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => _buildCategoryItem(
                  iconColor: Colors.accents[index % Colors.accents.length],
                  title: '${_categoryList[index]}',
                ),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
