import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:product_distribution/constants/firebase_references.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/Utils.dart';
import '../component/background_Color.dart';
import '../component/custom_App_bar.dart';
import '../constants/AppColors.dart';
import '../constants/app_image.dart';
import '../screens/order_Booker/order_more_details.dart';

class OrderBookerOrderDetails extends StatefulWidget {
  const
  OrderBookerOrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderBookerOrderDetails> createState() => _OrderBookerOrderDetailsState();
}

class _OrderBookerOrderDetailsState extends State<OrderBookerOrderDetails> {
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  String? id;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.appBar(
          text: "ORDER DETAIL",
          onPressed: () => Get.back(),
        ),
        body: Background_Image(
          images: AppImages.ordernow,
          childs: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: AppColors.white),
                    height: 100,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: startDateController,
                              decoration: InputDecoration(hintText: "Day/Month/Year",
                                  labelText: "Select Start Date"),
                              onChanged: (value) {
                                setState(() {
                                  startDateController.text.toString();
                                  endDateController.text.toString();
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 20,),
                          // Expanded(
                          //   child: TextFormField(
                          //     keyboardType: TextInputType.phone,
                          //     controller: endDateController,
                          //     decoration: InputDecoration(hintText: "Day/Month/Year",labelText: "Select End Date"),
                          //     onChanged: (value) {
                          //       setState(() {
                          //         startDateController.text.toString();
                          //         endDateController.text.toString();
                          //       });
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: startDateController.text.isEmpty ?
                    FirebaseReferences().orders
                        .where('orderBy',isEqualTo: id)
                        .where('status', isEqualTo: 'pending').snapshots()
                        : FirebaseReferences().orders
                        .where('orderBy',isEqualTo: id)
                        .where('status', isEqualTo: 'pending')
                        .where('orderDate', isEqualTo: startDateController.text)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.size,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      width: double.infinity,
                                      child: Center(
                                          child: ListTile(
                                            onTap: () {
                                              Get.to(order_detail(
                                                id: snapshot.data!.docs[index]['id'],
                                              ));
                                            },
                                            trailing: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: IconButton(
                                                onPressed: () {
                                                  Utils().exit_app_dialog(context,"Do you want to delete this product",

                                                        () {FirebaseReferences().orders.doc(snapshot.data!.docs[index]['id']).delete();
                                                    Get.back();},
                                                  );
                                                },
                                                icon: Icon(Icons.delete,color: Colors.red,),
                                              ),
                                            ),
                                            title: Text(
                                              "${snapshot.data!.docs[index]['shopName']}",
                                              style: TextStyle(
                                                  fontSize: 27,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.white),
                                            ),
                                            subtitle: Text(
                                              "${snapshot.data!.docs[index]['address']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.white),
                                            ),
                                          )),
                                      decoration: BoxDecoration(
                                          color: AppColors.blue,
                                          borderRadius: BorderRadius.circular(20)),
                                    ),
                                  ),
                                ],
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
                ),
              ],
            ),
          ),
        ));
  }

  getData() async {
    SharedPreferences shrf = await SharedPreferences.getInstance();
    String? userId = shrf.getString('userId');
    id = userId;
    print(id);
    setState(() {});
  }

}
