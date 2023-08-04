import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_and_art_admin_panel/Screens/add_post_categories/add_post_categories_screen.dart';
import 'package:music_and_art_admin_panel/Widgets/app_color.dart';
import 'package:music_and_art_admin_panel/Widgets/snackbar.dart';
import 'package:music_and_art_admin_panel/viewModel/age_content_view_model.dart';

class AgeContentScreen extends StatefulWidget {
  const AgeContentScreen({Key? key}) : super(key: key);

  @override
  State<AgeContentScreen> createState() => _AgeContentScreenState();
}

class _AgeContentScreenState extends State<AgeContentScreen> {
  @override
  void initState() {
    ageContentViewModel.getCategoriesList();

    super.initState();
  }

  AgeContentViewModel ageContentViewModel = Get.put(AgeContentViewModel());
  @override
  Widget build(BuildContext context) {
    double baseWidth = 1489;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: GetBuilder<AgeContentViewModel>(
        builder: (controller) {
          return Container(
            height: height,
            width: width,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppColor.mainColor),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Age Group',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.mainColor,
                            ),
                            onPressed: () {
                              newsCategoriesAddDialog(context: context);
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Add',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColor.whiteColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: AppColor.mainColor,
                    padding: const EdgeInsets.all(13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.only(left: 20),
                            color: AppColor.mainColor,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Thumbnail',
                              style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.only(left: 20),
                            color: AppColor.mainColor,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Title',
                              style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 25,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 25,
                          width: 25,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('ageContent')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data!.docs;
                        return ListView.separated(
                          // reverse: true,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemCount: data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.fromLTRB(0, 12, 10, 12),
                              height: 90,
                              color: AppColor.whiteColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 20),
                                      alignment: Alignment.centerLeft,
                                      child: Image.network(
                                        '${data[index]['ageImage']}',
                                        fit: BoxFit.cover,
                                        width: 150,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 20),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${data[index]['ageContentName']}",
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: AppColor.blackColor,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(5),
                                    onTap: () {
                                      try {
                                        controller.categoriesController.text =
                                            data[index]['ageContentName'];
                                        controller.imageUrl =
                                            data[index]['ageImage'];
                                        controller.imageName =
                                            data[index]['fileName'];

                                        controller.selectedCategory = {
                                          'name': data[index]['categoriesName'],
                                          'id': data[index]['categoriesId'],
                                        };
                                        controller.selectedAge = {
                                          'name': data[index]['ageName'],
                                          'id': data[index]['ageId'],
                                        };
                                        controller.descriptionController.text =
                                            data[index]['description'] ?? '';
                                        controller.audioUrl =
                                            data[index]['addAudio'];
                                      } catch (e) {
                                        print('------$e');
                                      }
                                      newsCategoriesAddDialog(
                                          context: context,
                                          isEdit: true,
                                          documentId: data[index].id,
                                          fileName: data[index]['fileName']);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.teal)),
                                      child: FittedBox(
                                        child: Icon(Icons.edit),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(5),
                                    onTap: () {
                                      deleteDialog(
                                          onPress: () async {
                                            Get.back();
                                            await FirebaseFirestore.instance
                                                .collection('ageContent')
                                                .doc(data[index].id)
                                                .delete();
                                          },
                                          header:
                                              'Are you sure to delete this Category?',
                                          context: context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.teal)),
                                      child: FittedBox(
                                        child: Icon(Icons.delete),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Something Went Wrong'),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.teal,
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  newsCategoriesAddDialog(
      {BuildContext? context,
      bool isEdit = false,
      String? documentId,
      String? fileName}) {
    InputBorder outlineBorder = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(7));
    return showDialog(
      context: context!,
      barrierDismissible: false,
      barrierColor: Colors.black12,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setStat) {
            return GetBuilder<AgeContentViewModel>(
              builder: (controller) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Center(
                    child: Container(
                      width: 350,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(17),
                              color: AppColor.mainColor,
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: AppColor.whiteColor,
                                      child: FittedBox(
                                        child: Icon(
                                          Icons.clear,
                                          color: AppColor.mainColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        isEdit == true
                                            ? 'Edit Age Content'
                                            : 'Add Age Content',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.whiteColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(50, 25, 50, 25),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Edit Age Content',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade50,
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint:
                                            controller.selectedCategory.isEmpty
                                                ? Text('Select Categories')
                                                : Text(
                                                    '${controller.selectedCategory['name']}',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                        items: controller.categoriesList
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(
                                                  '${e['name']}',
                                                  style: TextStyle(
                                                    color: AppColor.blackColor,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (dynamic val) {
                                          controller.updateSelectMap(
                                              val as Map<String, dynamic>);
                                          ageContentViewModel.getAgeList(
                                              controller
                                                  .selectedCategory['name']);

                                          // log('MESSAGE ;- ${controller.selectedValue}');
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Age Group',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade50,
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: controller.selectedAge.isEmpty
                                            ? Text('Select Categories')
                                            : Text(
                                                '${controller.selectedAge['name']}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                        items: controller.ageList
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(
                                                  '${e['name']}',
                                                  style: TextStyle(
                                                    color: AppColor.blackColor,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (dynamic val) {
                                          controller.updateSelectAge(
                                              val as Map<String, dynamic>);

                                          // log('MESSAGE ;- ${controller.selectedValue}');
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Thumbnail',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      controller.setWebImage();
                                      setStat(() {});
                                    },
                                    child: isEdit == true &&
                                            controller.webImage != null
                                        ? Image.memory(controller.webImage!,
                                            fit: BoxFit.fill, width: Get.width)
                                        : isEdit == true
                                            ? Image.network(
                                                '${controller.imageUrl}',
                                                width: Get.width,
                                                height: 100,
                                                fit: BoxFit.fill,
                                              )
                                            : Container(
                                                height: 100,
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade50,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    7,
                                                  ),
                                                ),
                                                alignment: Alignment.center,
                                                child: controller.webImage ==
                                                        null
                                                    ? Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.image,
                                                            color: AppColor
                                                                .mainColor,
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            'Add Thumbnail',
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                              color: AppColor
                                                                  .mainColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    : Image.memory(
                                                        controller.webImage!,
                                                        fit: BoxFit.fill,
                                                        width: Get.width),
                                              ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Age Content',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 380,
                                    child: TextField(
                                      controller:
                                          controller.categoriesController,
                                      decoration: InputDecoration(
                                        border: outlineBorder,
                                        focusedBorder: outlineBorder,
                                        enabledBorder: outlineBorder,
                                        fillColor: Colors.grey.shade50,
                                        filled: true,
                                        contentPadding: const EdgeInsets.only(
                                            top: 5, left: 10),
                                        hintText: 'Add Age Content',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    'Music',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      controller.setAudio();
                                      setStat(() {});
                                    },
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(
                                          7,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (isEdit == true)
                                            Icon(
                                              controller.audioUrl != null ||
                                                      controller.objAudio !=
                                                          null
                                                  ? Icons.done
                                                  : Icons.audio_file,
                                              color: AppColor.mainColor,
                                            ),
                                          if (isEdit == false)
                                            Icon(
                                              controller.objAudio != null
                                                  ? Icons.done
                                                  : Icons.audio_file,
                                              color: AppColor.mainColor,
                                            ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Add Music',
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: AppColor.mainColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text(
                                    'Description',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 100,
                                    width: 380,
                                    child: TextField(
                                      controller:
                                          controller.descriptionController,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                        border: outlineBorder,
                                        focusedBorder: outlineBorder,
                                        enabledBorder: outlineBorder,
                                        fillColor: Colors.grey.shade50,
                                        filled: true,
                                        contentPadding: const EdgeInsets.only(
                                            top: 20, left: 10),
                                        hintText: 'Enter Description',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: controller.isLoading == true
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.teal,
                                              ),
                                            )
                                          : SizedBox(
                                              width: 400,
                                              height: 40,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColor.mainColor,
                                                ),
                                                onPressed: () async {
                                                  controller.setLoading(true);
                                                  setStat(() {});
                                                  if (isEdit == false &&
                                                      controller.webImage !=
                                                          null &&
                                                      controller
                                                          .categoriesController
                                                          .text
                                                          .isNotEmpty &&
                                                      controller
                                                          .selectedCategory
                                                          .isNotEmpty &&
                                                      controller.selectedAge
                                                          .isNotEmpty) {
                                                    {
                                                      String? imageUrl = controller
                                                                  .webImage ==
                                                              null
                                                          ? ''
                                                          : await controller
                                                              .uploadFile(
                                                                  image: controller
                                                                      .webImage,
                                                                  fileName:
                                                                      controller
                                                                          .imageName);
                                                      String AudioUrl = controller
                                                                  .objAudio ==
                                                              null
                                                          ? ''
                                                          : await controller.uploadAudio(
                                                              fileName: controller
                                                                  .objAudioName,
                                                              video: controller
                                                                  .objAudio);
                                                      print(
                                                          'AudioUrl==${AudioUrl}');
                                                      print(
                                                          'ImageUrl==${imageUrl}');

                                                      print(
                                                          'ImageUrl false==${imageUrl}');
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'ageContent')
                                                          .add({
                                                        'categoriesId': controller
                                                                .selectedCategory[
                                                            'id'],
                                                        'categoriesName': controller
                                                                .selectedCategory[
                                                            'name'],
                                                        'ageId': controller
                                                            .selectedAge['id'],
                                                        'ageName': controller
                                                                .selectedAge[
                                                            'name'],
                                                        'ageImage':
                                                            '${imageUrl}',
                                                        'ageContentName': controller
                                                            .categoriesController
                                                            .text,
                                                        'description': controller
                                                            .descriptionController
                                                            .text,
                                                        'addAudio':
                                                            '${AudioUrl}' ?? '',
                                                        'fileName': controller
                                                            .imageName,
                                                      }).whenComplete(() {
                                                        controller
                                                            .setLoading(false);
                                                        setStat(() {});
                                                        Get.back();
                                                        controller
                                                            .clearValues();
                                                      });
                                                    }
                                                  } else if (isEdit == true) {
                                                    String? imageUrl = isEdit ==
                                                                    true &&
                                                                controller
                                                                        .webImage !=
                                                                    null ||
                                                            controller
                                                                    .webImage !=
                                                                null
                                                        ? await controller
                                                            .uploadFile(
                                                                image: controller
                                                                    .webImage,
                                                                fileName:
                                                                    controller
                                                                        .imageName)
                                                        : controller.imageUrl ==
                                                                null
                                                            ? ''
                                                            : controller
                                                                .imageUrl;
                                                    String AudioUrl = isEdit ==
                                                                    true &&
                                                                controller
                                                                        .objAudio !=
                                                                    null ||
                                                            controller
                                                                    .objAudio !=
                                                                null
                                                        ? await controller
                                                            .uploadAudio(
                                                                fileName: controller
                                                                    .objAudioName,
                                                                video: controller
                                                                    .objAudio)
                                                        : controller.audioUrl ==
                                                                null
                                                            ? ""
                                                            : controller
                                                                .audioUrl;

                                                    print(
                                                        'AudioUrl==${AudioUrl}');
                                                    print(
                                                        'ImageUrl dd==${imageUrl}');
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'ageContent')
                                                        .doc(documentId)
                                                        .update({
                                                      'addAudio': '${AudioUrl}',
                                                      'categoriesId': controller
                                                              .selectedCategory[
                                                          'id'],
                                                      'categoriesName': controller
                                                              .selectedCategory[
                                                          'name'],
                                                      'ageId': controller
                                                          .selectedAge['id'],
                                                      'ageName': controller
                                                          .selectedAge['name'],
                                                      'ageImage': '${imageUrl}',
                                                      'ageContentName': controller
                                                          .categoriesController
                                                          .text,
                                                      'description': controller
                                                          .descriptionController
                                                          .text,
                                                      'fileName':
                                                          controller.imageName,
                                                    }).whenComplete(() {
                                                      controller
                                                          .setLoading(false);
                                                      setStat(() {});
                                                      Get.back();
                                                      controller.clearValues();
                                                    });
                                                  } else {
                                                    controller
                                                        .setLoading(false);
                                                    setStat(() {});
                                                    snackBarGet(
                                                      'Add Categories Name',
                                                      snackBarBackGroundColor:
                                                          AppColor.redColor,
                                                    );
                                                  }
                                                },
                                                child: Text(
                                                  isEdit == true
                                                      ? 'Edit'
                                                      : 'Add',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: AppColor.whiteColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
