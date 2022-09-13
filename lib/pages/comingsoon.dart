import 'package:flutter/material.dart';
import 'package:mi_partner_app/pages/home.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  _ComingSoonState createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text("Under Construction", style: TextStyle(color: Colors.white),),
        elevation: 0.8,
      ),
      body: Column(

        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 70.0, 5.0, 10.0),
            child: Image(image: AssetImage('images/comingsoon.gif'),
              height: 250.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Hello, We are working on it", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0, color: Colors.green)),
          ),
          const Padding(
            padding: EdgeInsets.all(27.0),
            child: Text("Coming Soon!", textAlign: TextAlign.center,style:TextStyle(fontWeight: FontWeight.w500, color: Colors.blueGrey)),
          ),



          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 150.0, 10.0, 20.0),
            child: Material(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.blueAccent.withOpacity(0.8),
                elevation: 0.5,
                child: MaterialButton(
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
                  },
                  minWidth: MediaQuery.of(context).size.width,
                  child: Text("Go to Homepage", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0,),
                  ),
                )
            ),
          ),


        ],
      ),
    );
  }
}
