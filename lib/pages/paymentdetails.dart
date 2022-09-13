import 'package:flutter/material.dart';
import 'package:mi_partner_app/pages/payments.dart';

import '../db/user.dart';

class PaymentDetails extends StatefulWidget {
  final cart;
  const PaymentDetails({
    this.cart,
});

  @override
  _PaymentDetailsState createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  final _formKey = GlobalKey<FormState>();
  final UserServices _userServices = UserServices();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _deliveryController = TextEditingController();
  late String store_name;
  bool hidePass = true;
  bool hidePass2 = true;
  String groupValue = "Choose";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.8,
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 28.0, 10.0, 25.0),
                child: Text("Enter Details",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 20.0,
                    )),
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
                                  labelText: "Customer Name *",
                                  hintText: "His/Her good name",
                                  icon: Icon(Icons.person),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                controller: _nameTextController,
                                validator: (value) {
                                  if (value == null) {
                                    return "The name cannot be empty";
                                  } else {
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
                                  icon: Icon(Icons.email),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailTextController,
                                validator: (value) {
                                  if (value != null) {
                                    RegExp regex = RegExp(
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                                    if (!regex.hasMatch(value)) {
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
                                    labelText: "Address *",
                                    hintText: "Street name, City, Country",
                                    icon: Icon(Icons.location_city),
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.streetAddress,
                                  controller: _addressController,
                                  validator: (value) {
                                    if (value == null) {
                                      return "The address cannot be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
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
                                    labelText: "Phone number *",
                                    hintText: "+91456372231",
                                    icon: Icon(Icons.phone),
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.phone,
                                  controller: _phoneController,
                                  validator: (value) {
                                    if (value == null) {
                                      return "The phone number cannot be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
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
                                    labelText: "Delivery Mode *",
                                    hintText: "Home Delivery/ Pickup",
                                    icon: Icon(Icons.delivery_dining),
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.text,
                                  controller: _deliveryController,
                                  validator: (value) {
                                    if (value == null) {
                                      return "The Delivery Mode cannot be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(50.0, 17.0, 50.0, 5.0),
                          child: Material(
                              borderRadius: BorderRadius.circular(50.0),
                              color: Colors.blueAccent.withOpacity(0.8),
                              elevation: 0.5,
                              child: MaterialButton(
                                onPressed: () async {
                                  handleCheck();
                                },
                                minWidth: MediaQuery.of(context).size.width,
                                child: const Text(
                                  "Payment",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void handleCheck() {
    FormState? formState = _formKey.currentState;

    if (formState?.validate() != null) {
      Navigator.of(context).push(MaterialPageRoute(
        // passing the values of the product to the product details page
          builder: (context) => Payment(
            cart: widget.cart,
            customer_name: _nameTextController.text,
            customer_email: _emailTextController.text,
            customer_phone: _phoneController.text,
            customer_address: _addressController.text,
            delivery: _deliveryController.text,
          )));
    }
  }
}
