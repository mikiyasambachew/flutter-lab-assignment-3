import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/album_model.dart';
import '../../data/models/photo_model.dart';
import '../../data/network/album_repository.dart';
import '../../view_model/photo_bloc/photo_bloc.dart';
import '../../view_model/photo_bloc/photo_event.dart';
import '../../view_model/photo_bloc/photo_state.dart';

class AlbumDetailScreen extends StatefulWidget {
  final Album album;
  final AlbumRepository repository;

  const AlbumDetailScreen({
    super.key,
    required this.album,
    required this.repository,
  });

  @override
  State<AlbumDetailScreen> createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  late PhotoBloc _photoBloc;

  @override
  void initState() {
    super.initState();
    _photoBloc = PhotoBloc(widget.repository);
    _photoBloc.add(FetchPhotos(widget.album.id));
  }

  @override
  void dispose() {
    _photoBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _photoBloc,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.album.title)),
        body: BlocBuilder<PhotoBloc, PhotoState>(
          builder: (context, state) {
            if (state is PhotoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PhotoLoaded) {
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: state.photos.length,
                itemBuilder: (context, index) {
                  Photo photo = state.photos[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.network(
                          photo.thumbnailUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        photo.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  );
                },
              );
            } else if (state is PhotoError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
