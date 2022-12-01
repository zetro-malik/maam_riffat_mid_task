import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImgPicker {
  static Future<dynamic> fromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    }
    final tempImg = File(image.path);
    return tempImg;

    //check is tempImg is null/not

    // setState(() {
    //   _image = tempImg;
    // });
  }

  static Future<dynamic> fromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    final tempImg = File(image.path);
    return tempImg;
  }
}
