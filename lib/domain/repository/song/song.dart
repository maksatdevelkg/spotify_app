import 'package:dartz/dartz.dart';

abstract class SongsRepository {

  Future <Either> getNewsSongs();
  Future <Either> getPlayList();
}