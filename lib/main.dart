import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/search_bloc.dart';
import 'package:ditonton/presentation/bloc/search_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/home_tv_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/search_tv_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'presentation/pages/about_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<SearchBloc>()),
        BlocProvider(create: (context) => di.locator<NowPlayingMoviesBloc>()),
        BlocProvider(create: (context) => di.locator<PopularMoviesBloc>()),
        BlocProvider(create: (context) => di.locator<TopRatedMoviesBloc>()),
        BlocProvider(create: (context) => di.locator<MovieDetailBloc>()),
        BlocProvider(
            create: (context) => di.locator<MovieRecommendationBloc>()),
        BlocProvider(create: (context) => di.locator<MovieWatchlistBloc>()),
        BlocProvider(create: (context) => di.locator<SearchTvBloc>()),
        BlocProvider(create: (context) => di.locator<PopularTvBloc>()),
        BlocProvider(create: (context) => di.locator<NowPlayingTvBloc>()),
        BlocProvider(create: (context) => di.locator<TopRatedTvBloc>()),
        BlocProvider(create: (context) => di.locator<TvDetailBloc>()),
        BlocProvider(create: (context) => di.locator<TvRecommendationBloc>()),
        BlocProvider(create: (context) => di.locator<TvWatchlistBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomeTVPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case HomeTVPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const HomeTVPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case PopularTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const PopularTVPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case TopRatedTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const TopRatedTVPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TVDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case SearchTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const SearchTVPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistMoviesPage());
            case WatchlistTVPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const WatchlistTVPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
