import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mi_partner_app/pages/success.dart';

class Payment extends StatefulWidget {
  final cart;
  final customer_name;
  final customer_email;
  final customer_phone;
  final customer_address;
  final delivery;

  const Payment({
    this.cart,
    this.customer_name,
    this.customer_email,
    this.customer_phone,
    this.customer_address,
    this.delivery,
  });

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  var value;

  final Paymentlables = [
    'Credit card/ Debit card',
    'Paytm',
    'Google Pay',
    'Paypal',
    'Cash'
  ];
  final Payemnticons = [
    Icons.credit_card,
    Icons.payments_outlined,
    Icons.payments,
    Icons.paypal,
    Icons.money,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: const Text("Payment", style: TextStyle(color: Colors.white),),
        elevation: 0.8,
      ),
      body: Column(

        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Text("Choose The Payment Method", style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20.0)),
          ),
          Expanded(
            child: ListView.separated(itemBuilder: (context, index) {
              return ListTile(
                leading: Radio(
                  value: index,
                  activeColor: Colors.redAccent,
                  groupValue: value, onChanged: (i) {
                  setState(() {
                    value = i;
                  });
                },
                ),
                title: Text(Paymentlables[index],
                    style: const TextStyle(color: Colors.black)),
                trailing: Icon(Payemnticons[index], color: Colors.blueGrey,),
              );
            }, separatorBuilder: (context, index) {
              return const Divider();
            }, itemCount: Paymentlables.length),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),

            child: Material(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.blueAccent.withOpacity(0.8),
                elevation: 0.5,
                child: MaterialButton(
                  onPressed: () {
                    handleCheck();
                  },
                  minWidth: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: const Text("Payment Received", textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,),
                  ),
                )
            ),),
        ],),
    );
  }

  void handleCheck() {
    Fluttertoast.showToast(msg: "Payment Successful");
      Navigator.of(context).push(MaterialPageRoute(
        // passing the values of the product to the product details page
          builder: (context) =>
              Success(
                cart: widget.cart,
                customer_name: widget.customer_name,
                customer_email: widget.customer_email,
                customer_phone: widget.customer_phone,
                customer_address: widget.customer_address,
                delivery: widget.delivery,
                payment: Paymentlables[value],
              )));
  }
}
