import 'package:baroni_app/home/FanView/message/chat_page.dart';
import 'package:baroni_app/uttils/app_colors.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.whiteColor,
        title:  Text("Messages",style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.blackColor
        ),),
        backgroundColor: AppColors.whiteColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ListView.separated(
            itemBuilder: (context, index) => ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChatPage(
                  userName: 'Riya Mehta',
                  userImage: 'https://thumbs.dreamstime.com/b/profile-picture-smiling-indian-young-businesswoman-look-camera-posing-workplace-headshot-portrait-happy-millennial-ethnic-190959731.jpg',

                )));
              },
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                        'https://thumbs.dreamstime.com/b/profile-picture-smiling-indian-young-businesswoman-look-camera-posing-workplace-headshot-portrait-happy-millennial-ethnic-190959731.jpg'),
                  ),
                  title: Text(
                    'Riya Mehta',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Looking forward to our next call',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey48),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('2h ago',style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                          color: AppColors.grey48
                      ),),
                      SizedBox(height: 4,),
                      Icon(Icons.done_all,size: 16,color: AppColors.primaryColor,)
                    ],
                  ),
                ),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: AppColors.greyF6,
              ),
            ),
            itemCount: 10),
      ),
    );
  }
}
