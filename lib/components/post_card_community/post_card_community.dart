import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String userName, timeAgo, description, imageUrl;

  PostCard({
    required this.userName,
    required this.timeAgo,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: 150,
            width: double.infinity,
          ),

          // User Info
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(child: Icon(Icons.person)),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          userName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        Image.asset("assets/images/full-stop.png", height: 25),
                        Text("India"),
                      ],
                    ),
                    Text(timeAgo),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),

          // Description
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(description, style: TextStyle(fontSize: 16)),
          ),

          // Actions
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.thumb_up_alt_outlined),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.thumb_down_alt_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  "assets/images/icons8-whatsapp-24.png",
                  height: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
