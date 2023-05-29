import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/App_Button.dart';
import '../component/Input_text_field.dart';
import '../component/background_Color.dart';
import '../component/custom_App_bar.dart';
import '../constants/AppColors.dart';
import '../constants/app_image.dart';
import '../constants/firebase_references.dart';
import '../screens/order_Booker/order_more_details.dart';
import 'delivery_app_full_detail_screen.dart';
import 'order_completed_detail.dart';

class SalePersonCompletedScreen extends StatefulWidget {
  const SalePersonCompletedScreen({Key? key}) : super(key: key);

  @override
  State<SalePersonCompletedScreen> createState() => _SalePersonCompletedScreenState();
}

class _SalePersonCompletedScreenState extends State<SalePersonCompletedScreen> {
  final key = GlobalKey<FormState>();
  final shop_Name_Controller = TextEditingController();
  final shopkeeper_NameController = TextEditingController();
  final phone_Controller = TextEditingController();
  final cnic_Controller = TextEditingController();
  final address_Controller = TextEditingController();
  final product_ordered_Controller = TextEditingController();
  final price_Controller = TextEditingController();
  final order_date_Controller = TextEditingController();
  final delivery_date_Controller = TextEditingController();

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
          text: "COMPLETE ORDER",
          onPressed: () => Get.back(),
        ),
        body: Background_Image(
          images: AppImages.delivery,
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
                        .where('completedBy',isEqualTo: id)
                        .where('status', isEqualTo: 'completed').snapshots()
                        : FirebaseReferences().orders
                        .where('completedBy',isEqualTo: id)
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
                              int w = int.parse(snapshot.data!.docs[index]['price']);
                              int c = int.parse(snapshot.data!.docs[index]['pay']);
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      width: double.infinity,
                                      child: Center(
                                          child: ListTile(
                                            onTap: () {
                                              Get.to(DeliveryAppFullDetailScreen(
                                                pay: "${w-c}",
                                                id:  snapshot.data!.docs[index]['id'],));
                                            },
                                            trailing: Icon(
                                              Icons.check_circle,
                                              size: 50,
                                              color: AppColors.white,
                                            ),
                                            title: Text(
                                              "${snapshot.data!.docs[index]['shopName']}",
                                              style: TextStyle(
                                                  fontSize: 27,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.white),
                                            ),
                                            subtitle:     FittedBox(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Total :${snapshot.data!.docs[index]['price']}  "
                                                        "Payed :${snapshot.data!.docs[index]['pay']}  ",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: AppColors.white),maxLines: 1,
                                                  ),
                                                  Text(
                                                    "Pay :${w-c}",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: AppColors.white),
                                                  ),
                                                ],
                                              ),
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

  getData() async {
    SharedPreferences shrf = await SharedPreferences.getInstance();
    String? userId = shrf.getString('userId');
    id = userId;
    print(id);
    setState(() {

    });
  }
}
