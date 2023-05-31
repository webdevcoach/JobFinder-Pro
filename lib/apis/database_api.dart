import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:jobhunt_pro/constants/appwrite_constant.dart';
import 'package:jobhunt_pro/core/failure.dart';
import 'package:jobhunt_pro/core/type_def.dart';
import 'package:jobhunt_pro/model/apply_job.dart';
import 'package:jobhunt_pro/model/applicant.dart';
import 'package:jobhunt_pro/model/recruiter.dart';
import 'package:jobhunt_pro/model/post_job.dart';
import 'appwrite_injects.dart';

final databaseAPIProvider = Provider((ref) {
  return DatabaseAPI(databases: ref.watch(appwriteDatabaseProvider));
});

abstract class DataBaseInterface {
  FutureEither<Document> saveRecruiterDetails({
    required Recruiter recruiter,
    required String id,
  });
  FutureEither<Document> saveApplicantDetails({
    required Applicant applicant,
    required String id,
  });
  FutureEither<Document> postJob({required PostJob jobDetails});
  FutureEither<Document> applyJob({required ApplyJob applyJob});
  Future<Document> getApplicantProfile({required String id});
  Future<Document> getRecruiterProfile({required String id});
  FutureEither<Document> updateJobWithApplicationId({required PostJob job});
  FutureEither<Document> updateApplicantProfileWithJobId({
    required Applicant applicant,
  });
  FutureEither<Document> addJobIdToRecruiterProfile({
    required Recruiter recruiter,
  });
  Future<List<Document>> getPostedJobs();
  Future<Document> myPostedJobs({required String jobId});
   Future<Document> getAppliedApplicants({required String applicationId});
}

class DatabaseAPI implements DataBaseInterface {
  final Databases _databases;

  DatabaseAPI({required Databases databases}) : _databases = databases;
  @override
  FutureEither<Document> applyJob({required ApplyJob applyJob}) async {
    try {
      final post = await _databases.createDocument(
        databaseId: AppWriteConstant.jobDatabaseId,
        collectionId: AppWriteConstant.appliedJobCollectionId,
        documentId: ID.custom(applyJob.applicationId),
        data: applyJob.toMap(),
      );
      return right(post);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
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
  FutureEither<Document> saveApplicantDetails({
    required Applicant applicant,
    required String id,
  }) async {
    try {
      final saveRecruiter = await _databases.createDocument(
        databaseId: AppWriteConstant.usersDatabaseId,
        collectionId: AppWriteConstant.applicantCollectionId,
        documentId: ID.custom(id),
        data: applicant.toMap(),
      );
      return right(saveRecruiter);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  FutureEither<Document> saveRecruiterDetails({
    required Recruiter recruiter,
    required String id,
  }) async {
    try {
      final saveRecruiter = await _databases.createDocument(
        databaseId: AppWriteConstant.usersDatabaseId,
        collectionId: AppWriteConstant.recruiterCollectionId,
        documentId: ID.custom(id),
        data: recruiter.toMap(),
      );
      return right(saveRecruiter);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  Future<Document> getApplicantProfile({
    required String id,
  }) async {
    final details = await _databases.getDocument(
      databaseId: AppWriteConstant.usersDatabaseId,
      collectionId: AppWriteConstant.applicantCollectionId,
      documentId: id,
    );
    return details;
  }

  @override
  Future<Document> getRecruiterProfile({required String id}) async {
    final details = await _databases.getDocument(
      databaseId: AppWriteConstant.usersDatabaseId,
      collectionId: AppWriteConstant.recruiterCollectionId,
      documentId: id,
    );
    return details;
  }

  @override
  Future<List<Document>> getPostedJobs() async {
    final jobs = await _databases.listDocuments(
      databaseId: AppWriteConstant.jobDatabaseId,
      collectionId: AppWriteConstant.postedJobCollectionId,
      // queries: ['time']
    );
    return jobs.documents;
  }

  @override
  FutureEither<Document> updateApplicantProfileWithJobId({
    required Applicant applicant,
  }) async {
    try {
      final update = await _databases.updateDocument(
        databaseId: AppWriteConstant.usersDatabaseId,
        collectionId: AppWriteConstant.applicantCollectionId,
        documentId: applicant.id,
        data: {'appliedJobs': applicant.appliedJobs},
      );
      return right(update);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  FutureEither<Document> updateJobWithApplicationId({
    required PostJob job,
  }) async {
    try {
      final update = await _databases.updateDocument(
        databaseId: AppWriteConstant.jobDatabaseId,
        collectionId: AppWriteConstant.postedJobCollectionId,
        documentId: job.jobId,
        data: {'applicationReceived': job.applicationReceived},
      );
      return right(update);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  FutureEither<Document> addJobIdToRecruiterProfile({
    required Recruiter recruiter,
  }) async {
    try {
      final addJobId = await _databases.updateDocument(
          databaseId: AppWriteConstant.usersDatabaseId,
          collectionId: AppWriteConstant.recruiterCollectionId,
          documentId: recruiter.id,
          data: {'postedJobs': recruiter.postedJobs});
      return right(addJobId);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }
  
  @override
  Future<Document> myPostedJobs({required String jobId}) async{
    final myJob =  await _databases.getDocument(
      databaseId: AppWriteConstant.jobDatabaseId, 
      collectionId: AppWriteConstant.postedJobCollectionId, 
      documentId: jobId,
      );
      return myJob;
  }
  
  @override
  Future<Document> getAppliedApplicants({required String applicationId}) async{
     final myJob =  await _databases.getDocument(
      databaseId: AppWriteConstant.jobDatabaseId, 
      collectionId: AppWriteConstant.appliedJobCollectionId, 
      documentId: applicationId,
      );
      return myJob;
  }
}
