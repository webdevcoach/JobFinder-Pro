import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PickImage {
 static Future<File> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return File(image!.path);
  }
}
