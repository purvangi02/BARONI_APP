import 'package:baroni_app/uttils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String? userName;
  final String? userImage;
   ChatPage({super.key,required this.userName, required this.userImage});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> messages = [
    {
      'text': "Hello! This is from 3 days ago.",
      'isMe': false,
      'time': '9:15 AM',
      'date': DateTime.now().subtract(const Duration(days: 3)),
    },
    {
      'text': "Hey! Got it.",
      'isMe': true,
      'time': '9:17 AM',
      'date': DateTime.now().subtract(const Duration(days: 3)),
    },
    {
      'text': "Yesterday's chat starts here.",
      'isMe': false,
      'time': '8:00 AM',
      'date': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'text': "Yep, I remember!",
      'isMe': true,
      'time': '8:05 AM',
      'date': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'text': "Hey there! Thanks for booking this video call. Looking forward to chatting with you next week!",
      'isMe': false,
      'time': '10:26 AM',
      'date': DateTime.now(),
    },
    {
      'text': "I’m doing great! So excited to chat with you. I’ve been a huge fan.",
      'isMe': true,
      'time': '10:26 AM',
      'date': DateTime.now(),
    },
    {
      'text': "That’s so kind of you to say! I’m curious, what’s your favorite movie of mine?",
      'isMe': false,
      'time': '10:27 AM',
      'date': DateTime.now(),
    },
    {
      'text': "Me too! I wanted to ask if there’s anything specific I should prepare?",
      'isMe': true,
      'time': '10:29 AM',
      'date': DateTime.now(),
    },
    {
      'text': "Great choice! That was such a special project to work on.",
      'isMe': false,
      'time': '10:30 AM',
      'date': DateTime.now(),
    },
    {
      'image': "https://picsum.photos/300/200",
      'isMe': false,
      'time': '10:31 AM',
      'date': DateTime.now(),
    },
    {
      'text': "Is there anything specific you’d like to talk about during our video call?",
      'isMe': false,
      'time': '10:31 AM',
      'date': DateTime.now(),
    },
    {
      'text': "That looks amazing! Can’t wait to hear more about it.",
      'isMe': true,
      'time': '10:32 AM',
      'date': DateTime.now(),
    },
    {
      'text': "😍🙌",
      'isMe': true,
      'time': '10:33 AM',
      'date': DateTime.now(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              reverse: true, // Start from bottom
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final reversedIndex = messages.length - 1 - index;
                final msg = messages[reversedIndex];
                final isMe = msg['isMe'] as bool;

                // Show date separator when date changes
                bool showDate = reversedIndex == 0 ||
                    !isSameDay(
                        msg['date'], messages[reversedIndex - 1]['date']);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (showDate) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.blackColor.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          formatDateLabel(msg['date']),
                          style:  TextStyle(
                              fontSize: 12, color: AppColors.blackColor),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    Align(
                      alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            constraints: BoxConstraints(
                                maxWidth:
                                MediaQuery.of(context).size.width * 0.75),
                            decoration: BoxDecoration(
                              color: msg.containsKey('image')
                                  ? Colors.transparent
                                  : (isMe ? AppColors.primaryColor : AppColors.greyF1),
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(16),
                                topRight: Radius.circular(isMe ? 0 : 16),
                                bottomLeft:
                                Radius.circular(isMe ? 16 : 0),
                                bottomRight: Radius.circular(16)
                                ,
                              ),
                            ),
                            child: msg.containsKey('image')
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                msg['image'],
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    height: 150,
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                                : Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    msg['text'],
                                    style: TextStyle(
                                      color: isMe
                                          ? AppColors.whiteColor
                                          : AppColors.blackColor,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                msg['time'],
                                style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.grey6B),
                              ),
                              if (isMe) ...[
                                const SizedBox(width: 4),
                                 Icon(Icons.done_all,
                                    size: 14,
                                    color: AppColors.primaryColor),
                              ]
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () {},
      ),
      titleSpacing: 0,
      title: Row(
        children: [
           CircleAvatar(
            backgroundImage: NetworkImage(
          widget.userImage.toString()      ),
            radius: 18,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Row(
                children: [
                  Text(
                    widget.userName.toString(),
                    style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 16),
                  ),
                  SizedBox(width: 4,),
                  Icon(Icons.verified,size: 18,color: AppColors.primaryColor,),
                ],
              ),
              Text(
                "Available",
                style: TextStyle(color: AppColors.green5E, fontSize: 12,fontWeight: FontWeight.w500),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.black),
          onPressed: () {},
        )
      ],
      shadowColor: AppColors.blackColor.withOpacity(0.08),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
    color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 0.5),
      ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.grey),
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Write a message...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String formatDateLabel(DateTime date) {
    final now = DateTime.now();
    if (isSameDay(date, now)) {
      return "Today";
    } else if (isSameDay(date, now.subtract(const Duration(days: 1)))) {
      return "Yesterday";
    } else {
      return DateFormat("MMM d, yyyy").format(date);
    }
  }
}
