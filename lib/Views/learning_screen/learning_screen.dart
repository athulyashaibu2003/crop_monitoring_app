import 'package:flutter/material.dart';

class LearningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farmer Learning Platform"),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLearningCategory(
              title: "Crop-Specific Learning",
              icon: Icons.agriculture,
              content: [
                "Wheat: Best practices, irrigation, and harvesting.",
                "Rice: Pest control, soil nutrients, and water management.",
                "Maize: Seasonal tips, disease prevention, and fertilizers.",
              ],
            ),
            _buildLearningCategory(
              title: "Disease & Pest Management",
              icon: Icons.bug_report,
              content: [
                "Common diseases in crops and their solutions.",
                "Organic pest control techniques.",
                "AI-based pest identification (Coming Soon).",
              ],
            ),
            _buildLearningCategory(
              title: "Weather & Climate Advice",
              icon: Icons.cloud,
              content: [
                "How to protect crops from extreme weather.",
                "Drought and monsoon preparation for farmers.",
                "Frost and heatwave protection strategies.",
              ],
            ),
            _buildLearningCategory(
              title: "Fertilizers & Pesticides Guide",
              icon: Icons.science,
              content: [
                "Organic vs chemical fertilizers: Benefits and risks.",
                "Best pesticide application techniques.",
                "Crop-wise fertilization schedule.",
              ],
            ),
            _buildLearningCategory(
              title: "Government Schemes & Subsidies",
              icon: Icons.account_balance,
              content: [
                "Latest agricultural policies and benefits.",
                "Subsidy and loan assistance for farmers.",
                "Crop insurance and financial support programs.",
              ],
            ),
            _buildLearningCategory(
              title: "Smart Farming & Technology",
              icon: Icons.smart_toy,
              content: [
                "How to use AI and IoT in agriculture.",
                "Soil testing and interpretation of results.",
                "Modern irrigation techniques: Drip and sprinkler systems.",
              ],
            ),
            _buildLearningCategory(
              title: "Video Learning (YouTube API Integration)",
              icon: Icons.video_library,
              content: [
                "Watch expert farming tutorials on YouTube.",
                "Step-by-step practical guides for crop management.",
                "Live webinars with agricultural experts (Coming Soon).",
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLearningCategory({
    required String title,
    required IconData icon,
    required List<String> content,
  }) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        children: content.map((item) => ListTile(title: Text(item))).toList(),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: LearningScreen()),
  );
}
