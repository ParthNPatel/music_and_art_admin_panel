import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashBoardViewModel extends GetxController {
  bool isLoading = false;
  updateLoader(bool value) {
    isLoading = value;
    update();
  }

  List categories = [];
  List video = [];

  getCategoriesList() async {
    updateLoader(true);
    try {
      var getData =
          await FirebaseFirestore.instance.collection('category').get();
      var getVData = await FirebaseFirestore.instance.collection('video').get();
      categories.clear();
      video.clear();
      getData.docs.forEach((element) {
        categories.add(element);
      });
      getVData.docs.forEach((element) {
        video.add(element);
      });
      updateLoader(false);
    } catch (e) {
      updateLoader(false);
    }
    print('GET video=== ${video}');

    print('GET categories=== ${categories}');
    update();
  }
}
