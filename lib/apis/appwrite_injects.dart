

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clientProvider = Provider((ref) {
  Client client = Client(endPoint: '', selfSigned: true);
  return client;
});

final authProvider = Provider((ref) {
  return  Account(ref.watch(clientProvider));
});