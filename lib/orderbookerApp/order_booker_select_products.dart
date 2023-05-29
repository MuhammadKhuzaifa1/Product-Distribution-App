import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:product_distribution/orderbookerApp/order_booker_order_details_screen.dart';
import 'package:product_distribution/orderbookerApp/product_detail_image_view_screen.dart';

import '../component/background_Color.dart';
import '../component/custom_App_bar.dart';
import '../constants/AppColors.dart';
import '../constants/app_image.dart';
import '../constants/firebase_references.dart';
import '../screens/products_Detail/add_Product.dart';

class OrderBookerSelectProducts extends StatefulWidget {

  const OrderBookerSelectProducts({Key? key}) : super(key: key);

  @override
  State<OrderBookerSelectProducts> createState() => _OrderBookerSelectProductsState();
}

class _OrderBookerSelectProductsState extends State<OrderBookerSelectProducts> {

  List selectedProducts = [];
  List selectedProductsPrice = [];
  int total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CupertinoButton(
          onPressed: () {
            for(var i in selectedProductsPrice){
              int value = int.parse(i);
              total += value;
            }
            Get.to(OrderBookerOrderDetailsScreen(selectedProd: selectedProducts,totalPrice: total,));
          },
          padding: EdgeInsets.zero,
          child: Container(height: 70,width: double.infinity,child: Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle,size: 40,color: Colors.white,),
              SizedBox(width: 10,),
              Text("SUBMIT",style: TextStyle(fontSize: 30,color: AppColors.white),),
            ],
          )),color: AppColors.blue,),
        ),
        appBar: CustomAppBar.appBar(
          text: "PRODUCT DETAIL",
          onPressed: () => Get.back(),
        ),
        body: Background_Image(
          images: AppImages.ordernow,
          childs: StreamBuilder<QuerySnapshot>(
            stream: FirebaseReferences().products.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: GridView.builder(
                    itemCount: snapshot.data!.size,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 220,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(ProductDetailImageViewScreen(imageurl: snapshot.data!.docs[index]['imageurl'],));
                        },
                        onDoubleTap: () {
                          if(selectedProducts.contains(snapshot.data!.docs[index]['product'])){
                            selectedProducts.remove(snapshot.data!.docs[index]['name']);
                            selectedProductsPrice.remove(snapshot.data!.docs[index]['price']);
                          }else{
                            selectedProducts.add(snapshot.data!.docs[index]['product']);
                            selectedProductsPrice.add(snapshot.data!.docs[index]['price']);
                          }
                          setState(() {});
                        },
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          padding: EdgeInsets.all(15),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.white,),
                                  child: Image.network("${snapshot.data!.docs[index]['imageurl'][0]}",fit: BoxFit.cover,),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "${snapshot.data!.docs[index]['product']}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white),maxLines: 2,overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Text(
                                  "Rs : ${snapshot.data!.docs[index]['price']}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white),maxLines: 1,overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:selectedProducts.contains(snapshot.data!.docs[index]['product']) ? Colors.green :AppColors.blue,
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
