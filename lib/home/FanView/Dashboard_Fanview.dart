import 'package:baroni_app/home/FanView/star_profile_fan/star_profile_fan_page.dart';
import 'package:baroni_app/uttils/app_assets.dart';
import 'package:baroni_app/uttils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardFanview extends StatelessWidget {
  const DashboardFanview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,top: 16,),
          child: Column(
            children: [
              // ====== Sticky Header: Top Greeting & Notification ======
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0'),
                        radius: 25,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hi Emma 👋',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Ready to move today?',
                            style: TextStyle(
                              color: AppColors.grey6E,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors.greyF6,
                    radius: 25,
                    child: Icon(
                      CupertinoIcons.bell_fill,
                      color: AppColors.grey48,
                      size: 20,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ====== Sticky Header: Search Bar ======
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColors.greyE9),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search by star name or Baroni ID',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: AppColors.grey6D,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          icon: Icon(
                            CupertinoIcons.search,
                            color: AppColors.grey6D,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor: AppColors.greyF6,
                    radius: 25,
                    child: Icon(
                      Icons.filter_list_outlined,
                      color: AppColors.grey48,
                      size: 20,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // ====== Scrollable Body ======
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const SectionTitle(title: "Featured Stars"),
                      const SizedBox(height: 12),
                      FeaturedCard(),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 90,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => SizedBox(
                              width: 61,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> StarProfileFanPage()));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: index == 0 ? AppColors.primaryColor : Colors.transparent, width: 1.5)
                                      ),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage('https://img.indiaforums.com/person/480x360/0/0435-kareena-kapoor.webp?c=4xI3C7'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text('Kareena Kapoor',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                                  width: 15,
                                ),
                            itemCount: 10),
                      ),
                      const SizedBox(height: 20),
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
                          CategoryCard(
                              title: "Comedians", color: Colors.orange),
                          CategoryCard(
                              title: "Influencer", color: Colors.purple),
                          CategoryCard(title: "TV Hosts", color: Colors.green),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Upcoming Highlights",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            "See all",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 165,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(width: 10,),
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return HighlightCard();
                          },
                        ),
                      ),

                      const SizedBox(height: 20),
                      const SectionTitle(title: "Stars Ready for Call"),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 165,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return const StarCallCard();
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            backgroundColor: AppColors.primaryColor,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(120),
                            ),
                          ),
                          onPressed: () {},
                          child:  Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star_rate_rounded,color: AppColors.whiteColor,),
                              const SizedBox(width: 8),
                              Text(
                                "Become a Baroni Star",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
      width: double.infinity,
      height: 180,
      // margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage(
              "https://media.cnn.com/api/v1/images/stellar/prod/160301133704-priyanka-chopra.jpg?q=w_4928,h_3280,x_0,y_0,c_fill"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Emma Stone",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                Row(
                  children: [
                    Icon(Icons.star_rate_rounded,
                        color: AppColors.yello15, size: 16),
                    SizedBox(width: 4),
                    Text("4.9 | Hollywood Actress",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100))),
              onPressed: () {},
              child: Row(
                children: [
                  Image.asset(
                    AppAssets.videoOnIcon,
                    color: AppColors.whiteColor,
                    height: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Book Now",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor),
                  ),
                ],
              ),
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
          image: DecorationImage(
              image: NetworkImage(
                  'https://static.independent.co.uk/2020/12/18/07/newFile-7.jpg'),
              fit: BoxFit.cover)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  color.withOpacity(0.4),
                  AppColors.whiteColor.withOpacity(0.2),
                ])),
        alignment: Alignment.bottomCenter,
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
      width: MediaQuery.of(context).size.width * 0.85,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.blackColor.withOpacity(0.06),
          width: 1,
        )

      ),
      child: Row(
        children: [
          Container(
            height: 168,
            width: 119,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                  image: NetworkImage(
                      "https://curlytales.com/wp-content/uploads/2025/03/all-women-festival.jpg"),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                 Text(
                  "Next live show: Fan Night",
                  style: TextStyle(
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                const SizedBox(height: 4),
                 Text(
                  "26 July, 9:00 PM",
                  style: TextStyle(color: AppColors.grey6D),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: AppColors.greyE8,
                          borderRadius: BorderRadius.circular(120)),
                      child:  Text(
                        "Scheduled",
                        style: TextStyle(color: AppColors.green2E,fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 4),
                     Text(
                      "343 joined",
                      style: TextStyle(color: AppColors.grey6D, fontSize: 14,fontWeight: FontWeight.w400),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    minimumSize: const Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {},
                  child:  Text('Join',
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400)
                ),),
              ],
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
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://i.pinimg.com/736x/f3/60/13/f3601381fa850e259717a2702dceb781.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 6,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration:  BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
           Text(
            "Nora Fatehi",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: AppColors.grey6D),
            textAlign: TextAlign.center,
          ),
           Text(
            "Dance Star",
            style: TextStyle(fontSize: 12, color: AppColors.grey6B,fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
