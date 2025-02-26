import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community Forum'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create new discussion screen
            },
          ),
        ],
      ),
      body: Column(children: [SearchBar(), Expanded(child: DiscussionList())]),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search discussions...',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}

class DiscussionList extends StatelessWidget {
  final List<String> discussions = [
    'How to manage pests in corn?',
    'Best practices for organic farming',
    'What fertilizers work best for tomatoes?',
    'Tips for irrigation during dry seasons',
    'How to identify crop diseases?',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: discussions.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: ListTile(
            title: Text(discussions[index]),
            subtitle: Text('Last updated: 2 hours ago'),
            onTap: () {
              // Navigate to discussion details
            },
          ),
        );
      },
    );
  }
}
