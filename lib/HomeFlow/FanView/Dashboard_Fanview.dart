import 'package:flutter/material.dart';

class DashboardFanview extends StatelessWidget {
  const DashboardFanview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Top Greeting & Notification
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150'), // profile
                      radius: 20,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi Emma 👋',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Ready to move today?',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.notifications_none, size: 28),
              ],
            ),
            const SizedBox(height: 16),

            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search by star name or Baroni ID',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Featured Stars
            const SectionTitle(title: "Featured Stars"),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return FeaturedCard();
                },
              ),
            ),

            const SizedBox(height: 20),

            // Browse Categories
            const SectionTitle(title: "Browse Categories"),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: const [
                CategoryCard(title: "Actors", color: Colors.pink),
                CategoryCard(title: "Musicians", color: Colors.blue),
                CategoryCard(title: "Artists", color: Colors.teal),
                CategoryCard(title: "Comedians", color: Colors.orange),
                CategoryCard(title: "Influencer", color: Colors.purple),
                CategoryCard(title: "TV Hosts", color: Colors.green),
              ],
            ),

            const SizedBox(height: 20),

            // Upcoming Highlights
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Upcoming Highlights",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "See all",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 12),
            HighlightCard(),

            const SizedBox(height: 20),

            // Stars Ready for Call
            const SectionTitle(title: "Stars Ready for Call"),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const StarCallCard();
                },
              ),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Become a Baroni Star",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Section Title Widget
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}

// Featured Card
class FeaturedCard extends StatelessWidget {
  const FeaturedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage("https://via.placeholder.com/400x200"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Emma Stone",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                    SizedBox(width: 4),
                    Text("4.9 | Hollywood Actress",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {},
              child: const Text("Book Now"),
            ),
          ),
        ],
      ),
    );
  }
}

// Category Card
class CategoryCard extends StatelessWidget {
  final String title;
  final Color color;
  const CategoryCard({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }
}

// Highlight Card
class HighlightCard extends StatelessWidget {
  const HighlightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
            image: NetworkImage("https://via.placeholder.com/400x200"),
            fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Next live show: Fan Night",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const Text(
                  "26 July, 9:00 PM | East",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    "Scheduled",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "343 joined",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {},
              child: const Text("Join Live Show"),
            ),
          ),
        ],
      ),
    );
  }
}

// Star Call Card
class StarCallCard extends StatelessWidget {
  const StarCallCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundImage:
                    NetworkImage("https://via.placeholder.com/100"),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            "Sarah Wilson",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const Text(
            "Dance Star",
            style: TextStyle(fontSize: 10, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
