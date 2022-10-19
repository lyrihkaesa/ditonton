import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_season_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_season_detail_tv.dart';
import 'package:flutter/cupertino.dart';

class TVSeasonDetailNotifier extends ChangeNotifier {
  final GetSeasonDetailTV getSeasonDetailTV;

  TVSeasonDetailNotifier({
    required this.getSeasonDetailTV,
  });

  late TVSeasonDetail _tvSeasonDetail;
  TVSeasonDetail get tvSeasonDetail => _tvSeasonDetail;

  RequestState _tvSeasonDetailState = RequestState.Empty;
  RequestState get tvSeasonDetailState => _tvSeasonDetailState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTVSeasonDetail(int id, int seasonNumber) async {
    _tvSeasonDetailState = RequestState.Loading;
    notifyListeners();
    final result = await getSeasonDetailTV.execute(id, seasonNumber);
    result.fold(
      (failure) {
        _tvSeasonDetailState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeasonDetail) {
        _tvSeasonDetail = tvSeasonDetail;
        notifyListeners();
        _tvSeasonDetailState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
