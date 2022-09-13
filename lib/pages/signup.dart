import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mi_partner_app/db/user.dart';

import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final UserServices _userServices = UserServices();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  late String store_name;
  bool hidePass=true;
  bool hidePass2=true;
  String groupValue="Choose";
  bool loading = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: const Text("Register", style: TextStyle(color: Colors.white),),
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
              padding: const EdgeInsets.fromLTRB(10.0, 45.0, 10.0, 20.0),
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
                                decoration: const InputDecoration(
                                  labelText: "Store Name *",
                                  hintText: "Your store name",
                                  icon: Icon(Icons.person),border: InputBorder.none,),
                                keyboardType: TextInputType.visiblePassword,
                                controller: _nameTextController,
                                validator: (value){
                                  if(value==null){
                                    return "The name cannot be empty";
                                  }

                                  else {
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
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: "Email *",
                                  hintText: "someone@email.com",
                                  icon: Icon(Icons.email),border: InputBorder.none,),
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailTextController,
                                validator: (value){
                                  if(value!=null){
                                    RegExp regex = RegExp( r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                                    if(!regex.hasMatch(value)) {
                                      return 'Please enter correct email address';
                                    } else {
                                      return null;
                                    }
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
                                  decoration: const InputDecoration(
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
                                    else if(value.length<6) {
                                      return "The password must be 6 characters long";
                                    } else {
                                      return null;
                                    }
                                  },
                                  ),
                                  trailing: IconButton(icon: const Icon(Icons.remove_red_eye), onPressed: () {setState((){
                                    hidePass=!hidePass;
                                  });},),
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
                                  decoration: const InputDecoration(
                                    labelText: "Confirm Password *",
                                    hintText: "Strong password",
                                    icon: Icon(Icons.lock_outlined),
                                  border: InputBorder.none,),
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: _confirmPasswordController,
                                  obscureText: hidePass2,
                                  validator: (value){
                                    if(value==null){
                                      return "The password cannot be empty";
                                    }
                                    else if(value.length<6) {
                                      return "The password must be 6 characters long";
                                    }
                                    else if(_passwordTextController.text!=value) {
                                      return "The Passwords do not match";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                ),
                                trailing: IconButton(icon: const Icon(Icons.remove_red_eye), onPressed: () {
                                  setState((){
                                    hidePass=!hidePass2;
                                  });
                                },),
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
                                onPressed: () async{
                                  validateForm();
                                },
                                minWidth: MediaQuery.of(context).size.width,
                                child: const Text("Register", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0,),
                                ),
                              )
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 20.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: const Text("Have an account? Login", textAlign: TextAlign.center, style: TextStyle(color: Colors.redAccent, fontSize: 14.0, fontWeight: FontWeight.w500),
                            ),),
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
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future validateForm() async{
    FormState? formState = _formKey.currentState;

    if(formState?.validate()!=null){

      User? fireUser=FirebaseAuth.instance.currentUser;
      if(fireUser == null){

        firebaseAuth.createUserWithEmailAndPassword(
            email: _emailTextController.text,
            password: _passwordTextController.text).then((user)=>{
              fireUser=FirebaseAuth.instance.currentUser,
              _userServices.createUser({
                "id": fireUser?.uid,
                "username": _nameTextController.text,
                "emailId":_emailTextController.text,
              })
        }).catchError((err)=> {print(err.toString())});
        setState(() {
          loading=false;
        });
        Fluttertoast.showToast(msg: "Welcome! Start a new day");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
      }
      else{
        Fluttertoast.showToast(msg: "Account exists!\nPlease Login");
        Navigator.pop(context);
      }
    }
  }
}
