import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockTopRatedTvBloc extends MockBloc<TopRatedTvEvent, TopRatedTvState>
    implements TopRatedTvBloc {}

void main() {
  late MockTopRatedTvBloc mockBloc;

  setUp(() {
    mockBloc = MockTopRatedTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    whenListen(mockBloc, Stream.fromIterable([TopRatedTvLoading()]),
        initialState: TopRatedTvLoading());
    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTVPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    whenListen(mockBloc, Stream.fromIterable([const TopRatedTvLoaded([])]),
        initialState: const TopRatedTvLoaded([]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTVPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    whenListen(
        mockBloc, Stream.fromIterable([const TopRatedTvError('Error Message')]),
        initialState: const TopRatedTvError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedTVPage()));

    expect(textFinder, findsOneWidget);
  });
}
