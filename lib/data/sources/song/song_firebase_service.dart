import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify_app/data/model/song/song.dart';
import 'package:spotify_app/domain/entities/song/song.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();

}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];

      var data = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();
      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        songs.add(songModel.toEntity());
      }
      print('Количество песен после парсинга: ${songs.length}');
      return Right(songs);
    } catch (e) {
      print('Ошибка при получении песен: $e');
      return Left('An error occurred, Please try again.');
    }
  }
  
  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];

      var data = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();
      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        songs.add(songModel.toEntity());
      }
      print('Количество песен после парсинга: ${songs.length}');
      return Right(songs);
    } catch (e) {
      print('Ошибка при получении песен: $e');
      return Left('An error occurred, Please try again.');
    }
  }
}
