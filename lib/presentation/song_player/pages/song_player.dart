import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/common/appbar/app_bar.dart';
import 'package:spotify_app/common/helpers/is_dark_mode.dart';
import 'package:spotify_app/core/configs/constants/app_urls.dart';
import 'package:spotify_app/core/configs/theme/app_colors.dart';
import 'package:spotify_app/domain/entities/song/song.dart';
import 'package:spotify_app/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify_app/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({
    Key? key,
    required this.songEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioFile =
        Uri.encodeComponent('${songEntity.artist} - ${songEntity.title}.mp3');
    final audioUrl = '${AppURLs.songFirestorage}$audioFile?${AppURLs.mediaAlt}';
    return Scaffold(
      appBar: BasicAppbar(
        title: Text(
          'Now playing',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        action:
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()..loadSong(audioUrl),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              _songCover(context),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: _songDetail(),
              ),
              SizedBox(
                height: 30,
              ),
              _songPlayer(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    final fileName =
        Uri.encodeComponent('${songEntity.artist} - ${songEntity.title}.jpg');
    final imageUrl = '${AppURLs.coverFirestorage}$fileName?${AppURLs.mediaAlt}';
    return Container(
      height: MediaQuery.of(context).size.height / 2.4,
      width: MediaQuery.of(context).size.width / 1.2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(imageUrl))),
    );
  }

  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              songEntity.artist,
              style:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            ),
          ],
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_outline_outlined,
              size: 24,
              color: AppColors.darkGrey,
            ))
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
        builder: (context, state) {
      if (state is SongPlayerLoading) {
        return CircularProgressIndicator();
      }
      if (state is SongPlayerLoaded) {
        return Column(
          children: [
            Slider(
                activeColor: Color(0xffB7B7B7),
                value: context
                    .read<SongPlayerCubit>()
                    .songPosition
                    .inSeconds
                    .toDouble(),
                min: 0.0,
                max: context
                    .read<SongPlayerCubit>()
                    .songDuration
                    .inSeconds
                    .toDouble(),
                onChanged: (value) {}),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(
                        context.read<SongPlayerCubit>().songPosition),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: context.isDarkMode
                            ? Color(0xff878787)
                            : Color(0xff404040)),
                  ),
                  Text(
                      formatDuration(
                          context.read<SongPlayerCubit>().songDuration),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: context.isDarkMode
                              ? Color(0xff878787)
                              : Color(0xff404040)))
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                context.read<SongPlayerCubit>().playOrPauseSong();
              },
              child: Container(
                height: 72,
                width: 72,
                child: Icon(context.read<SongPlayerCubit>().audioPlayer.playing
                    ? Icons.pause
                    : Icons.play_arrow),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.primary),
              ),
            )
          ],
        );
      }
      return Container();
    });
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
