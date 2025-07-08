import 'package:flutter/material.dart';
import 'package:hot_news/controllers/news_controller.dart';
import 'package:hot_news/widgets/news_list.dart';
import 'package:hot_news/widgets/search_box.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<String> categories = const [
    'sports',
    'science',
    'entertainment',
    'general',
    'health',
    'business',
    'technology',
  ];

  @override
  Widget build(BuildContext context) {
    final newsController = Provider.of<NewsController>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search box
            SearchBox(),
            const SizedBox(height: 10),

            // Filters
            Text(
              'Categories',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary,)
            ),
            const SizedBox(height: 10),

            // Using Wrap for filters to allow them to flow to the next line if space runs out
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: double.minPositive + 4,
                children: [
                  // Example filter chips/buttons
                  FilterChip(
                    selectedColor: Theme.of(context).colorScheme.primary.withAlpha(100),
                    label: const Text('All'),
                    onSelected: (bool selected) {
                      if (selected) {
                        newsController.fetchTopHeadlinesUS('general');                        
                      }
                      print('All selected: $selected');
                    },
                    selected: newsController.currentCategory == 'general',
                  ),

                  ...categories.where((cat) => cat != 'general').map((category) {
                    return FilterChip(
                      label: Text(category[0].toUpperCase() + category.substring(1)),
                      onSelected: (bool selected) {
                        if (selected) {
                          newsController.fetchTopHeadlinesUS(category);
                        }
                        print('$category selected: $selected');
                      },
                      selected: newsController.currentCategory == category,
                    );
                  }),
                ],
              ),
            ),
            // const SizedBox(height: 10),

            const Expanded(child: NewsList()),
          ],
        ),
      ),
    );
  }
}
