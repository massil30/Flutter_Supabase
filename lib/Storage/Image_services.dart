import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageServices extends GetxController {
  // Observable list of images
  RxList<File> images = <File>[].obs;

  // Pick multiple images
  Future<void> pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? selectedImages = await _picker.pickMultiImage();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      List<File> files =
          selectedImages!.map((xfile) => File(xfile.path)).toList();

      images.assignAll(files);
    }
  }

  // Clear images
  void clearImages() {
    images.clear();
  }

  // Delete image at a specific index
  void deleteImageAt(int index) {
    images.removeAt(index);
  }

  Future<File> _compressImage(File file) async {
    final compressed = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, '${file.path}_compressed.jpg',
      quality: 70, // Adjust quality (0-100)
    );
    return File(compressed!.path);
  }

  // Compress the whole list of images and replace them
  Future<List<File>> compressImageList() async {
    List<File> compressedImages = [];

    for (File file in images) {
      File compressed = await _compressImage(file);
      compressedImages.add(compressed);
    }

    images.assignAll(
        compressedImages); // Update the observable list with compressed images
    return compressedImages;
  }
}
