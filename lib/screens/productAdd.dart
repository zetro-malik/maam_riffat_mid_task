import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:maam_riffat_mid_task/model/product.dart';

class productAdd extends StatefulWidget {
  const productAdd({super.key});

  @override
  State<productAdd> createState() => _productAddState();
}

class _productAddState extends State<productAdd> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController qty = TextEditingController();

  String gval = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                "Add Product",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(height: 50),
              Container(
                height: 400,
                width: 300,
                child: Column(children: [
                  Expanded(child: CustomTextForm(name, "product name", null)),
                  SizedBox(height: 5),
                  Expanded(child: CustomTextForm(price, "product price", null)),
                  SizedBox(height: 5),
                  Expanded(
                      child: CustomTextForm(qty, "product quantity", null)),
                  Row(
                    children: [
                      Expanded(
                          child: RadioListTile(
                        title: Text("new"),
                        value: "new",
                        groupValue: gval,
                        onChanged: (value) {
                          setState(() {
                            gval = "new";
                          });
                        },
                      )),
                      SizedBox(width: 20),
                      Expanded(
                          child: RadioListTile(
                        title: Text("old"),
                        value: "old",
                        groupValue: gval,
                        onChanged: (value) {
                          setState(() {
                            gval = "old";
                          });
                        },
                      ))
                    ],
                  ),
                  SizedBox(height: 40),
                  CustomElevatedButton(() {
                    products.plist.add(Product(
                        ID: products.plist.length + 1,
                        pname: name.text,
                        pqty: int.parse(qty.text),
                        price: int.parse(price.text),
                        condition: gval));
                    setState(() {});
                    Navigator.pop(context);
                  }, "Add Product")
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton CustomElevatedButton(func, String msg) {
    return ElevatedButton(
        onPressed: func,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          primary: Colors.blue.shade400,
          shape: const StadiumBorder(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            msg,
            style: TextStyle(fontSize: 24),
          ),
        ));
  }

  TextFormField CustomTextForm(TextEditingController con, String msg, func) {
    return TextFormField(
      controller: con,
      decoration: InputDecoration(
        labelText: msg,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: new BorderSide(),
        ),
        //fillColor: Colors.green
      ),
      validator: func,
      style: new TextStyle(
        fontFamily: "Poppins",
      ),
    );
  }
}
