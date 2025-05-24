import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/album_model.dart';
import '../models/photo_model.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class ApiClient {
  factory ApiClient(
    Dio dio, { // Positional parameter (required)
    String? baseUrl, // Named parameter (optional)
    ParseErrorLogger? errorLogger, // Named parameter (optional)
  }) = _ApiClient;

  @GET("/albums")
  Future<List<Album>> getAlbums();

  @GET("/photos")
  Future<List<Photo>> getPhotos(@Query("albumId") int albumId);
}
