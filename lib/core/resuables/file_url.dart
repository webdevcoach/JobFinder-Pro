class FileUrl {
  static String fileUrl({required String fileId, required bool isCv}) {
    String pdfUrl =
        'https://cloud.appwrite.io/v1/storage/buckets/646d41f0d12ecbc86c43/files/$fileId/view?project=6469d2c32f8e4b8ceb66&mode=admin';

    String imageUrl =
        'https://cloud.appwrite.io/v1/storage/buckets/646d4249e341cea8de82/files/$fileId/view?project=6469d2c32f8e4b8ceb66&mode=admin';
    return isCv ? pdfUrl : imageUrl;
  }
}
