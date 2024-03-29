import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:product_distribution/component/App_Button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../component/Utils.dart';
import '../../component/background_Color.dart';
import '../../component/custom_App_bar.dart';
import '../../constants/AppColors.dart';
import '../../constants/app_image.dart';
import '../../constants/firebase_references.dart';
import 'order_more_details.dart';

class Order_Detail extends StatefulWidget {
  const Order_Detail({Key? key}) : super(key: key);

  @override
  State<Order_Detail> createState() => _Order_DetailState();
}

class _Order_DetailState extends State<Order_Detail> {

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();




  @override
  void initState() {
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
          images: AppImages.admin,
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
                              decoration: InputDecoration(hintText: "02/12/2023",
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
                          //     keyboardType: TextInputType.datetime,
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
                  child: StreamBuilder(
                    stream: startDateController.text.isEmpty ?
                    FirebaseReferences().orders
                        .where('status', isEqualTo: 'pending').snapshots()
                        : FirebaseReferences().orders
                        .where('status', isEqualTo: 'pending')
                        .where('orderDate', isEqualTo: startDateController.text)
                        .snapshots(),
                    builder: (context, snapshot) {
                      assert(snapshot != null);
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
}
