import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:maam_riffat_mid_task/model/product.dart';
import 'package:maam_riffat_mid_task/screens/productAdd.dart';
import 'package:maam_riffat_mid_task/screens/productUpdate.dart';

class productView extends StatefulWidget {
  const productView({super.key});

  @override
  State<productView> createState() => _productViewState();
}

class _productViewState extends State<productView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 45, 157, 209),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return productAdd();
            },
          )).then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(),
      body: Container(
          height: 800,
          width: double.infinity,
          child: ListView.builder(
            itemCount: products.plist.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      leading: Text(products.plist[index].pname),
                      title: Column(children: [
                        Text("condition ${products.plist[index].condition}"),
                        SizedBox(height: 5),
                        Text("price ${products.plist[index].price}"),
                        SizedBox(height: 5,),
                        Text("QTY ${products.plist[index].pqty}")
                       
                      ]),
                     
                      trailing: Wrap(spacing: 12, children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return productUpdate(
                                      obj: products.plist[index]);
                                },
                              )).then((value) {
                                setState(() {});
                              });
                            },
                            icon: Icon(Icons.update)),
                        IconButton(
                            onPressed: () {
                              products.plist.removeAt(index);
                              setState(() {});
                            },
                            icon: Icon(Icons.delete))
                      ]),
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }

  void deleteItem(index) {
    for (int i = 0; i < products.plist.length; i++) {
      if (products.plist[index].ID == products.plist[i].ID)
        products.plist.removeAt(i);
    }
    setState(() {});
  }
}
