
import 'package:blood_donation/constants/color.dart';
import 'package:flutter/material.dart';

Widget Homecontainer(context,String image,String name,){
  return Container(
    width:MediaQuery.of(context).size.width*.8,
    height:MediaQuery.of(context).size.height*.2,
    decoration:BoxDecoration(
      image:DecorationImage(
        image:AssetImage(image),fit:BoxFit.fill,
      ),
      borderRadius:BorderRadius.circular(30),
    ),
    child:Center(child: Text(name,style:TextStyle(fontSize:30,fontWeight:FontWeight.w900,color:Colours.white),)),
  );
}

// Widget Homecard(context,String image){
//   return Card(
//     shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20)
//     ),
//     color:Colors.transparent,
//     elevation: 0,
//     child: ClipRRect(
//       borderRadius:BorderRadius.circular(20),
//       child: SizedBox(
//         width:MediaQuery.of(context).size.width*.15,
//         height:MediaQuery.of(context).size.height*.08,
//         child:Image.asset(image,fit:BoxFit.fill,),
//       ),
//     ),
//   );
// }










// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
//
// import '../../../constants/color.dart';
//
// Widget Homecontainer(String name,context, ){
//   return Container(
//     height: 150,
//     width: MediaQuery.of(context).size.width,
//     decoration: BoxDecoration(
//         color:Colours.lightRed,
//
//     //     boxShadow: [
//     //       BoxShadow(
//     //         color:Colors.black,
//     //         offset:Offset(10,10),
//     //         // blurRadius: 10,
//     //         // spreadRadius:10,
//     //       ),
//     //
//     //     ],
//     //     border:Border.all(
//     //       color:Colours.red,
//     //
//     //       width: 3,
//     //     )
//     ),
//     child: Column(
//       children: [
//         Container(
//           height:100 ,
//           decoration:BoxDecoration(
//             color:Colours.red,
//             boxShadow:[
//               BoxShadow(
//                 offset:Offset(1,1)
//               ),
//
//             ],
//
//           ),
//         ),
//         Text(name,style:TextStyle(fontSize:28,color:Colours.white),)
//       ],
//     ),
//   );
//
// }
