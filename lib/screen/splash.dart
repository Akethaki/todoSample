import 'package:flutter/material.dart';
import 'package:todo_my/screen/all_notes.dart';



class Splash extends StatefulWidget {
  const Splash({ Key? key }) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  } 

  _navigatetohome()async{
    await Future.delayed(Duration(milliseconds: 2000), (){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AllNotes()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/todo.jpg'),
              ),
            
            Container(
              child: const Text('Welcome to my To Do', 
              style: TextStyle(
                fontSize: 30.0, 
                fontWeight: FontWeight.bold,
                fontFamily:'Pacifico',
                ),),
            ),
          ],
        ),
      ),
    );
  }
}