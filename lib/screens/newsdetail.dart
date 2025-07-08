import 'package:flutter/material.dart';
import 'package:hot_news/models/article.dart';
import 'package:transparent_image/transparent_image.dart';

class NewsdetailScreen extends StatelessWidget {
  const NewsdetailScreen({super.key, required this.articledetail});

  final Article articledetail;

  @override
  Widget build(BuildContext context) {
    // date formatter
    String formattedDate = '';
    try {
      final dateTime = DateTime.parse(articledetail.publishedAt);

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

    return Scaffold(
      appBar: AppBar(title: Text('Read the news here..')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            // image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: articledetail.urlToImage != null
                  ? Hero(
                      tag:
                          "${articledetail.publishedAt}_${articledetail.url}", // Unique tag
                      child: FadeInImage(
                        placeholder: const NetworkImage(
                          'https://nbhc.ca/sites/default/files/styles/article/public/default_images/news-default-image%402x_0.png?itok=B4jML1jF',
                        ), // Local placeholder
                        image: NetworkImage(articledetail.urlToImage!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        imageErrorBuilder: (context, error, stackTrace) {
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

            const SizedBox(height: 10),

            // author and publlished date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    articledetail.author ?? 'Author Unknown',
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(width: 15), // Spacing between author and date
                Text(
                  formattedDate,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),

            const SizedBox(height: 10),
            // headline - title
            Text(
              articledetail.title!,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            // article content detail
            Text(
              articledetail.content ?? 'no content here',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontSize: 18),
            ),

            // see more text that have the url
            // if (articledetail.url != null)
            //   TextButton(
            //     onPressed: () {
            //       // Open the URL in a web browser
            //       if (articledetail.url != null) {
            //         launchUrl(Uri.parse(articledetail.url!));
            //       }
            //     },
            //     child: Text(
            //       'See more',
            //       style: TextStyle(color: Theme.of(context).colorScheme.primary),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
