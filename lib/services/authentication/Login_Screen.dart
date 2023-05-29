import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:product_distribution/component/Utils.dart';
import 'package:product_distribution/constants/firebase_references.dart';
import 'package:product_distribution/screens/Home_Screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../component/App_Button.dart';
import '../../component/Input_text_field.dart';
import '../../component/background_Color.dart';
import '../../component/validate.dart';
import '../../constants/AppColors.dart';
import '../../orderbookerApp/order_booker_screen.dart';
import '../../sale_person_app/sale_person_home_screen.dart';
import '../../screens/order_Booker/order_Booker.dart';
import '../../screens/sale_Person/sale_Person.dart';
import '../firebse_Controllers/auth_Controller.dart';
import 'Forgot_Screen.dart';
import 'SignUp_Screen.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {

  bool _loading = false;
  bool hideobscure = true;
  final key = GlobalKey<FormState>();
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  FocusNode EmailFocusNode = FocusNode();
  FocusNode PasswordFocusNode = FocusNode();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Background_Color(childs: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(height: 200,width: double.infinity,
                child: Center(child: Image.asset("assets/login.png",fit: BoxFit.cover,),),),
                space(20),

                Text("Login",style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text("Sign in with your data that you entered during your registration."),
                space(30),
                // Text("Email",style: TextStyle(fontWeight: FontWeight.w500),),
                space(3),

                Input_text_field(myController: EmailController , onFieldSubmittedValue: (newValue) {  },
                    onValidator: (value) {
                      return validateEmail(value);
                    }, hint: 'Email', keyboardType: TextInputType.emailAddress, focusNode: EmailFocusNode,obscureTexts: false),
                SizedBox(height: 13,),
                // Text("Password",style: TextStyle(fontWeight: FontWeight.w500,),),
                space(3),

                Input_text_field(myController: PasswordController , onFieldSubmittedValue: (newValue) {  },sufixicon: InkWell(onTap: () {paswod();},
                  child: Icon(hideobscure?Icons.visibility_off : Icons.visibility,
                    color: AppColors.orange,size: 20),),
                    onValidator: (value) {
                      if(value.toString().isEmpty){
                        return "password is empty";
                      }else if(value.toString().length < 6){
                        return "password must be grater then 6 characters";
                      }else{
                        return null;
                      }
                    }, hint: 'min. 6 characters', keyboardType: TextInputType.emailAddress, focusNode: PasswordFocusNode,obscureTexts: hideobscure),
                space(30),
                // ChangeNotifierProvider(create: (_) => Login_Controller(),
                //   child: Consumer<Login_Controller>(builder: (context, Provider, child) {
                //     return App_button(tltle: "Login " , loading: Provider.loading,onPress: () {
                //       if(key.currentState!.validate()){
                //         Provider.LoginControllers(EmailController.text, PasswordController.text,);
                //
                //       }
                //     },);
                //
                //   },),),
                App_button(onPress: () {
                  if(key.currentState!.validate()){
                    LoginControllers(email: EmailController.text,password: PasswordController.text);
                  }
                }, tltle: "Login", loading: _loading),
                space(3),
                // Row(mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     InkWell(onTap: () {
                //
                //     },
                //         child: InkWell(onTap: () {
                //           Get.to(Forgot_Screen());
                //         },
                //             child: Text("Forgot Password?",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blue),))),
                //   ],
                // ),

                space(40),
                // Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text("Don't have an account"),
                //     InkWell(onTap: () {
                //       Get.to(SignUp_Screen());
                //     },
                //         child: Text(" Sign up?",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.blue),)),
                //   ],
                // ),)

              ],
            ),
          ),
        ),
      ),)
    );

  }
  paswod() {
    setState(() {
      hideobscure = !hideobscure;
    });
  }
  Widget space(double height){
   return SizedBox(height: height,);
  }

  checkUser() async {
    SharedPreferences shrf = await SharedPreferences.getInstance();
    String? user  = shrf.getString('usertype');
    String? userId  = shrf.getString('userId');

    if(user == 'admin'){
      Get.off(()=> Home_Screen());
    }else if(user == 'booker'){
      Get.off(()=> OrderBookerScreen());
    }else if(user == 'saleperson'){
      Get.off(()=> SalePersonHomeScreen());
    }else{
      print("NA");
    }

  }

  void LoginControllers({String? email, String? password})async{
    SharedPreferences shrf = await SharedPreferences.getInstance();
    setState(() {
    _loading = true;
        });
  if(email == "admin@gmail.com" && password == "admin1234"){
    shrf.setString('usertype',  'admin');
    FirebaseAuth.instance.signInWithEmailAndPassword(email: 'admin@gmail.com', password: 'admin1234').then((value){
      Utils().flushBarMessage("Admin Login Successfully", Icons.error_outline);
      Get.off(()=>Home_Screen());
    }).catchError((e){
      Utils().flushBarMessage("Email password incorrect", Icons.error_outline);
      setState(() {
        _loading = false;
      });
    }).onError((error, stackTrace){
      Utils().flushBarMessage("Email password incorrect", Icons.error_outline);
      setState(() {
        _loading = false;
      });
    });

    setState(() {
      _loading = false;
    });
  }else{

    String? orderBookerId;
    String? salePersonId;

    QuerySnapshot querySnapshot = await FirebaseReferences().order_bookersReference.get();
    List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    var lst = allData.where((element) => element["email"] == email).toList();
    orderBookerId = lst.isEmpty ? "null" : lst[0]['id'];


    QuerySnapshot querySnapshot2 = await FirebaseReferences().sale.get();
    List allData2 = querySnapshot2.docs.map((doc) => doc.data()).toList();
    var lst2 = allData2.where((element) => element["email"] == email).toList();
    salePersonId = lst2.isEmpty ? "null" : lst2[0]['id'];

 setState(() {
   _loading = false;
 });
    if(orderBookerId!="null"){
      DocumentSnapshot documentSnapshot = await FirebaseReferences().order_bookersReference.doc(orderBookerId).get();
      if(documentSnapshot['email'] == email){

        setState(() {
          _loading = false;
        });
        if(documentSnapshot['password'] == password){
          shrf.setString('userId',  orderBookerId!);
          shrf.setString('usertype',  'booker');
          Get.off(()=> OrderBookerScreen());
          setState(() {
            _loading = false;
          });
        }
      }
    }else{
      if(salePersonId!="null"){
        DocumentSnapshot documentSnapshot2 = await FirebaseReferences().sale.doc(salePersonId).get();
        if(documentSnapshot2['email'] == email){
          setState(() {
            _loading = false;
          });
          if(documentSnapshot2['password'] == password){
            shrf.setString('userId',  salePersonId!);
            shrf.setString('usertype',  'saleperson');
            Get.off(()=> SalePersonHomeScreen());
            setState(() {
              _loading = false;
            });
          }
        }
      }
    }

  }


    // var collection = FirebaseFirestore.instance.collection('bookerOrder');
    // var querySnapshot = await collection.get();
    // Map<String, dynamic>? data;
    // for (var doc in querySnapshot.docs) {
    //    data = doc.data();
    // }
    //
    // if(data!.containsKey("name3")){
    //   print("true");
    // }else{
    //   print("false");
    // }

  }
}


// final login = await auth.signInWithEmailAndPassword(email: email.toString(), password: password).then((value){
// if(email.toString() == "adman@gmail.com"){
// Get.off(Home_Screen());
// }else if(email.toString() == "delivery@gmail.com"){
// return Get.off(SalePersonHomeScreen());
// }else if(email.toString() == "saleperson@gmail.com"){
// return Get.off(OrderBookerScreen());
// }
// } );