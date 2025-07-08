import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hot_news/controllers/news_controller.dart';
import 'package:hot_news/models/article.dart';
import 'package:provider/provider.dart';

class OnboardImage extends StatefulWidget {
  const OnboardImage({super.key});

  @override
  State<OnboardImage> createState() => _OnboardImageState();
}

class _OnboardImageState extends State<OnboardImage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsController>(context, listen: false).fetchTopHeadlinesUS('general');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Center(child: const Text('Image'));
    return Consumer<NewsController>(
      builder: (context, newsController, child) {
        if (newsController.status == NewsStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (newsController.status == NewsStatus.error) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Failed to load images: ${newsController.errorMessage} \n Tap to retry',
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else if (newsController.articles.isEmpty) {
          return const Center(child: Text('No news images available'));
        } else {
          final List<Article> articlesWithImages = newsController.articles
              .where(
                (article) =>
                    article.urlToImage != null &&
                    article.urlToImage!.isNotEmpty,
              )
              .toList();

          if (articlesWithImages.isEmpty) {
            return const Center(child: Text('No images to display.'));
          }

          return CarouselSlider.builder(
            itemCount: articlesWithImages.length,
            itemBuilder: (context, index, realIndex) {
              final article = articlesWithImages[index];
              return ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
                child: Image.network(
                  article.urlToImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              enlargeCenterPage: true,
              viewportFraction: 0.95,
              aspectRatio: 9/16,
              autoPlayCurve: Curves.fastEaseInToSlowEaseOut
            ),
          );
        }
      },
    );
  }
}
