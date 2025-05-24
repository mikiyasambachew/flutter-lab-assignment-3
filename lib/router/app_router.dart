import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../view/screens/album_list_screen.dart';
import '../view/screens/album_detail_screen.dart';
import '../data/models/album_model.dart';
import '../data/network/api_client.dart';
import '../data/network/album_repository.dart';
import 'package:dio/dio.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AlbumListScreen()),
    GoRoute(
      path: '/album/:id',
      name: 'albumDetail',
      builder: (context, state) {
        final album = state.extra as Album;
        return AlbumDetailScreen(
          album: album,
          repository: AlbumRepository(
            ApiClient(
              Dio(), // Positional Dio parameter
              baseUrl:
                  "https://jsonplaceholder.typicode.com", // Named parameter
            ),
          ),
        );
      },
    ),
  ],
);
