// import 'package:flutter/material.dart';

// import '../../../../constants/color.dart';

// class AdminChatPage extends StatelessWidget {
//   const AdminChatPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(

//         appBar:AppBar(
//           title:Text("chats",style:TextStyle(color:Colours.white),),
//           centerTitle:true,
//           backgroundColor:Colours.red,
//           automaticallyImplyLeading: false,
//         ),
//         body:ListView.builder(
//             itemCount: 10,
//             itemBuilder:(context,index){
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ListTile(
//                   leading:CircleAvatar(
//                     backgroundColor: Colors.red.shade400,
//                     radius: 30,
//                     child: Text("photo"),
//                   ),
//                   title:Text("name"),
//                   subtitle:Text("last message"),
//                 ),
//               );
//             })
//     );
//   }
// }