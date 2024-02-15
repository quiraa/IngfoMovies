import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/data/models/detail/detail_movie.dart';
import 'package:flutter_api/data/services/api_service.dart';
import 'package:flutter_api/presentation/constants/app_typography.dart';
import 'package:flutter_api/presentation/helpers/keys.dart';

class DetailPage extends StatefulWidget {
  final String imdbID;
  const DetailPage({Key? key, required this.imdbID}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DetailMovie? detailMovie;

  Future<void> _fetchMovieDetail() async {
    try {
      final api = ApiService(Dio(BaseOptions(contentType: 'application/json')));
      final result = await api.getMovieDetail(Helper.apiKey, widget.imdbID);
      setState(() {
        detailMovie = result;
      });
    } catch (error) {
      print('Error on Detail: ${error}');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMovieDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: detailMovie == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 360,
                    pinned: true,
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.bookmark,
                          color: Colors.amber,
                        ),
                      )
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background: CachedNetworkImage(
                        placeholder: (context, url) {
                          return Container(
                            margin: const EdgeInsets.all(32),
                            child: const CircularProgressIndicator(),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return const Icon(
                            Icons.error,
                            color: Colors.redAccent,
                            size: 48,
                          );
                        },
                        imageUrl: detailMovie?.Poster ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ];
              },
              body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16.0), child: _buildUiInfo()),
              ),
            ),
    );
  }

  Widget _buildUiInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          detailMovie?.Title ?? '',
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Type: ${detailMovie?.Type ?? ''}',
                style: category,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Total Season: ${detailMovie?.totalSeasons ?? ''}',
                style: category,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          detailMovie?.Plot ?? '',
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text.rich(
          TextSpan(
            children: [
              const WidgetSpan(
                child: Icon(
                  Icons.calendar_today,
                  size: 24.0,
                ),
                alignment: PlaceholderAlignment.middle,
              ),
              const WidgetSpan(
                  child: SizedBox(
                width: 16.0,
              )),
              TextSpan(
                text: 'Released: ${detailMovie?.Released ?? ''}',
                style: category,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 24.0,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text.rich(TextSpan(children: [
                const WidgetSpan(
                  child: Icon(Icons.history, size: 24.0),
                  alignment: PlaceholderAlignment.middle,
                ),
                const WidgetSpan(
                    child: SizedBox(
                  width: 16.0,
                )),
                TextSpan(
                  text: 'Runtime: ${detailMovie?.Runtime ?? ''}',
                  style: category,
                )
              ])),
            ),
            const SizedBox(
              width: 24.0,
            ),
            Expanded(
              flex: 1,
              child: Text.rich(
                TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Icon(Icons.movie, size: 24.0),
                      alignment: PlaceholderAlignment.middle,
                    ),
                    const WidgetSpan(
                        child: SizedBox(
                      width: 16.0,
                    )),
                    TextSpan(
                      text: 'Rated: ${detailMovie?.Rated ?? ''}',
                      style: category,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24.0,
        ),
        Text.rich(
          TextSpan(
            children: [
              const WidgetSpan(
                child: Icon(
                  Icons.theater_comedy,
                  size: 24.0,
                ),
                alignment: PlaceholderAlignment.middle,
              ),
              const WidgetSpan(
                  child: SizedBox(
                width: 16.0,
              )),
              TextSpan(
                text: 'Genre: ${detailMovie?.Genre ?? ''}',
                style: category,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 24.0,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text.rich(TextSpan(children: [
                const WidgetSpan(
                  child: Icon(Icons.record_voice_over, size: 24.0),
                  alignment: PlaceholderAlignment.middle,
                ),
                const WidgetSpan(
                    child: SizedBox(
                  width: 16.0,
                )),
                TextSpan(
                  text: 'Director: ${detailMovie?.Director ?? ''}',
                  style: category,
                )
              ])),
            ),
            const SizedBox(
              width: 24.0,
            ),
            Expanded(
              flex: 1,
              child: Text.rich(
                TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Icon(Icons.movie_edit, size: 24.0),
                      alignment: PlaceholderAlignment.middle,
                    ),
                    const WidgetSpan(
                        child: SizedBox(
                      width: 16.0,
                    )),
                    TextSpan(
                      text: 'Writer: ${detailMovie?.Writer ?? ''}',
                      style: category,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24.0,
        ),
        Text.rich(
          TextSpan(
            children: [
              const WidgetSpan(
                child: Icon(
                  Icons.groups,
                  size: 24.0,
                ),
                alignment: PlaceholderAlignment.middle,
              ),
              const WidgetSpan(
                  child: SizedBox(
                width: 16.0,
              )),
              TextSpan(
                text: 'Actors: ${detailMovie?.Actors ?? ''}',
                style: category,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 24.0,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text.rich(TextSpan(children: [
                const WidgetSpan(
                  child: Icon(Icons.public, size: 24.0),
                  alignment: PlaceholderAlignment.middle,
                ),
                const WidgetSpan(
                    child: SizedBox(
                  width: 16.0,
                )),
                TextSpan(
                  text: 'Country: ${detailMovie?.Country ?? ''}',
                  style: category,
                )
              ])),
            ),
            const SizedBox(
              width: 24.0,
            ),
            Expanded(
              flex: 1,
              child: Text.rich(
                TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Icon(Icons.language, size: 24.0),
                      alignment: PlaceholderAlignment.middle,
                    ),
                    const WidgetSpan(
                        child: SizedBox(
                      width: 16.0,
                    )),
                    TextSpan(
                      text: 'Language: ${detailMovie?.Language ?? ''}',
                      style: category,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24.0,
        ),
        Text.rich(
          TextSpan(
            children: [
              const WidgetSpan(
                child: Icon(
                  Icons.military_tech,
                  size: 24.0,
                ),
                alignment: PlaceholderAlignment.middle,
              ),
              const WidgetSpan(
                  child: SizedBox(
                width: 16.0,
              )),
              TextSpan(
                text: 'Awards: ${detailMovie?.Awards ?? ''}',
                style: category,
              )
            ],
          ),
        ),
      ],
    );
  }

  var category = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );
}
