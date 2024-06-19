


// import 'package:flutter/material.dart';

// class SingleChat extends StatelessWidget {
//   const SingleChat({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(50),
//               child: Image.network(
//                 'https://onebighappyphoto.com/wp-content/themes/yootheme/cache/96/2-year-old-boy-and-family-photoshoot-2951-One-Big-Happy-Photo-96eaff06.webp',
//                 width: 45,
//                 height: 45,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'User',
//               ),
//             )
//           ],
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Icon(
//               Icons.video_call,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Icon(
//               Icons.call,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Icon(
//               Icons.more_vert,
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [Text('data')],
//       ),
//       bottomSheet: ChatBottomSheet(),
//     );
//   }
// }

// class ChatBottomSheet extends StatelessWidget {
//   const ChatBottomSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 65,
//         decoration: BoxDecoration(
//             color: const Color.fromARGB(255, 239, 230, 230),
//             borderRadius: BorderRadius.circular(50)),
//         child: Row(
//             children: [
//               const SizedBox(
//                 width: 10,
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(10.0),
//                 child: Icon(
//                   Icons.add,
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Icon(
//                   Icons.emoji_emotions,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Container(
//                   alignment: Alignment.centerRight,
//                   width: 250,
//                   child: TextFormField(
//                     decoration: const InputDecoration(
//                         hintText: 'Type something', border: InputBorder.none),
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(right: 5),
//                 child: Icon(Icons.send),
//               )
//             ],
//             ),
//         );
//     }
// }