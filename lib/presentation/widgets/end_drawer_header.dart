import 'package:flutter/material.dart';

class EndDrawerHeader extends StatefulWidget {
  final String userEmailAddress;
  const EndDrawerHeader({super.key, required this.userEmailAddress});

  @override
  State<EndDrawerHeader> createState() => _EndDrawerHeaderState();
}

class _EndDrawerHeaderState extends State<EndDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Center(
        child: Column(
        children: [
           GestureDetector(
             onTap: (){
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      scrollable: true,
                      title: Center(child: Text('User')),
                      content: Column(
                          children: [
                            Center(
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 141, 210, 226),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.person, size: 50,),
                              )
                            ),
                            SizedBox(height: 20),
                            Center(
                                child: Row(
                                  children: [
                                    Text("Email : ${widget.userEmailAddress}")
                                  ],
                                )
                            ),
                            Center(
                              child: TextButton(
                                child: Text('Close'),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            )
                          ]
                      ),
                    );

                  },
              );
              },
            child: Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 141, 210, 226),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person, size: 50,),
            )
          ),
        ]
        ),
      ),
    );
  }
}
