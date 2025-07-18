import 'dart:io';

import 'package:flutter_supabase/Storage/Image_services.dart';

class StorageServices extends ImageServices {
  Future<void> uploadAllImages() async {
    // Await the compressed images list
    List<File> compressedImages = await compressImageList();

    // Upload each compressed image
    for (var image in compressedImages) {
      // Implement your upload logic here
      print('Uploading ${image.path}');
    }
  }
}
