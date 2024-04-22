import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:flutter/foundation.dart';

class TopRatedTVNotifier extends ChangeNotifier {
  final GetTopRatedTvSeries getTopRatedTV;

  TopRatedTVNotifier({required this.getTopRatedTV});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _listtv = [];
  List<Tv> get listtv => _listtv;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTV() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTV.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (listtvData) {
        _listtv = listtvData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
