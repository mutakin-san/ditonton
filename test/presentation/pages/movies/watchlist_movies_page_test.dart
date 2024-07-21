import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockMovieWatchlistBloc
    extends MockBloc<MovieWatchlistEvent, MovieWatchlistState>
    implements MovieWatchlistBloc {}

void main() {
  late MockMovieWatchlistBloc mockWatchlistMoviesBloc;

  setUpAll(() {
    mockWatchlistMoviesBloc = MockMovieWatchlistBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieWatchlistBloc>.value(
      value: mockWatchlistMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    whenListen(
        mockWatchlistMoviesBloc, Stream.fromIterable([MovieWatchlisLoading()]),
        initialState: MovieWatchlisLoading());
    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    whenListen(mockWatchlistMoviesBloc,
        Stream.fromIterable([const MovieWatchlisLoaded(watchlistMovies: [])]),
        initialState: const MovieWatchlisLoaded(watchlistMovies: []));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
     whenListen(mockWatchlistMoviesBloc,
        Stream.fromIterable([const MovieWatchListError(message: 'Error Message')]),
        initialState: const MovieWatchListError(message: 'Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
