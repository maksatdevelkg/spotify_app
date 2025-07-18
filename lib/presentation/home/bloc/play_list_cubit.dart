import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/domain/usecases/song/get_news_songs.dart';
import 'package:spotify_app/domain/usecases/song/get_play_list.dart';
import 'package:spotify_app/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify_app/presentation/home/bloc/play_list_state.dart';
import 'package:spotify_app/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    var returnedSongs = await sl <GetPlayListUseCase>().call();

    returnedSongs.fold(
      (l) {
      emit(PlayListLoadFailure());
    }, (data) {
      emit(PlayListLoaded(songs: data));
    });
  }
}
