import 'package:flutter/material.dart';
import 'package:flutter_supabase/Storage/Image_services.dart';
import 'package:flutter_supabase/Storage/storage_services.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class StorageView extends StatefulWidget {
  @override
  _StorageViewState createState() => _StorageViewState();
}

class _StorageViewState extends State<StorageView> {
  final image_controller = Get.find<ImageServices>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pick an Image')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              try {
                await image_controller.pickImages(); // ✅ This fixes your issue
              } catch (e) {
                Get.snackbar('Error', 'Failed to pick images: $e');
              }
            },
            child: Text('Select from Gallery'),
          ),
          Container(
            margin: EdgeInsets.only(left: 32, top: 32),
            child: IconButton(
              onPressed: () => image_controller.clearImages(),
              icon: Icon(Icons.clear),
            ),
          ),
          Obx(() {
            return Wrap(
              children: image_controller.images.map((image) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => image_controller.deleteImageAt(
                          image_controller.images.indexOf(image),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            );
          }),
          ElevatedButton(
            onPressed: () async {
              try {
                await StorageServices()
                    .uploadAllImages(); // ✅ This fixes your issue
              } catch (e) {
                Get.snackbar('Error', 'Failed to pick images: $e');
              }
            },
            child: Text('Upload all images'),
          ),
        ],
      ),
    );
  }
}
