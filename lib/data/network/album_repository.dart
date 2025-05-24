import 'package:album_app/data/models/album_model.dart';
import 'package:album_app/data/network/api_client.dart';
import '../models/photo_model.dart';

class AlbumRepository {
  final ApiClient _apiClient;

  // ✅ Constructor that accepts ApiClient as a parameter
  AlbumRepository(this._apiClient);

  Future<List<Album>> getAlbums() async {
    return await _apiClient.getAlbums();
  }

  Future<List<Photo>> getPhotos(int albumId) async {
    return await _apiClient.getPhotos(albumId);
  }
}
