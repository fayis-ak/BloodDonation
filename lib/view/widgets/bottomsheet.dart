import 'package:blood_donation/constants/color.dart';
import 'package:flutter/material.dart';

import '../../constants/color.dart';

class BottomSheetModel extends StatefulWidget {
  final VoidCallback? handeldelete;
  final VoidCallback? pickgallery;
  final VoidCallback? pickcamera;
  final String? bottomsheetname;
  final Icon? iconCamera;
  final Icon? iconGallery;
  final Icon? iconDelete;
  const BottomSheetModel({super.key, this.pickcamera, this.bottomsheetname, this.iconCamera, this.pickgallery, this.iconGallery, this.iconDelete, this.handeldelete,});

  @override
  State<BottomSheetModel> createState() => _BottomSheetModelState();
}

class _BottomSheetModelState extends State<BottomSheetModel> {
  @override
  Widget build(BuildContext context) {

          return Container(
            height:MediaQuery.of(context).size.height*.2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.bottomsheetname??"",
                    style: TextStyle(fontSize:MediaQuery.of(context).size.height*.02),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width:MediaQuery.of(context).size.width*.01,),
                      IconButton(onPressed:widget.pickcamera, icon:Icon(Icons.camera_alt,color:Colours.lightRed,)),
                      IconButton(onPressed:widget.pickgallery, icon:Icon(Icons.folder,color:Colours.lightRed,)),
                      IconButton(onPressed:widget.handeldelete, icon:Icon(Icons.delete,color:Colours.lightRed,)),
                      SizedBox(width:MediaQuery.of(context).size.width*.01,),
                    ],),
                ],
              ),
            ),
          );
    }

}
// //
//
//
//
//  import 'package:flutter/material.dart';
//
// import '../../constants/color.dart';
//
//  <Function> showBottomSheets(BuildContext context,String profilename,VoidCallback _pickcamera,VoidCallback _pickgallery,VoidCallback delete) {
//   showModalBottomSheet(
//     context: context,
//     builder: (BuildContext builderContext) {
//       return Container(
//         height:MediaQuery.of(context).size.height*.2,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 profilename,
//                 style: TextStyle(fontSize:MediaQuery.of(context).size.height*.02),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(width:MediaQuery.of(context).size.width*.01,),
//                   IconButton(onPressed:_pickcamera, icon:Icon(Icons.camera_alt,color:Colours.lightRed,)),
//                   IconButton(onPressed:_pickgallery, icon:Icon(Icons.folder,color:Colours.lightRed,)),
//                   IconButton(onPressed: delete, icon:Icon(Icons.delete,color:Colours.lightRed,)),
//                   SizedBox(width:MediaQuery.of(context).size.width*.01,),
//                 ],),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
//
//
//
//
//
// // Container(
// // height:MediaQuery.of(context).size.height*.2,
// // child:Column(children: [
// // Text(widget.bottomsheetname??"",
// // style: TextStyle(fontSize:MediaQuery.of(context).size.height*.02),
// // ),
// // Row(children: [
// // IconButton(onPressed: widget.pickcamera, icon:widget.iconCamera??Icon(Icons.camera_alt,color:Colours.lightRed,)),
// // IconButton(onPressed:widget.pickgallery, icon:widget.iconGallery??Icon(Icons.folder,color:Colours.lightRed,)),
// // IconButton(onPressed:widget.handeldelete, icon:widget.iconDelete??Icon(Icons.delete,color:Colours.lightRed,)),
// // SizedBox(width:MediaQuery.of(context).size.width*.01,),
// //
// // ],),
// // ],),
// // );
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../constants/color.dart';
//
// class bottomSheet extends StatelessWidget {
//   const bottomSheet({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return showModalBottomSheet(
//       context: context,
//       builder: (BuildContext builderContext) {
//         return Container(
//           height:MediaQuery.of(context).size.height*.2,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Profile Photo',
//                   style: TextStyle(fontSize:MediaQuery.of(context).size.height*.02),
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(width:MediaQuery.of(context).size.width*.01,),
//                     IconButton(onPressed:()async{
//                       final image=await ImagePickerHelperC.pickImageFromCamera();
//                       if(image!=null){
//                         setState(() {
//                           _pickedImage=File(image.path);
//                         });
//                       }
//                     }, icon:Icon(Icons.camera_alt,color:Colours.lightRed,)),
//                     IconButton(onPressed:()async{
//                       final image=await ImagePickerHelperG.pickImageFromGallery();
//                       if(image!=null){
//                         setState(() {
//                           _pickedImage=File(image.path);
//                         });
//                       }
//
//                     }, icon:Icon(Icons.folder,color:Colours.lightRed,)),
//                     IconButton(onPressed: (){
//                       setState(() {
//                         _pickedImage=null;
//                       });
//                     }, icon:Icon(Icons.delete,color:Colours.lightRed,)),
//                     SizedBox(width:MediaQuery.of(context).size.width*.01,),
//                   ],),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
