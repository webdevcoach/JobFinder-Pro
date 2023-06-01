//https://cloud.appwrite.io/v1/storage/buckets/
//646d4249e341cea8de82/files/646d43ab19d84481f1a8/view?
//
// project Id [job hunt] project=6469d2c32f8e4b8ceb66&mode=admin

//bucketId[user profie]  646d4249e341cea8de82

import 'dart:io';
import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobhunt_pro/apis/appwrite_injects.dart';
import 'package:jobhunt_pro/constants/appwrite_constant.dart';
import 'package:path_provider/path_provider.dart';

final storageAPIProvider = Provider((ref) {
  return StorageAPI(storage: ref.watch(appwriteStorage));
});

// abstract class StorageInterace {
//   Future<String> uploadImage({required File file});
//   Future<String> uploadCV({required File file});
// }

class StorageAPI {
  final Storage _storage;

  StorageAPI({required Storage storage}) : _storage = storage;
  
  Future<String> uploadFile({required File file, required bool isCv}) async {
    final upload = await _storage.createFile(
      bucketId: isCv? AppWriteConstant.cVBucketId :AppWriteConstant.profileBucketId,
      fileId: ID.unique(),
      file: InputFile.fromPath(path: file.path, filename: file.path),
    );
    return upload.$id;
  }


  Future<String> viewCv({required String fileId}) async {
    Directory tempDir =  await getTemporaryDirectory();
    final cv = File('${tempDir.path}/${Random().nextInt(123)}.pdf');
    final serverPdf = await _storage.getFileDownload(
      bucketId: AppWriteConstant.cVBucketId,
      fileId: fileId,
    );
    final file = await  cv.writeAsBytes(serverPdf);
    return file.path;
  }
}
