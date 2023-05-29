import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/App_Button.dart';
import '../component/Input_text_field.dart';
import '../component/custom_App_bar.dart';
import '../component/reusbale_row.dart';
import '../constants/AppColors.dart';
import '../constants/firebase_references.dart';


class DeliveryAppFullDetailScreen extends StatefulWidget {
  final String? id,pay;
  const DeliveryAppFullDetailScreen({Key? key, this.id, this.pay}) : super(key: key);

  @override
  State<DeliveryAppFullDetailScreen> createState() => _DeliveryAppFullDetailScreenState();
}

class _DeliveryAppFullDetailScreenState extends State<DeliveryAppFullDetailScreen> {
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
  final payController = TextEditingController();
  final quantityController = TextEditingController();
  final orderCompleteController = TextEditingController();

  data() async {
    var doc = await FirebaseReferences().orders.doc(widget.id).get();
    shop_Name_Controller.text = doc['shopName'];
    shopkeeper_NameController.text = doc['shopkeeperName'];
    phone_Controller.text = doc['phone'];
    cnic_Controller.text = doc['cnic'];
    address_Controller.text = doc['address'];
    product_ordered_Controller.text = doc['products'];
    price_Controller.text = doc['price'];
    delivery_date_Controller.text = doc['deliveryDate'];
    payController.text = doc['pay'];
    order_date_Controller.text = doc['orderDate'];
    quantityController.text = doc['quantity'];
    orderCompleteController.text = doc['status'];
    setState(() {});
  }
  @override
  void initState() {
    data();
    super.initState();
  }


  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(
        text: "MORE DETAIL",
        onPressed: () => Get.back(),
      ),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Space(30),
                ReusbaleRow(value: "Shop Name",iconData: Icons.person,onPress: () {},value1:shop_Name_Controller.text ),
                Space(20),
                ReusbaleRow(value: "Shopkeeper Name",iconData: Icons.person,onPress: () {},value1:shopkeeper_NameController.text ),
                Space(20),
                ReusbaleRow(value: "Phone ",iconData: Icons.phone,onPress: () {},value1:phone_Controller.text ),
                Space(20),
                ReusbaleRow(value: "CNIC",iconData: Icons.perm_contact_cal,onPress: () {},value1:cnic_Controller.text ),
                Space(20),
                ReusbaleRow(value: "Address",iconData: Icons.maps_home_work,onPress: () {},value1:address_Controller.text ),
                Space(20),
                ListTile(
              leading:Icon(Icons.production_quantity_limits),
                    title:Text("Product :  ${product_ordered_Controller.text}",
                        style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),),
                Space(20),
                ReusbaleRow(value: "Price",iconData: Icons.price_check,onPress: () {},value1:price_Controller.text ),
                Space(20),
                ReusbaleRow(value: "Order Date",iconData: Icons.date_range,onPress: () {},value1:order_date_Controller.text ),
                Space(30),
                ReusbaleRow(value: "Delivery Date",iconData: Icons.date_range,onPress: () {},value1:delivery_date_Controller.text ),
                Space(20),
                ReusbaleRow(value: "Pay",iconData: Icons.price_check,onPress: () {},value1:payController.text ),
                Space(10),
                ReusbaleRow(value: "Payed",iconData: Icons.payment,onPress: () {},value1:widget.pay.toString() ),
                Space(10),
                ReusbaleRow(value: "Quantity",iconData: Icons.query_stats,onPress: () {},value1:quantityController.text ),
                Space(10),
                ReusbaleRow(value: "Order Delivery",iconData: Icons.delivery_dining,onPress: () {},value1:orderCompleteController.text ),
                Space(10),
                // App_button(
                //     onPress: () async {
                //       SharedPreferences shrf = await SharedPreferences.getInstance();
                //       String? userId = shrf.getString('userId');
                //       setState(() {
                //         loading = true;
                //       });
                //       FirebaseReferences().orders.doc(widget.id).update({
                //         'shopName' : shop_Name_Controller.text,
                //         'shopkeeperName' : shopkeeper_NameController.text,
                //         'phone' : phone_Controller.text,
                //         'cnic' : cnic_Controller.text,
                //         'address' : address_Controller.text,
                //         'products' : product_ordered_Controller.text,
                //         'price' : price_Controller.text,
                //         'pay' : payedPriceController.text,
                //         'orderDate' :  order_date_Controller.text,
                //         'status' : 'completed',
                //          'completedBy' : userId,
                //       }).then((value) {
                //         setState(() {
                //           loading = false;
                //         });
                //         Get.back();
                //       });
                //     },
                //     tltle: "EDIT",
                //     color: Colors.green,
                //     loading: loading),
                Space(10),
                App_button(
                    onPress: () {
                      Get.back();
                    },
                    tltle: "BACK",
                    loading: false),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget Space(double? height) {
    return SizedBox(
      height: height,
    );
  }
}
