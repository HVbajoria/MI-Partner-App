import 'package:flutter/material.dart';
import 'package:mi_partner_app/pages/home.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: const Text("About Us", style: TextStyle(color: Colors.white),),
        elevation: 0.8,
      ),
      body: Column(

        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(5.0, 70.0, 5.0, 10.0),
            child: Image(image: AssetImage('images/Logo.png'),
              height: 150.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("MI Partner", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0, color: Colors.deepOrangeAccent)),
          ),
          const Padding(
            padding: EdgeInsets.all(22.0),
            child: Text("MI Partner App is the solution to the above problems that will help to ease the billing process across all Mi outlets by allowing the store operators to process customer orders in real-time through various devices thereby increasing speed and efficiency and ultimately increasing customer satisfaction with security and trust bringing in the culture of the organization to the consumer.", textAlign: TextAlign.center,style:TextStyle(fontWeight: FontWeight.w500, color: Colors.blueGrey)),
          ),
          const Padding(
            padding: EdgeInsets.all(27.0),
            child: Text("Build By: Harshavardhan Bajoria", textAlign: TextAlign.center,style:TextStyle(fontWeight: FontWeight.w500, color: Colors.black45)),
          ),



          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 130.0, 10.0, 20.0),
            child: Material(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.blueAccent.withOpacity(0.8),
                elevation: 0.5,
                child: MaterialButton(
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomePage()));
                  },
                  minWidth: MediaQuery.of(context).size.width,
                  child: const Text("Go to Homepage", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0,),
                  ),
                )
            ),
          ),


        ],
      ),
    );
  }
}
