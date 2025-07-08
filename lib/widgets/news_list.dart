import 'package:flutter/material.dart';
import 'package:hot_news/controllers/news_controller.dart';
import 'package:hot_news/models/article.dart';
import 'package:hot_news/screens/newsdetail.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newsController = Provider.of<NewsController>(
        context,
        listen: false,
      );
      if (newsController.status == NewsStatus.initial ||
          newsController.articles.isEmpty) {
        newsController.fetchTopHeadlinesUS('general');
      }
    });
    super.initState();
  }

  void _selectAticle(BuildContext context, Article article) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => NewsdetailScreen(articledetail: article),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsController>(
      builder: (context, newsController, child) {
        return newsController.status == NewsStatus.loading
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Loading articles...',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: newsController.articles.length,
                itemBuilder: (context, index) {
                  final article = newsController.articles[index];

                  // date formatter
                  String formattedDate = '';
                  try {
                    final dateTime = DateTime.parse(article.publishedAt);

                    if (dateTime.hour < 12) {
                      formattedDate =
                          '${dateTime.day}/${dateTime.month}/${dateTime.year} - ${dateTime.hour}:${dateTime.minute} AM';
                    } else {
                      formattedDate =
                          '${dateTime.day}/${dateTime.month}/${dateTime.year} - ${dateTime.hour - 12}:${dateTime.minute} PM';
                    }
                  } catch (e) {
                    formattedDate = 'Invalid date';
                  }

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10, left: 2, right: 2),
                    color: Colors.white,
                    shadowColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha(50),
                        width: 0.5,
                      ),
                    ),
                    // card content
                    child: InkWell(
                      // onTap to navigate to article details
                      onTap: () => _selectAticle(context, article),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // headline - title
                            Text(
                              article.title!,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),

                            // author and publlished date
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    article.author ?? 'Author Unknown',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ), // Spacing between author and date
                                Text(
                                  formattedDate,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),

                            // Image
                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(8),
                            //   child: article.urlToImage != null
                            //       ? Hero(
                            //         tag: article.publishedAt,
                            //         child: FadeInImage(
                            //           placeholder: MemoryImage(kTransparentImage),
                            //           image: NetworkImage(article.urlToImage!),
                            //           fit: BoxFit.cover,
                            //           width: double.infinity,
                            //         )
                            //       )
                            //       : const SizedBox.shrink(),
                            // ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: article.urlToImage != null
                                  ? Hero(
                                      tag:
                                          "${article.publishedAt}_${article.url}", // Unique tag
                                      child: FadeInImage(
                                        placeholder: const NetworkImage(
                                          'https://nbhc.ca/sites/default/files/styles/article/public/default_images/news-default-image%402x_0.png?itok=B4jML1jF',
                                        ), // Local placeholder
                                        image: NetworkImage(
                                          article.urlToImage!,
                                        ),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                              return Image.network(
                                                'https://nbhc.ca/sites/default/files/styles/article/public/default_images/news-default-image%402x_0.png?itok=B4jML1jF', // Fallback image for errors
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              );
                                            },
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),

                            // description
                            if (article.description != null)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  article.description!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(fontSize: 18),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
