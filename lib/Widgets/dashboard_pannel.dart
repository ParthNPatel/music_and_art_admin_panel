import 'package:music_and_art_admin_panel/Widgets/app_color.dart';
import 'package:music_and_art_admin_panel/Widgets/dashboard_view.dart';
import 'package:music_and_art_admin_panel/Widgets/images_path.dart';
import 'package:music_and_art_admin_panel/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tiles.dart';

class DashBoardPanel extends StatelessWidget {
  final drawerKey;

  const DashBoardPanel({super.key, required this.drawerKey});

  /// update __icon__ and __text__ color when button is pressed in
  /// dashboard panel
  ///
  /// default color white
  Color _updateColor(Rx<DashBoardPanelScreens> currentScreen,
      DashBoardPanelScreens dashBoardPanelScreens,
      {required BuildContext context}) {
    if (currentScreen.value == dashBoardPanelScreens) {
      return AppColor.whiteColor;
    }
    return AppColor.whiteColor;
  }

  final double iconHeight = 22;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      color: AppColor.mainColor,
      child: GetX<DashBoardController>(
        init: DashBoardController(),
        builder: (controller) => Column(
          children: [
            const SizedBox(
              height: 40,
            ),

            /// 0
            MouseRegion(
              onEnter: (e) {
                controller.updateHover(true);
              },
              onExit: (e) {
                controller.updateHover(false);
              },
              child: Container(
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: controller.currentScreen.value ==
                          DashBoardPanelScreens.dashboard
                      ? Color(0xff066A60)
                      : controller.hover.value == true
                          ? Color(0xff066A60)
                          : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(100),
                    topRight: Radius.circular(100),
                  ),
                ),
                child: CustomTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      AppImages.dashboard,
                      height: iconHeight,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  textColor: _updateColor(
                      controller.currentScreen, DashBoardPanelScreens.dashboard,
                      context: context),
                  titleMessage: "Dashboard",
                  onTap: () {
                    controller.currentScreen.value =
                        DashBoardPanelScreens.dashboard;
                    drawerKey.currentState!.closeDrawer();

                    // Get.offAndToNamed(Routes.progressReport);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),




            /// 1
            MouseRegion(
              onEnter: (e) {
                controller.updateHover2(true);
              },
              onExit: (e) {
                controller.updateHover2(false);
              },
              child: Container(
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: controller.currentScreen.value ==
                          DashBoardPanelScreens.postCategories
                      ? Color(0xff066A60)
                      : controller.hover2.value == true
                          ? Color(0xff066A60)
                          : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(100),
                    topRight: Radius.circular(100),
                  ),
                ),
                child: CustomTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      AppImages.categories,
                      height: iconHeight,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  textColor: _updateColor(controller.currentScreen,
                      DashBoardPanelScreens.postCategories,
                      context: context),
                  titleMessage: "Categories",
                  onTap: () {
                    controller.currentScreen.value =
                        DashBoardPanelScreens.postCategories;
                    drawerKey.currentState!.closeDrawer();

                    // Get.offAndToNamed(Routes.video);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            /// 2
            MouseRegion(
              onEnter: (e) {
                controller.updateHover3(true);
              },
              onExit: (e) {
                controller.updateHover3(false);
              },
              child: Container(
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: controller.currentScreen.value ==
                          DashBoardPanelScreens.FaqCategories
                      ? Color(0xff066A60)
                      : controller.hover3.value == true
                          ? Color(0xff066A60)
                          : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(100),
                    topRight: Radius.circular(100),
                  ),
                ),
                child: CustomTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      AppImages.categories,
                      height: iconHeight,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  textColor: _updateColor(controller.currentScreen,
                      DashBoardPanelScreens.FaqCategories,
                      context: context),
                  titleMessage: "Age Group",
                  onTap: () {
                    controller.currentScreen.value =
                        DashBoardPanelScreens.FaqCategories;
                    drawerKey.currentState!.closeDrawer();

                    // Get.offAndToNamed(Routes.video);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            /// 3
            MouseRegion(
              onEnter: (e) {
                controller.updateHover4(true);
              },
              onExit: (e) {
                controller.updateHover4(false);
              },
              child: Container(
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: controller.currentScreen.value ==
                          DashBoardPanelScreens.FAQ
                      ? Color(0xff066A60)
                      : controller.hover4.value == true
                          ? Color(0xff066A60)
                          : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(100),
                    topRight: Radius.circular(100),
                  ),
                ),
                child: CustomTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      AppImages.FAQ,
                      color: AppColor.whiteColor,
                      height: iconHeight,
                    ),
                  ),
                  titleMessage: "Age Content",
                  textColor: _updateColor(
                      controller.currentScreen, DashBoardPanelScreens.FAQ,
                      context: context),
                  onTap: () {
                    controller.currentScreen.value = DashBoardPanelScreens.FAQ;
                    drawerKey.currentState!.closeDrawer();

                    // Get.offAndToNamed(Routes.FAQ);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            ///4
            MouseRegion(
              onEnter: (e) {
                controller.updateHover1(true);
              },
              onExit: (e) {
                controller.updateHover1(false);
              },
              child: Container(
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: controller.currentScreen.value ==
                      DashBoardPanelScreens.video
                      ? Color(0xff066A60)
                      : controller.hover1.value == true
                      ? Color(0xff066A60)
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(100),
                    topRight: Radius.circular(100),
                  ),
                ),
                child: CustomTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      AppImages.video,
                      height: iconHeight,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  textColor: _updateColor(
                      controller.currentScreen, DashBoardPanelScreens.video,
                      context: context),
                  titleMessage: "Video",
                  onTap: () {
                    controller.currentScreen.value =
                        DashBoardPanelScreens.video;
                    drawerKey.currentState!.closeDrawer();

                    // Get.offAndToNamed(Routes.video);
                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
