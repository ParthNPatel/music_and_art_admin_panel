import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgeGroupViewModel extends GetxController {
  TextEditingController categoriesController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? imageUrl;
  bool isLoading = false;
  setLoading(bool val) {
    isLoading = val;
    update();
  }

  List<Map<String, dynamic>> categoriesList = [];

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

  String? objAudioName;
  Uint8List? objAudio;
  String? audioUrl;

  setAudio() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      // this will return PlatformFile object with read stream
    );
    if (result != null) {
      audioUrl = null;
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

  Map<String, dynamic> selectedCategory = {};

  updateSelectMap(Map<String, dynamic> value) {
    selectedCategory = value;
    update();
  }

  clearValues() {
    webImage = null;
    imageName = null;
    audioUrl = null;

    categoriesController.clear();
    descriptionController.clear();
    selectedCategory = {};
    imageUrl = null;
    update();
  }
}
