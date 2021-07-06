import 'package:blog/const.dart';
import 'package:flutter/material.dart';

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
            phone: '+82 10-7454-0118'),
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
