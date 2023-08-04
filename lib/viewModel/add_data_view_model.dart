import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDataViewModel extends GetxController {
  TextEditingController categoriesController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? imageUrl;
  String? videoUrl;
  String? audioUrl;
  Uint8List? objVideo;
  String? objVideoName;
  String? objAudioName;
  Uint8List? objAudio;
  bool isLoading = false;
  setLoading(bool val) {
    isLoading = val;
    update();
  }

  List<Map<String, dynamic>> categoriesList = [];
  List<Map<String, dynamic>> ageList = [];
  List<Map<String, dynamic>> ageContentList = [];

  getCategoriesList() async {
    var getData = await FirebaseFirestore.instance.collection('category').get();
    categoriesList.clear();
    getData.docs.forEach((element) {
      categoriesList.add({
        'name': element['categoryName'],
        'id': element.id,
      });
    });
    print('GET DATA=== ${categoriesList}');
    update();
  }

  getAgeList(String categories) async {
    var getData = await FirebaseFirestore.instance.collection('ageGroup').get();
    ageList.clear();
    getData.docs.forEach((element) {
      // if (element['categoriesName'] == categories) {
      ageList.add({
        'name': element['ageName'],
        'id': element.id,
      });
      // }
    });
    print('GET DATA=== ${ageList}');
    update();
  }

  getAgeContentList(String ageName) async {
    var getData =
        await FirebaseFirestore.instance.collection('ageContent').get();
    ageContentList.clear();
    getData.docs.forEach((element) {
      if (element['ageName'] == ageName) {
        ageContentList.add({
          'name': element['ageContentName'],
          'id': element.id,
        });
      }
    });
    print('GET DATA=== ${ageContentList}');
    update();
  }

  Uint8List? webImage;
  String? imageName;

  setWebImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      webImage = await result.files.single.bytes;
      imageName = await result.files.first.name;
      // webImage =
      log('WEB IMAGE 1:- $webImage');
      log('WEB IMAGE 1 Length:- ${result.files.first.name}');
      log('WEB IMAGE 2:- $result');
      update();
    }
  }

  Future<String> uploadFile({Uint8List? image, String? fileName}) async {
    String finalImage = '';

    String getUrl = "Images/${fileName}";
    var task = FirebaseStorage.instance.ref().child(getUrl);

    await task
        .putData(image!, SettableMetadata(contentType: 'image/jpeg'))
        .then((p0) async {
      finalImage = await p0.storage.ref(getUrl).getDownloadURL();
    });
    return finalImage;
  }

  Map<String, dynamic> selectedCategory = {};
  Map<String, dynamic> selectedAge = {};
  Map<String, dynamic> selectedAgeContent = {};

  updateSelectMap(Map<String, dynamic> value) {
    selectedCategory = value;
    update();
  }

  updateSelectAge(Map<String, dynamic> value) {
    selectedAge = value;
    update();
  }

  updateSelectAgeContent(Map<String, dynamic> value) {
    selectedAgeContent = value;
    update();
  }

  setVideo() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.video,
// this will return PlatformFile object with read stream
    );
    if (result != null) {
      objVideo = await result.files.single.bytes;
      objVideoName = result.files.single.name;
      print('VIDEO URL == ${objVideo}');
      print('objVideoName URL == ${objVideoName}');
    }
    update();
  }

  Future<String> uploadVideoFile({Uint8List? video, String? fileName}) async {
    String finalVideo = '';

    String getUrl = "Videos/${fileName}";
    var task = FirebaseStorage.instance.ref().child(getUrl);

    await task
        .putData(video!, SettableMetadata(contentType: 'video/mp4'))
        .then((p0) async {
      finalVideo = await p0.storage.ref(getUrl).getDownloadURL();
    });
    return finalVideo;
  }

  setAudio() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      // this will return PlatformFile object with read stream
    );
    if (result != null) {
      objAudio = await result.files.single.bytes;
      objAudioName = result.files.single.name;

      print('objAudio URL == ${objAudio}');
      print('objAudioName URL == ${objAudioName}');
    }
    update();
  }

  uploadAudio({Uint8List? video, String? fileName}) async {
    String finalAudio = '';

    String getUrl = "Audio/${fileName}";
    var task = FirebaseStorage.instance.ref().child(getUrl);

    await task
        .putData(video!, SettableMetadata(contentType: 'Audio/mp3'))
        .then((p0) async {
      finalAudio = await p0.storage.ref(getUrl).getDownloadURL();
    });
    return finalAudio;
  }

  clearValues() {
    webImage = null;
    imageName = null;
    categoriesController.clear();
    selectedCategory = {};
    selectedAgeContent = {};
    selectedAge = {};
    objVideo = null;
    objVideoName = null;
    objAudioName = null;
    objAudio = null;
    imageUrl = null;
    update();
  }
}
