import 'package:flutter/material.dart';
import 'package:mi_partner_app/pages/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// my imports
import 'package:mi_partner_app/pages/home.dart';

import '../db/user.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  UserServices _userServices = UserServices();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  late SharedPreferences preferences;
  bool loading = false ;
  bool isLoggedin = false;
  bool hidePass =true;
  @override
  void initState(){
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async{
    setState(() {
      loading = true;
    });

    preferences=await SharedPreferences.getInstance();
    isLoggedin = await googleSignIn.isSignedIn();
    if(isLoggedin){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
    }
    setState(() {
      loading=false;
    });
  }

  Future handleSignInGoogle() async{
    preferences= await SharedPreferences.getInstance();
    setState(() {
      loading=true;
    });

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential firebaseUser = await FirebaseAuth.instance.signInWithCredential(credential);

    if(firebaseUser !=null){
      User fireUser=FirebaseAuth.instance.currentUser!;
      final QuerySnapshot result = await FirebaseFirestore.instance.collection("users").where("id",isEqualTo: fireUser.uid).get();
      final List<DocumentSnapshot> documents = result.docs;
      if(documents.isEmpty){
        // insert the user to our collection
        FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
              "id": fireUser.uid,
              "username": fireUser.displayName,
          "emailId":fireUser.email,

        });

        await preferences.setString("id", fireUser.uid);
        await preferences.setString("username", fireUser.displayName!);
        await preferences.setString("emailId", fireUser.email!);

      }
      else{
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[0]['username']);
        await preferences.setString("email id", documents[0]['emailId']);

      }
      Fluttertoast.showToast(msg: "Welcome! Start a new day");

      setState(() {
        loading=false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
    }
    else{
      Fluttertoast.showToast(msg: "Login Failed :(\nTry Again!");

    }
  }

  Future handleSignInEmail() async{
    FormState? formState = _formKey.currentState;

    if(formState?.validate()!=null){
      // Fetch sign-in methods for the email address
      final list = await FirebaseAuth.instance.fetchSignInMethodsForEmail(_emailTextController.text);

      // In case list is not empty
      if (list.isNotEmpty) {

        setState(() {
              loading=false;
              isLoggedin = true;
            });
            Fluttertoast.showToast(msg: "Welcome! Start a new day");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
      } else {
        Fluttertoast.showToast(msg: "Account does not exist!\nPlease Check The Credentials");
      }
      // User? fireUser=await FirebaseAuth.instance.currentUser;
      // if(fireUser == null){
      //
      // }
      // else{
      //
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: Text("Login", style: TextStyle(color: Colors.white),),
        elevation: 0.8,
      ),
      body: Stack(
        children: <Widget>[
          Image.asset('images/background.jpg', fit: BoxFit.fill, width: double.infinity, height: double.infinity,),

          Container(
            color: Colors.black.withOpacity(0.3),
            width: double.infinity,
            height: double.infinity,
          ),
          ListView(

            children: <Widget>[Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 45.0, 10.0, 70.0),
              child: Image.asset("images/Logo.png", width:150.0, height:150.0),
            ),

          
          Container(
            alignment: Alignment.center,
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
              children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white.withOpacity(0.5),
                        elevation: 0.5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email *",
                            hintText: "someone@email.com",
                            icon: Icon(Icons.email),border: InputBorder.none,),
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailTextController,
                            validator: (value){
                              if(value!=null){
                                RegExp regex = new RegExp( r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                                if(!regex.hasMatch(value))
                                  return 'Please enter correct email address';
                                else
                                  return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),

                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white.withOpacity(0.5),
                    elevation: 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: ListTile(
                        title: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Password *",
                            hintText: "Strong password",
                            icon: Icon(Icons.lock_outlined),border: InputBorder.none,),
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordTextController,
                          obscureText: hidePass,
                          validator: (value){
                            if(value==null){
                              return "The password cannot be empty";
                              }
                            else if(value.length<6)
                              return "The password must be 6 characters long";
                            else
                            return null;
                            },
                        ),
                        trailing: IconButton(icon: Icon(Icons.remove_red_eye), onPressed: () {setState((){
                          hidePass=!hidePass;
                        });},),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 17.0, 50.0, 5.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.blueAccent.withOpacity(0.8),
                    elevation: 0.5,
                    child: MaterialButton(
                      onPressed: (){
                        handleSignInEmail();
                      },
                      minWidth: MediaQuery.of(context).size.width,
                      child: Text("Login", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0,),
                      ),
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Forgot Password", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 20.0),
                  child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
                      },
                      child: Text("Sign Up", style: TextStyle(color: Colors.redAccent, fontSize: 14.0, fontWeight: FontWeight.w500),
                  ),),
                ),

                Divider(color: Colors.deepOrangeAccent.withOpacity(0.7),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Other Sign In Options", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 17.0, 50.0, 15.0),
                  child: Material(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.white.withOpacity(0.8),
                      elevation: 0.5,
                      child: MaterialButton(
                        onPressed: (){
                          handleSignInGoogle();
                        },

                        minWidth: MediaQuery.of(context).size.width,
                        child: Text("Sign In With Google", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.0,),
                        ),
                      )
                  ),
                ),
                  ],
                ),
              ),
            ),
          ),],),
          Visibility(
            visible: loading ?? true,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
              ),
          ),
        ],
      ),
    );
  }
}
