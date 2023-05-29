import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:product_distribution/component/Utils.dart';
import 'package:product_distribution/constants/firebase_references.dart';
import 'package:product_distribution/orderbookerApp/order_booker_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/App_Button.dart';
import '../component/Input_text_field.dart';
import '../component/custom_App_bar.dart';
import '../constants/AppColors.dart';

class OrderBookerOrderDetailsScreen extends StatefulWidget {
  List? selectedProd = [];
  int? totalPrice;
  OrderBookerOrderDetailsScreen({this.selectedProd, this.totalPrice,Key? key}) : super(key: key);

  @override
  State<OrderBookerOrderDetailsScreen> createState() => _OrderBookerOrderDetailsScreenState();
}

class _OrderBookerOrderDetailsScreenState extends State<OrderBookerOrderDetailsScreen> {

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


  @override
  void initState() {
    order_date_Controller.text =  "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    product_ordered_Controller.text = widget.selectedProd!.toList().toString();
    price_Controller.text  = widget.totalPrice.toString();
    quantityController.text = '0';
    // for(var i in widget.selectedProd!.toList()){
    //   product_ordered_Controller.text = i;
    // }
    super.initState();
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: CustomAppBar.appBar(text: "ORDERS",onPressed: () {
        Get.back();
      },),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
              Space(30),
              Input_text_field(myController: shop_Name_Controller,onValidator: (value) {
                if(shop_Name_Controller.text == null || shop_Name_Controller.text.isEmpty ){
                  return "Shop Name is Empty";
                }

              },
                focusNode: null ,hint: "Shop name" ,keyboardType:TextInputType.name ,obscureTexts: false,onFieldSubmittedValue: (newValue) {},),
              Space(20),
              Input_text_field(myController: shopkeeper_NameController,onValidator: (value) {
                if(shopkeeper_NameController.text == null || shopkeeper_NameController.text.isEmpty ){
                  return "Shopkeeper Name is Empty";
                }

              },
                focusNode: null ,hint: "Shopkeeper Name" ,keyboardType:TextInputType.name ,obscureTexts: false,onFieldSubmittedValue: (newValue) {},),
              Space(20),
              Input_text_field(myController: phone_Controller,onValidator: (value) {
                if(phone_Controller.text == null || phone_Controller.text.isEmpty ){
                  return "Phone is Empty";
                }

              },
                focusNode: null ,hint: "Phone Number" ,keyboardType:TextInputType.phone ,obscureTexts: false,onFieldSubmittedValue: (newValue) {},),
              Space(20),
              Input_text_field(myController: cnic_Controller,onValidator: (value) {
                if(cnic_Controller.text == null || cnic_Controller.text.isEmpty ){
                  return "Cnic is Empty";
                }

              },
                focusNode: null ,hint: "CNIC" ,keyboardType:TextInputType.phone ,obscureTexts: false,onFieldSubmittedValue: (newValue) {},),
              Space(20),
              Input_text_field(myController: address_Controller,onValidator: (value) {
                if(address_Controller.text == null || address_Controller.text.isEmpty ){
                  return "Address is Empty";
                }

              },
                focusNode: null ,hint: "Address" ,keyboardType:TextInputType.emailAddress ,obscureTexts: false,onFieldSubmittedValue: (newValue) {},),
              Space(20),
              TextFormField(
                validator: (value) {
                  if(product_ordered_Controller.text == null || product_ordered_Controller.text.isEmpty ){
                    return "Product is Empty";
                  }

                },
                controller: product_ordered_Controller,
                cursorHeight: 30,
                cursorColor: AppColors.orange,
                minLines: 3,
                maxLines: 10,
                decoration: InputDecoration(
                  label:  Text("Product ordered"),
                  contentPadding:  EdgeInsets.symmetric(horizontal: 20, vertical:5 ),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 1, color: Colors.grey),),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 1, color:  AppColors.orange),
                  ),
                ),
              ),
              Space(20),
              Input_text_field(myController: price_Controller,onValidator: (value) {
                if(price_Controller.text == null || price_Controller.text.isEmpty ){
                  return "Price is Empty";
                }

              },
                focusNode: null ,hint: "Price" ,keyboardType:TextInputType.phone ,obscureTexts: false,onFieldSubmittedValue: (newValue) {},),
              Space(20),
              Input_text_field(myController: quantityController,onValidator: (value) {
                if(quantityController.text == null || quantityController.text.isEmpty ){
                  return "quantityController is Empty";
                }

              },
                focusNode: null ,hint: "Quantity" ,keyboardType:TextInputType.phone ,obscureTexts: false,onFieldSubmittedValue: (newValue) {},),
              Space(20),
              Input_text_field(
                myController: order_date_Controller,onValidator: (value) {  if(order_date_Controller.text == null || order_date_Controller.text.isEmpty ){
                return "Order is Empty";
              }},
                focusNode: null ,hint: "Order date" ,keyboardType:TextInputType.name ,obscureTexts: false,onFieldSubmittedValue: (newValue) {},),
                Space(20),
              Input_text_field(myController: delivery_date_Controller,
                onValidator: (value) {  if(delivery_date_Controller.text == null || delivery_date_Controller.text.isEmpty ){
                return "Delivery is Empty";
              }},
                focusNode: null ,hint: "Delivery date" ,keyboardType:TextInputType.name ,obscureTexts: false,onFieldSubmittedValue: (newValue) {},),

              Space(40),
              App_button(onPress: () async {
               if(key.currentState!.validate()){
                Utils().exit_app_dialog(context, "Do you want to book this order", () {
                  addOrder();
                  Get.back();
                });
               }
              }, tltle: "SAVE", loading: loading),
              Space(10),
              App_button(onPress: () {
                Get.back();
              }, tltle: "BACK", loading: false)

            ],),
          ),
        ),
      ),
    );
  }
  Widget Space(double? height){
    return SizedBox(height: height,);
  }

  addOrder() async{
    SharedPreferences shrf = await SharedPreferences.getInstance();
    String? userId = shrf.getString('userId');
    setState(() {
      loading = true;
    });
    await FirebaseReferences().orders.add({
      'shopName' : shop_Name_Controller.text,
      'shopkeeperName' : shopkeeper_NameController.text,
      'phone' : phone_Controller.text,
      'cnic' : cnic_Controller.text,
      'address' : address_Controller.text,
      'products' : product_ordered_Controller.text,
      'price' : price_Controller.text,
      'pay' : "0",
      'orderDate' :  "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
      'dateFilter' : DateTime.now().day.toInt(),
      'orderBy' : userId,
      'status' : 'pending',
      'quantity' : quantityController.text,
      'deliveryDate' : delivery_date_Controller.text
    }).then((value){
      value.update({'id': value.id,}).then((value){
        Utils().flushBarMessage("Product has been completed" , Icons.check_circle);
      });
    });
    Get.back();
  }

}
