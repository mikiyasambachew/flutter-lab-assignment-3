import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/photo_model.dart';
import '../../data/network/album_repository.dart';
import 'photo_event.dart';
import 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final AlbumRepository repository;

  PhotoBloc(this.repository) : super(PhotoInitial()) {
    on<FetchPhotos>((event, emit) async {
      emit(PhotoLoading());
      try {
        final photos = await repository.getPhotos(event.albumId);
        emit(PhotoLoaded(photos));
      } catch (e) {
        emit(PhotoError("Failed to load photos: $e"));
      }
    });
  }
}
