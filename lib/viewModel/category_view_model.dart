import 'dart:developer';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryViewModel extends GetxController {
  TextEditingController categoriesController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? imageUrl;
  String? audioUrl;
  bool isLoading = false;
  setLoading(bool val) {
    isLoading = val;
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

  clearValues() {
    webImage = null;
    imageName = null;
    categoriesController.clear();
    descriptionController.clear();
    imageUrl = null;
    audioUrl = null;
    update();
  }
}
