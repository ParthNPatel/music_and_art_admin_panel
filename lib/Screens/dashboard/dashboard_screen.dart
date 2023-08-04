import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_and_art_admin_panel/Widgets/app_color.dart';
import 'package:music_and_art_admin_panel/Widgets/images_path.dart';
import 'package:music_and_art_admin_panel/viewModel/dashboard_view_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashBoardViewModel dashBoardViewModel = Get.put(DashBoardViewModel());
  @override
  void initState() {
    dashBoardViewModel.getCategoriesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DashBoardViewModel>(
        builder: (controller) {
          return controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(color: Colors.teal),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(50, 25, 0, 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 50),
                          height: 465,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.parrotColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.video,
                                height: 70,
                                width: 70,
                                color: AppColor.blackColor,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'video'.toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 26),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                '${controller.video.length}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                    color: AppColor.blackColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 50),
                          height: 465,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.orange300,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.FAQ,
                                height: 70,
                                width: 70,
                                color: AppColor.blackColor,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Categories'.toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 26),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                '${controller.categories.length}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 465,
                          margin: const EdgeInsets.only(right: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.purple300,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 70,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'User'.toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 26),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                '3',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
