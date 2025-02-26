import 'package:crop_monitoring_app_orginal/components/filter_chip_widget/filter_chip_widget.dart';
import 'package:crop_monitoring_app_orginal/components/post_card_community/post_card_community.dart';
import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: false,
            snap: true,
            title: TextField(
              decoration: InputDecoration(
                hintText: "Search in Community",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
              ),
            ),
            actions: [
              IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
              IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),

          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  FilterChipWidget(label: "Cabbage"),
                  FilterChipWidget(label: "Capsicum & Chilli"),
                  FilterChipWidget(label: "Bitter Gourd"),
                ],
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => PostCard(
                userName: "Sd Arif Patel",
                timeAgo: "3 h",
                description:
                    "Tell me what is this problem\nShape out and colour change",
                imageUrl:
                    "https://media.istockphoto.com/id/1380361370/photo/decorative-banana-plant-in-concrete-vase-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=eYADMQ9dXTz1mggdfn_exN2gY61aH4fJz1lfMomv6o4=",
              ),
              childCount: 15, // Total posts
            ),
          ),
        ],
      ),

      // Floating button for posting
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue[900],
        onPressed: () {},
        label: Text("Ask Community", style: TextStyle(color: Colors.white)),
        icon: Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}
   