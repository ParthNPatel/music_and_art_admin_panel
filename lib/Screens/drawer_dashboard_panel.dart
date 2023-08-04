
import 'package:music_and_art_admin_panel/Screens/add_post_categories/add_post_categories_screen.dart';
import 'package:music_and_art_admin_panel/Screens/age_content/age_content_screen.dart';
import 'package:music_and_art_admin_panel/Screens/age_group/age_group_screen.dart';
import 'package:music_and_art_admin_panel/Screens/dashboard/dashboard_screen.dart';
import 'package:music_and_art_admin_panel/Screens/video/video_screen.dart';
import 'package:music_and_art_admin_panel/Widgets/app_bar.dart';
import 'package:music_and_art_admin_panel/Widgets/app_color.dart';
import 'package:music_and_art_admin_panel/Widgets/dashboard_pannel.dart';
import 'package:music_and_art_admin_panel/Widgets/dashboard_view.dart';
import 'package:music_and_art_admin_panel/Widgets/responsive.dart';
import 'package:music_and_art_admin_panel/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DashBoardController dashBoardController = Get.put(DashBoardController());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.bgColor,
      appBar: customAppBar(
          context: context,
          onPress: () {
            _scaffoldKey.currentState!.openDrawer();
          }),
      drawer: Responsive.isMobile(context)
          ? DashBoardPanel(
              drawerKey: _scaffoldKey,
            )
          : SizedBox(),
      body: Row(
        children: [
          Responsive.isMobile(context)
              ? SizedBox()
              : DashBoardPanel(
                  drawerKey: _scaffoldKey,
                ),
          Obx(() {
            return Expanded(
              child: dashBoardController.currentScreen.value ==
                      DashBoardPanelScreens.dashboard
                  ? DashboardScreen()
                  : dashBoardController.currentScreen.value ==
                          DashBoardPanelScreens.video
                      ? VideoScreen()
                      : dashBoardController.currentScreen.value ==
                              DashBoardPanelScreens.postCategories
                          ? AddPostCategoriesScreen()
                          : dashBoardController.currentScreen.value ==
                                  DashBoardPanelScreens.FaqCategories
                              ? AgeGroupScreen()
                              : AgeContentScreen(),
            );

            // Expanded(
            //   child: dashBoardController.currentScreen.value ==
            //           DashBoardPanelScreens.dashboard
            //       ? DashboardScreen()
            //       : dashBoardController.currentScreen.value ==
            //               DashBoardPanelScreens.video
            //           ? VideoScreen()
            //           : FAQScreen());
          })
        ],
      ),
    );
  }
}
