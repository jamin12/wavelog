import 'package:blog/const.dart';
import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    Key? key,
  }) : super(key: key);

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
          'Title',
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
          '내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게내용 겁나길게',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20.0,
            color: COLOR_BLACK,
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            children: [
              Container(
                width: 200.0,
                margin: const EdgeInsets.only(right: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                    labelText: 'Nickname',
                  ),
                ),
              ),
              Container(
                width: 250.0,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                    labelText: 'Password',
                  ),
                ),
              ),
            ],
          ),
        ),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLength: null,
          maxLines: null,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              bottom: 16.0,
              top: 8.0,
              left: 10.0,
              right: 10.0,
            ),
            // isCollapsed: true,
            alignLabelWithHint: true,
            suffixIcon: Icon(Icons.send),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: COLOR_BACK)),
            labelText: 'Contents',
          ),
        ),
      ],
    );
  }
}
