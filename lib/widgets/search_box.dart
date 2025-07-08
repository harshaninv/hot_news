import 'package:flutter/material.dart';
import 'package:hot_news/controllers/news_controller.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.addListener(() {
      setState(() {
        
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    setState(() {

    });
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final newsController = Provider.of<NewsController>(context, listen: false);

    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search for news...',
        prefixIcon: Icon(Icons.search),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  newsController.resetToDefaultView(); // Reset to default view
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
      ),
      onSubmitted: (query) {
        if (query.isNotEmpty) {
          newsController.fetchNewsByQuery(query);
        } else {
          newsController.resetToDefaultView(); // Reset to default view if search is cleared
        }
      },
    );
  }
}
