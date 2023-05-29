import 'package:flutter/material.dart';

class ReusbaleRow extends StatelessWidget {
  final String value,value1;
  IconData iconData ;
  IconData? iconData1;
  VoidCallback? onPress ;
  ReusbaleRow({required this.value,required this.iconData,  this.iconData1,this.onPress, required this.value1});

  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        ListTile(title: Text(value,style: TextStyle(fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,),leading:
         Icon(iconData),trailing:Text(value1,style: TextStyle(fontSize: 16)),),
      ],
    );
  }
}
