import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/album_bloc.dart';
import '../../data/models/album_model.dart';
import 'package:go_router/go_router.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumLoaded) {
            return ListView.builder(
              itemCount: state.albums.length,
              itemBuilder: (context, index) {
                Album album = state.albums[index];
                return ListTile(
                  title: Text(album.title),
                  onTap: () {
                    // We'll implement detail navigation next
                    context.pushNamed(
                      'albumDetail',
                      pathParameters: {'id': album.id.toString()},
                      extra: album,
                    );
                  },
                );
              },
            );
          } else if (state is AlbumError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
