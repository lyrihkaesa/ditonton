import 'package:flutter_test/flutter_test.dart';
import 'package:search/presentation/bloc/search_bloc.dart';

void main() {
  testWidgets('search event', (tester) async {
    expect(const OnQueryChanged(query: 'aa') != const OnQueryChanged(query: 'lol'), true);
  });
}
