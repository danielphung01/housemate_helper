import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MakeAnnouncementPage extends StatefulWidget {
  const MakeAnnouncementPage({Key? key}) : super(key: key);

  @override
  State<MakeAnnouncementPage> createState() => _MakeAnnouncementPageState();
}

class _MakeAnnouncementPageState extends State<MakeAnnouncementPage> {

  var announcementController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make an Announcement'),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),

      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: TextField(
              controller: announcementController,
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'What do you want to let your housemates know?',
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )
              ),
              side: MaterialStateProperty.all(
                  BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.grey,
                  )
              ),
            ),
            child: Text('Make Annoucement'),
            onPressed: () {
              // TODO: send a notification to all users in the same group with the annoucement message
              print('make annoucement button pressed');
              Navigator.of(context).pop();
            },
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              'Note: Creating an annoucement will send a notification containing your message to all of your housemates! All annoucements are a one time thing and will not be saved.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
