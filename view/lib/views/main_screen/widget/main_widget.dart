import 'package:blog/const.dart';
import 'package:flutter/material.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({
    Key? key,
    required List<String> tempCategory,
    required List<String> tempPost,
    required this.itemClickListener,
  })  : _tempCategory = tempCategory,
        _tempPost = tempPost,
        super(key: key);

  final Function(int index) itemClickListener;
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
            child: GestureDetector(
              onTap: () {
                itemClickListener(index);
              },
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
        ),
        const SizedBox(
          height: 50.0,
        ),
      ],
    );
  }
}
