import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../component/Utils.dart';
import '../../component/background_Color.dart';
import '../../component/custom_App_bar.dart';
import '../../constants/AppColors.dart';
import '../../constants/app_image.dart';
import '../../constants/firebase_references.dart';
import 'order_more_details.dart';

class History_Screen extends StatefulWidget {
  const History_Screen({Key? key}) : super(key: key);

  @override
  State<History_Screen> createState() => _History_ScreenState();
}

class _History_ScreenState extends State<History_Screen> {

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.appBar(
          text: "ORDER HISTORY",
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
                        .where('status', isEqualTo: 'completed').snapshots()
                        : FirebaseReferences().orders
                        .where('status', isEqualTo: 'completed')
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
                                            leading:Icon(
                                              Icons.check_circle,
                                              size: 50,
                                              color: AppColors.white,
                                            ),
                                            onTap: () {
                                              Get.to(order_detail(
                                                id: snapshot.data!.docs[index]['id'],
                                              ));
                                            },
                                            trailing:CircleAvatar(
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
                                              "${snapshot.data!.docs[index]['shopkeeperName']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.white),
                                            ),
                                          )),
                                      decoration: BoxDecoration(
                                          color: AppColors.green,
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
  Widget Space(double? height){
    return SizedBox(height: height,);
  }
}
