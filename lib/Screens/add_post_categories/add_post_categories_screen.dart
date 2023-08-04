import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_and_art_admin_panel/Widgets/app_color.dart';
import 'package:music_and_art_admin_panel/viewModel/category_view_model.dart';

class AddPostCategoriesScreen extends StatefulWidget {
  const AddPostCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<AddPostCategoriesScreen> createState() =>
      _AddPostCategoriesScreenState();
}

class _AddPostCategoriesScreenState extends State<AddPostCategoriesScreen> {
  CategoryViewModel _categoryViewModel = Get.put(CategoryViewModel());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1489;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColor.bgColor,
        body: GetBuilder<CategoryViewModel>(
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
                            'Categories',
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
                          .collection('category')
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
                                padding:
                                    const EdgeInsets.fromLTRB(0, 12, 10, 12),
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
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        alignment: Alignment.centerLeft,
                                        child: Image.network(
                                          '${data[index]['categoryImage']}',
                                          fit: BoxFit.cover,
                                          width: 150,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${data[index]['categoryName']}",
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
                                              data[index]['categoryName'];
                                          controller.imageUrl =
                                              data[index]['categoryImage'];
                                          controller.imageName =
                                              data[index]['fileName'];
                                          controller.audioUrl =
                                              data[index]['addAudio'];

                                          controller
                                                  .descriptionController.text =
                                              data[index]['description'];
                                        } catch (e) {
                                          print('-----${e}');
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
                                                  .collection('category')
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
        ));
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
            return GetBuilder<CategoryViewModel>(
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
                                            ? 'Edit Categories'
                                            : 'Add Categories',
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
                                    height: 15,
                                  ),
                                  Text(
                                    'Categories',
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
                                        hintText: 'Categories',
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
                                                print('ImageUrl falswwewe==}');
                                                controller.setLoading(true);
                                                setStat(() {});
                                                if (isEdit == false &&
                                                    controller.webImage !=
                                                        null &&
                                                    controller
                                                        .categoriesController
                                                        .text
                                                        .isNotEmpty) {
                                                  String? imageUrl = controller
                                                              .webImage ==
                                                          null
                                                      ? ''
                                                      : await controller
                                                          .uploadFile(
                                                              image: controller
                                                                  .webImage,
                                                              fileName: controller
                                                                  .imageName);

                                                  String AudioUrl = controller
                                                              .objAudio ==
                                                          null
                                                      ? ''
                                                      : await controller.uploadAudio(
                                                              fileName: controller
                                                                  .objAudioName,
                                                              video: controller
                                                                  .objAudio) ??
                                                          '';
                                                  print(
                                                      'AudioUrl==${AudioUrl}');

                                                  print(
                                                      'ImageUrl false==${imageUrl}');
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('category')
                                                      .add({
                                                    'categoryImage':
                                                        '${imageUrl}',
                                                    'categoryName': controller
                                                        .categoriesController
                                                        .text,
                                                    'fileName':
                                                        controller.imageName,
                                                    'description': controller
                                                        .descriptionController
                                                        .text,
                                                    'addAudio':
                                                        '${AudioUrl}' ?? '',
                                                  }).whenComplete(() {
                                                    controller
                                                        .setLoading(false);
                                                    setStat(() {});
                                                    Get.back();
                                                    controller.clearValues();
                                                  });
                                                } else if (isEdit == true) {
                                                  String? imageUrl = isEdit ==
                                                                  true &&
                                                              controller
                                                                      .webImage !=
                                                                  null ||
                                                          controller.webImage !=
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
                                                          : controller.imageUrl;

                                                  String AudioUrl = isEdit ==
                                                                  true &&
                                                              controller
                                                                      .objAudio !=
                                                                  null ||
                                                          controller.objAudio !=
                                                              null
                                                      ? await controller
                                                          .uploadAudio(
                                                              fileName: controller
                                                                  .objAudioName,
                                                              video: controller
                                                                  .objAudio)
                                                      : controller.audioUrl ??
                                                          '';

                                                  print(
                                                      'AudioUrl==${AudioUrl}');

                                                  print(
                                                      'ImageUrl dd==${imageUrl}');
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('category')
                                                      .doc(documentId)
                                                      .update({
                                                    'categoryImage':
                                                        '${imageUrl}',
                                                    'addAudio': '${AudioUrl}',
                                                    'categoryName': controller
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
                                                  print(
                                                      'ImageUrl falswwseeeewe==}');
                                                  controller.setLoading(false);
                                                  setStat(() {});
                                                }
                                              },
                                              child: Text(
                                                isEdit == true ? 'Edit' : 'Add',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: AppColor.whiteColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
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

Future deleteDialog({BuildContext? context, onPress, String? header}) {
  return showDialog(
    context: context!,
    builder: (context) {
      return AlertDialog(
        title: Text(header!),
        actions: [
          TextButton(
            onPressed: onPress,
            child: Text(
              'Yes',
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'No',
            ),
          ),
        ],
      );
    },
  );
}
