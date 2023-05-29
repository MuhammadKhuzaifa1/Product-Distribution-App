// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:pd_project/screens/Home_Screen.dart';
// import 'package:pd_project/component/background_Color.dart';
// import '../../component/App_Button.dart';
// import '../../component/Input_text_field.dart';
// import '../../constants/AppColors.dart';
// import '../../delivery_app/sale_person_home_screen.dart';
// import '../../orderbookerApp/order_booker_screen.dart';
// import '../../screens/order_Booker/order_Booker.dart';
// import '../../screens/sale_Person/sales_Person.dart';
// import 'Login_Screen.dart';
//
// class SignUp_Screen extends StatefulWidget {
//   const SignUp_Screen({Key? key}) : super(key: key);
//
//   @override
//   State<SignUp_Screen> createState() => _SignUp_ScreenState();
// }
//
// class _SignUp_ScreenState extends State<SignUp_Screen> {
//   bool _loading = false;
//   bool hideobscure = true;
//   final key = GlobalKey<FormState>();
//   final NameController = TextEditingController();
//   final PhoneController = TextEditingController();
//   final EmailController = TextEditingController();
//   final PasswordController = TextEditingController();
//   FocusNode EmailFocusNode = FocusNode();
//   FocusNode PasswordFocusNode = FocusNode();
//   FocusNode NameFocusNode = FocusNode();
//   FocusNode PhoneFocusNode = FocusNode();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Background_Color(
//           childs:
//           Padding(
//           padding: const EdgeInsets.all(10),
//           child: SingleChildScrollView(
//             child: Column(mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 space(25),
//                 Text("Sign Up",style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold),),
//                 space(30),
//
//                 Text("Name",style: TextStyle(fontWeight: FontWeight.w500),),
//                 space(3),
//                 Input_text_field(myController: NameController , onFieldSubmittedValue: (newValue) {  },
//                     onValidator: (value) {  }, hint: "name", keyboardType: TextInputType.name, focusNode: NameFocusNode,obscureTexts: false),
//
//                 space(15),
//
//                 Text("Email",style: TextStyle(fontWeight: FontWeight.w500),),
//                 space(3),
//                 Input_text_field(myController: EmailController , onFieldSubmittedValue: (newValue) {  },
//                     onValidator: (value) {  }, hint: 'name@example.com', keyboardType: TextInputType.emailAddress, focusNode: EmailFocusNode,obscureTexts: false),
//
//                 space(15),
//
//                 Text("Password",style: TextStyle(fontWeight: FontWeight.w500,),),
//                 space(3),
//                 Input_text_field(myController: PasswordController , onFieldSubmittedValue: (newValue) {  },sufixicon: InkWell(onTap: () {paswod();},
//                   child: Icon(hideobscure?Icons.visibility_off : Icons.visibility,
//                       color: AppColors.orange,size: 20),),
//                     onValidator: (value) {  }, hint: 'min. 8 characters', keyboardType: TextInputType.emailAddress, focusNode: PasswordFocusNode,obscureTexts: hideobscure),
//
//                 space(15),
//
//                 Text("Phone Number",style: TextStyle(fontWeight: FontWeight.w500,),),
//                 space(3),
//                 Input_text_field(myController: PhoneController , onFieldSubmittedValue: (newValue) {  },
//                     onValidator: (value) {  }, hint: '11 characters', keyboardType: TextInputType.phone, focusNode: PhoneFocusNode,obscureTexts: false),
//
//
//                 space(40),
//                 App_button(onPress: (){
//                   Get.to(Home_Screen());
//                 },loading: false ,tltle: "Create Account",),
//
//                 space(40),
//                 Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Already have an account"),
//                     InkWell(onTap: () {
//                       Get.to(Login_Screen());
//                     },
//                         child: Text("  Sign in?",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.blue),)),
//                   ],
//                 ),),
//
//
//               ],
//             ),
//           ),
//         ),)
//     );
//   }
//   paswod() {
//     setState(() {
//       hideobscure = !hideobscure;
//     });
//   }
//   Widget space(double height){
//     return SizedBox(height: height,);
//   }
// }
