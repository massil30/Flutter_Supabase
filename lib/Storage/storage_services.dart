import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageServices {
  final SupabaseClient client = Supabase.instance.client;

  Future<void> uploadFilesToSupabase(List<File> files) async {
    for (File file in files) {
      try {
        final fileName = path.basename(file.path);
        final fileBytes = await file.readAsBytes();
        final mimeType = lookupMimeType(file.path);

        await client.storage
            .from('xcrop')
            .uploadBinary(
              'images/$fileName',
              fileBytes,
              fileOptions: FileOptions(contentType: mimeType, upsert: true),
            );

        final publicUrl = client.storage
            .from('xcrop')
            .getPublicUrl('images/$fileName');
        print('Uploaded: $publicUrl');
      } catch (e) {
        print('Error uploading ${file.path}: $e');
      }
    }
  }
}
