import 'package:blood_donation/view/widgets/custom%20form%20field.dart';
import 'package:flutter/material.dart';

class RecentDonor extends StatefulWidget {
  const RecentDonor({super.key});

  @override
  State<RecentDonor> createState() => _RecentDonorState();
}

class _RecentDonorState extends State<RecentDonor> {
  final donornameController = TextEditingController();
  final donoremailController = TextEditingController();
  final donorphoneController = TextEditingController();
  final donorbloodGroupController = TextEditingController();
  final donoraddressController = TextEditingController();
  final donorweightController=TextEditingController();
  final donoragecontroller = TextEditingController();
  final donordateandtime = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("RECENT DONOR"),
      ),
      body:SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://wallpapers.com/images/featured-full/cool-profile-picture-87h46gcobjl5e4xu.jpg"),
                  radius:MediaQuery.of(context).size.height*.08,
                ),
                SizedBox(height:MediaQuery.of(context).size.height*.02,),
                CustomFormField(
                  labeltxt: "donor name",
                  icons: Icon(Icons.person),
                  controller: donornameController,
                ),
                SizedBox(height:MediaQuery.of(context).size.height*.01,),
                CustomFormField(
                  labeltxt: "donor number",
                  icons: Icon(Icons.phone),
                  controller: donorphoneController,
                ),
                SizedBox(height:MediaQuery.of(context).size.height*.01,),
                CustomFormField(
                  labeltxt: "donor Email",
                  icons: Icon(Icons.email),
                  controller: donoremailController,
                ),
                SizedBox(height:MediaQuery.of(context).size.height*.01,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,


                    children: [
                    SizedBox(
                      width:MediaQuery.of(context).size.width*.28,
                      child: CustomFormField(
                        labeltxt: "Age",
                        icons:Icon(Icons.numbers),
                        controller: donoragecontroller,
                      ),
                    ),
                      SizedBox(width:MediaQuery.of(context).size.width*.01,),
                    SizedBox(
                      width:MediaQuery.of(context).size.width*.38,
                      child: CustomFormField(
                        labeltxt: "blood type",
                        icons:Icon(Icons.bloodtype_rounded),
                        controller: donorbloodGroupController,
                      ),
                    ),
                      SizedBox(width:MediaQuery.of(context).size.width*.01,),
                    SizedBox(
                      width:MediaQuery.of(context).size.width*.31,
                      child: CustomFormField(
                        labeltxt: "Weight",
                        icons:Icon(Icons.numbers),
                        controller: donorweightController,
                      ),
                    ),
                      SizedBox(width:MediaQuery.of(context).size.width*.01,),
                      SizedBox(
                        width:MediaQuery.of(context).size.width*.31,
                        child: CustomFormField(
                          labeltxt: "Date&Time",
                          controller: donordateandtime,
                        ),
                      ),
                  ],),
                ),
                SizedBox(height:MediaQuery.of(context).size.height*.01,),
             CustomFormField(
               labeltxt: "Address",
               controller:donoraddressController,
               maxline:5,
             ),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
