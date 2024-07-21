import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MovieCard should display movie details correctly',
      (WidgetTester tester) async {
    // Arrange
    final movie = Movie(
      adult: false,
      backdropPath: '/testBackdropPath.jpg',
      genreIds: const [1, 2, 3],
      id: 1,
      originalTitle: 'Original Test Movie',
      overview: 'This is a test movie overview.',
      popularity: 123.456,
      posterPath: '/testPosterPath.jpg',
      releaseDate: '2021-01-01',
      title: 'Test Movie',
      video: false,
      voteAverage: 7.8,
      voteCount: 1000,
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MovieCard(movie),
        ),
      ),
    );

    // Assert
    expect(find.text('Test Movie'), findsOneWidget);
    expect(find.text('This is a test movie overview.'), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
  });

  testWidgets('MovieCard should navigate to MovieDetailPage on tap',
      (WidgetTester tester) async {
    // Arrange
    final movie = Movie(
      adult: false,
      backdropPath: '/testBackdropPath.jpg',
      genreIds: const [1, 2, 3],
      id: 1,
      originalTitle: 'Original Test Movie',
      overview: 'This is a test movie overview.',
      popularity: 123.456,
      posterPath: '/testPosterPath.jpg',
      releaseDate: '2021-01-01',
      title: 'Test Movie',
      video: false,
      voteAverage: 7.8,
      voteCount: 1000,
    );

    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/detail': (context) =>
              Scaffold(appBar: AppBar(title: const Text('Movie Detail'))),
        },
        home: Scaffold(
          body: MovieCard(movie),
        ),
      ),
    );

    // Act
    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    // Assert
    expect(find.text('Movie Detail'), findsOneWidget);
  });
}
