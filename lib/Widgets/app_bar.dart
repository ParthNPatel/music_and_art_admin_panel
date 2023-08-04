import 'package:music_and_art_admin_panel/Widgets/app_color.dart';
import 'package:music_and_art_admin_panel/Widgets/images_path.dart';
import 'package:music_and_art_admin_panel/Widgets/responsive.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar({BuildContext? context, onPress}) {
  return AppBar(
    toolbarHeight: 70,
    elevation: 0,
    backgroundColor: AppColor.whiteColor,
    title: Row(
      children: [

        Text(
          'MUSIC AND ART ADMIN PANEL',
          style: TextStyle(
            color: AppColor.blackColor,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    ),
    leading: Responsive.isMobile(context!)
        ? IconButton(
            onPressed: onPress,
            icon: Icon(
              Icons.menu,
              color: AppColor.blackColor,
            ),
          )
        : SizedBox(),
    actions: [
      Center(
        child: Text(
          'Hello, Admin',
          style: TextStyle(
            wordSpacing: 2,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w300,
            fontSize: 21,
          ),
        ),
      ),
      SizedBox(
        width: 100,
      )
    ],
  );
}
