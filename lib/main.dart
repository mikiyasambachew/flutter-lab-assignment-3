import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/network/album_repository.dart';
import 'view_model/album_bloc.dart';
import 'router/app_router.dart';
import 'package:dio/dio.dart';
import '../data/network/api_client.dart';

void main() {
  runApp(const AlbumApp());
}

class AlbumApp extends StatelessWidget {
  const AlbumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create:
          (_) => AlbumRepository(
            ApiClient(Dio(), baseUrl: "https://jsonplaceholder.typicode.com"),
          ),
      child: BlocProvider(
        create:
            (context) =>
                AlbumBloc(context.read<AlbumRepository>())..add(FetchAlbums()),
        child: MaterialApp.router(routerConfig: router, title: 'Album App'),
      ),
    );
  }
}
