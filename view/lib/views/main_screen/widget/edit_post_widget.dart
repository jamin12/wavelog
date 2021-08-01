import 'package:blog/const.dart';
import 'package:flutter/material.dart';

class EditPostWidget extends StatelessWidget {
  const EditPostWidget({
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
          'Add Post',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
            color: COLOR_BLACK,
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
              labelText: 'Category Title',
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLength: null,
          maxLines: null,
          minLines: 20,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              bottom: 16.0,
              top: 8.0,
              left: 10.0,
              right: 10.0,
            ),
            // isCollapsed: true,
            alignLabelWithHint: true,
            border:
                OutlineInputBorder(borderSide: BorderSide(color: COLOR_BACK)),
            labelText: 'Contents',
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Submit'),
          ),
        ),
      ],
    );
  }
}
