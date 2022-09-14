import 'package:flutter/material.dart';
import 'package:mi_partner_app/pages/home.dart';

// my imports
import 'package:mi_partner_app/model/customer.dart';
import 'package:mi_partner_app/model/invoice.dart';
import 'package:mi_partner_app/model/supplier.dart';

import 'package:mi_partner_app/api/pdf_api.dart';
import 'package:mi_partner_app/api/pdf_invoice_api.dart';

class Success extends StatefulWidget {
  final cart;
  final customer_name;
  final customer_email;
  final customer_phone;
  final customer_address;
  final delivery;
  final payment;

  const Success({
    this.cart,
    this.customer_name,
    this.customer_email,
    this.customer_phone,
    this.customer_address,
    this.delivery,
    this.payment,

  });

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title: const Text("Payment Success", style: TextStyle(color: Colors.white),),
    elevation: 0.8,
    ),
      body: Column(

        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(5.0, 70.0, 5.0, 10.0),
            child: Image(image: AssetImage('images/success.gif'),
            height: 250.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Successful", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0, color: Colors.green)),
          ),
          const Padding(
            padding: EdgeInsets.all(27.0),
            child: Text("Customer Payment done successfully!", textAlign: TextAlign.center,style:TextStyle(fontWeight: FontWeight.w500, color: Colors.blueGrey)),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
            child: Material(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.redAccent.withOpacity(0.8),
                elevation: 0.5,
                child: MaterialButton(
                  onPressed: () async {
                    final date = DateTime.now();
                    final dueDate = date.add(Duration(days: 7));
                    final List<InvoiceItem> item =[];

                    for (var index=0;index<widget.cart.length;index++) {
                        item.add(
                          InvoiceItem(
                              description: widget.cart[index]["name"],
                              date: DateTime.now(),
                              quantity: int.parse(widget.cart[index]["quantity"].toString()),
                              model: widget.cart[index]["model"],
                              unitPrice: double.parse(widget.cart[index]["price"].toString()),
                            )
                        );
                    }
                    final invoice = Invoice(
                      supplier: Supplier(
                        name: 'Xiaomi Stores Inc.',
                        address: '12, Park Street, Kolkata - 700012',
                        paymentInfo: widget.payment,
                        deliveryInfo: widget.delivery,
                        phone: '+917654321543',
                      ),
                      customer: Customer(
                        name: widget.customer_name,
                        address: widget.customer_address,
                        phone: widget.customer_phone,
                        email: widget.customer_email,
                      ),
                      info: InvoiceInfo(
                        date: date,
                        dueDate: dueDate,
                        description: 'My description...',
                        number: '${DateTime.now().year}-9999',
                      ),
                      items: item,
                    );

                    final pdfFile = await PdfInvoiceApi.generate(invoice);

                    PdfApi.openFile(pdfFile);
                  },

                  child: const Text("Generate Invoice", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0,),
                  ),
                )
            ),
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
