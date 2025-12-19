// lib/example/main.dart
// ignore_for_file: avoid_print

import 'package:clean_result/clean_result.dart';

void main() async {
  final Result<int> result = await ApiExecutor.execute(apiCall: () async => 10);

  result.fold(
    onSuccess: (value) {
      print('Success: $value');
    },
    onFailure: (message) {
      print('Failure: $message');
    },
  );
}
