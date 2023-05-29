import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../component/App_Button.dart';
import '../../component/Input_text_field.dart';
import '../../component/custom_App_bar.dart';
import '../../component/reusbale_row.dart';
import '../../constants/AppColors.dart';
import '../../constants/firebase_references.dart';

class order_detail extends StatefulWidget {
  final String? id;

  const order_detail({Key? key, this.id}) : super(key: key);

  @override
  State<order_detail> createState() => _order_detailState();
}

class _order_detailState extends State<order_detail> {
  data() async {
    var doc = await FirebaseReferences().orders.doc(widget.id).get();
    shop_Name_Controller.text = doc['shopName'];
    shopkeeper_NameController.text = doc['shopkeeperName'];
    phone_Controller.text = doc['phone'];
    cnic_Controller.text = doc['cnic'];
    address_Controller.text = doc['address'];
    price_Controller.text = doc['price'];
    order_date_Controller.text = doc['orderDate'];
    delivery_date_Controller.text = doc['deliveryDate'];
    product_ordered_Controller.text = doc['products'];
    quantityController.text = doc['quantity'];
    setState(() {
    });
  }

  @override
  void initState() {
    data();
    super.initState();
  }

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
  final quantityController = TextEditingController();
  // final pay_Controller = TextEditingController();

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
                      style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),),                Space(20),
                ReusbaleRow(value: "Price",iconData: Icons.price_check,onPress: () {},value1:price_Controller.text ),
                Space(20),
                ReusbaleRow(value: "Order Date",iconData: Icons.date_range,onPress: () {},value1:order_date_Controller.text ),
                Space(30),
                ReusbaleRow(value: "Delivery Date",iconData: Icons.date_range,onPress: () {},value1:delivery_date_Controller.text ),
                Space(20),
                ReusbaleRow(value: "Quantity",iconData: Icons.query_stats,onPress: () {},value1:quantityController.text ),
                Space(40),
                App_button(
                    onPress: () {
                      Get.back();
                    },
                    tltle: "BACK",
                    loading: false)
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
