import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';

import '../repositories/tv_repository.dart';

class GetNowPlayingTvSeries {
  GetNowPlayingTvSeries(this.repository);

  final TVRepository repository;

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowPlayingTv();
  }
}
