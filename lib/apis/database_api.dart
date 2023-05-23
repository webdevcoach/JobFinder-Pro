import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:jobhunt_pro/constants/appwrite_constant.dart';
import 'package:jobhunt_pro/core/failure.dart';
import 'package:jobhunt_pro/core/type_def.dart';
import 'package:jobhunt_pro/model/apply_job.dart';
import 'package:jobhunt_pro/model/employee.dart';
import 'package:jobhunt_pro/model/employer.dart';
import 'package:jobhunt_pro/model/post_job.dart';

import 'appwrite_injects.dart';

final databaseAPIProvider = Provider((ref) {
  return DatabaseAPI(databases: ref.watch(appwriteDatabaseProvider));
});

abstract class DataBaseInterface {
  FutureEither<Document> saveEmployerDetails({
    required Employer employer,
    required String id,
  });
  FutureEither<Document> saveEmployeeDetails({
    required Employee employee,
    required String id,
  });
  FutureEither<Document> postJob({required PostJob jobDetails});
  FutureEither<Document> applyJob({required ApplyJob applyJob});
  Future<Document> getEmployeeProfile({required String id});
  Future<Document> getEmployerProfile({required String id});
}

class DatabaseAPI implements DataBaseInterface {
  final Databases _databases;

  DatabaseAPI({required Databases databases}) : _databases = databases;
  @override
  FutureEither<Document> applyJob({required ApplyJob applyJob}) {
    // TODO: implement applyJob
    throw UnimplementedError();
  }

  @override
  FutureEither<Document> postJob({required PostJob jobDetails}) async {
    try {
      final post = await _databases.createDocument(
        databaseId: AppWriteConstant.jobDatabaseId,
        collectionId: AppWriteConstant.postedJobCollectionId,
        documentId: ID.unique(),
        data: jobDetails.toMap(),
      );
      return right(post);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  FutureEither<Document> saveEmployeeDetails({
    required Employee employee,
    required String id,
  }) async {
    try {
      final saveEmployer = await _databases.createDocument(
        databaseId: AppWriteConstant.usersDatabaseId,
        collectionId: AppWriteConstant.employeesCollectionId,
        documentId: ID.custom(id),
        data: employee.toMap(),
      );
      return right(saveEmployer);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  FutureEither<Document> saveEmployerDetails({
    required Employer employer,
    required String id,
  }) async {
    try {
      final saveEmployer = await _databases.createDocument(
        databaseId: AppWriteConstant.usersDatabaseId,
        collectionId: AppWriteConstant.employersCollectionId,
        documentId: ID.custom(id),
        data: employer.toMap(),
      );
      return right(saveEmployer);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  Future<Document> getEmployeeProfile({
    required String id,
  }) async {
    final details = await _databases.getDocument(
      databaseId: AppWriteConstant.usersDatabaseId,
      collectionId: AppWriteConstant.employeesCollectionId,
      documentId: id,
    );
    return details;
  }

  @override
  Future<Document> getEmployerProfile({required String id})async {
   final details = await _databases.getDocument(
      databaseId: AppWriteConstant.usersDatabaseId,
      collectionId: AppWriteConstant.employersCollectionId,
      documentId: id,
    );
    return details;
  }
}
