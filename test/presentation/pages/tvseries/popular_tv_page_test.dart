import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/popular_tv_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockPopularTvBloc extends MockBloc<PopularTvEvent, PopularTvState>
    implements PopularTvBloc {}

void main() {
  late MockPopularTvBloc mockBloc;

  setUp(() {
    mockBloc = MockPopularTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    whenListen(mockBloc, Stream.fromIterable([PopularTvLoading()]),
        initialState: PopularTvLoading());
    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const PopularTVPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    whenListen(mockBloc, Stream.fromIterable([const PopularTvLoaded([])]),
        initialState: const PopularTvLoaded([]));
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularTVPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    whenListen(
        mockBloc, Stream.fromIterable([const PopularTvError('Error Message')]),
        initialState: const PopularTvError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const PopularTVPage()));

    expect(textFinder, findsOneWidget);
  });
}
