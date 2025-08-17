import 'package:baroni_app/uttils/app_assets.dart';
import 'package:baroni_app/uttils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarProfileFanPage extends StatefulWidget {
  const StarProfileFanPage({super.key});

  @override
  State<StarProfileFanPage> createState() => _StarProfileFanPageState();
}

class _StarProfileFanPageState extends State<StarProfileFanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.red),
            onPressed: () {},
          )
        ],
      ),

      // ===== Scrollable content =====
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde"),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Patrick Wilson",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.verified, color: Colors.red, size: 18),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text("4.2 ⭐ | 2.1k Followers | 45 Videos",
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      child: Text(
                        "Message",
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.greyF6),
                    ),
                    child: Text(
                      "Award-winning actor and singer with multiple hits in Hollywood. Book me for your special events or to get a personalized message.",
                      style: TextStyle(color: AppColors.grey6D, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Upcoming Show
            sectionTitle("Star’s Upcoming Show", "See all"),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          "https://t4.ftcdn.net/jpg/02/54/28/89/360_F_254288948_hy4c6gqgNKFDSwEJaztPGT72UvAMEejm.jpg",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Next Show: Power Night",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  "26 July, 9:00 PM",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.grey6D),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor
                                        .withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(120),
                                  ),
                                  child: Text(
                                    "Live Show",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.primaryColor),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: AppColors.greyE8,
                                      borderRadius: BorderRadius.circular(120)),
                                  child: Text(
                                    "Scheduled",
                                    style: TextStyle(
                                        color: AppColors.green2E, fontSize: 12),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "343 joined",
                                  style: TextStyle(
                                      color: AppColors.grey6D,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              minimumSize: const Size(0, 46),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          child: const Text("Join",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.whiteColor,
                            minimumSize: const Size(80, 46),
                            elevation: 0,
                            side: BorderSide(color: AppColors.greyEC),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: Row(
                          children: [
                            Icon(Icons.link_rounded,
                                color: AppColors.primaryColor, size: 16),
                            const SizedBox(width: 4),
                            Text("1.2k",
                                style: TextStyle(
                                    color: AppColors.grey6D, fontSize: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Services
            sectionTitle("Services", ""),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  serviceCard("Video Call", 'Personalized video greeting',
                      AppColors.primaryColor),
                  serviceCard("Dedication", 'Greetings on your special day',
                      Colors.blue),
                  serviceCard(
                      "Live Show", 'Tailored to your needs', Colors.green),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Sample Dedications
            sectionTitle(
              "Sample Dedications",
              "",
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
                        width: 100,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Birthday Wish',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey37),
                    )
                  ],
                ),
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemCount: 5,
              ),
            ),

            const SizedBox(height: 20),

            // Reviews
            sectionTitle("Reviews", "View all"),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 140,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) =>
                      reviewTile("John Mark", "Emma was amazing! She created a birthday message for my mom that made her cry tears of joy. Worth every penny!", 5),
                  separatorBuilder: (context, index) => SizedBox(
                        width: 12,
                      ),
                  itemCount: 5),
            ),
            // reviewTile("Lisa Ray", "Very professional and kind.", 4),

            const SizedBox(height: 20),

            // Availability
            sectionTitle("Availability", ""),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.greyF6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12,),
                  Text('22 Aug, Wednesday',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                  SizedBox(height: 12,),
                  availabilityTile("Fri, 16 Aug • 10:00 AM", true),
                  SizedBox(height: 12,),
                  Text('22 Aug, Wednesday',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                  SizedBox(height: 12,),
                  availabilityTile("Sat, 17 Aug • 6:00 PM", true),
                  availabilityTile("Mon, 19 Aug • 11:00 AM", false)
                ],
              ),
            ),

            const SizedBox(height: 20), // space for bottom button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(1),
                    color: Colors.white,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 12),
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Row(
                        children: [
                          Image.asset(AppAssets.videoOffIcon,color: AppColors.whiteColor,height: 20,),
                          SizedBox(width: 10,),
                          const Text(
                            "Book a call",
                            style: TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    padding: const EdgeInsets.all(1),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.grey37.withOpacity(0.2),
                        padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 12),
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.gift_fill,color: AppColors.grey37,size: 20,),
                          SizedBox(width: 10,),
                           Text(
                            "Request Dedication",
                            style: TextStyle(color: AppColors.grey37, fontSize: 14,fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // space for bottom button
          ],
        ),
      ),


    );
  }

  Widget sectionTitle(String title, String action) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          if (action.isNotEmpty)
            Text(action,
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget serviceCard(String text, String des, Color borderColor) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: borderColor, width: 3),
          left: BorderSide(color: borderColor, width: 1),
          right: BorderSide(color: borderColor, width: 1),
          bottom: BorderSide(color: borderColor, width: 1),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey37)),
          const SizedBox(height: 2),
          Text(des,
              style: TextStyle(
                  fontSize: 14,
                  color: AppColors.grey6D,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  Widget reviewTile(String name, String comment, int stars) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.greyF6),

      ),
      child: Column(
        children: [
          Row(
            children: List.generate(
              5,
                  (index) => Icon(Icons.star,
                  size: 14, color: index < stars ? Colors.orange : Colors.grey),
            ),
          ),
          Text(comment,maxLines: 3,
          overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14,
                color: AppColors.grey6D,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1502685104226-ee32379fefbe"),
              ),
              Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),

            ],
          ),
        ],
      ),
    );
  }

  Widget availabilityTile(String time, bool available) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(
        bottom: 12
      ),
      decoration: BoxDecoration(
        color: AppColors.greyF9,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: AppColors.primaryColor,width: 4)
        )
      ),
      child: Row(
        children: [
          Text(time),
          Text(
            available ? "Available" : "Booked",
            style: TextStyle(
                color: available ? Colors.green : Colors.red,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
