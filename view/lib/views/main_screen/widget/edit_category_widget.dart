import 'package:blog/const.dart';
import 'package:flutter/material.dart';

class EditCategoryWidget extends StatelessWidget {
  const EditCategoryWidget({
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
          'Add Category',
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
