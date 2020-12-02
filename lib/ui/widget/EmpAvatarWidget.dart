import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:job_karo_floor_manager/constants/app_font_style.dart';
import 'package:job_karo_floor_manager/constants/colors.dart';
import 'package:job_karo_floor_manager/model/TeamModel.dart';

class EmpAvatarWidget extends StatelessWidget {

  final TeamModel techinican;

  EmpAvatarWidget(this.techinican);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(
              'https://www.adbasis.com/images/divita-a65623c8.jpg'),
          radius: 32,
        ),
        Text(
          techinican.name,
          style: AppFontStyle.labelTextStyle3(APP_BLACK_COLOR),
        ),
        Text(
          'Technician',
          style: AppFontStyle.labelTextStyle4(APP_BLACK_COLOR),
        )
      ],
    );
  }
}
