

import 'dart:convert';

import 'dart:ui';
import 'package:background_app_bar/background_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:project_property/API.dart';
import 'package:project_property/Admin/adminScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:project_property/propertydetails/property.dart';

import 'package:project_property/Basic Ui/PropertyDetail.dart';
import 'package:project_property/Admin/PropertyDetailAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PropertyDetailAdmin extends StatefulWidget {
  var  id;
  var phone;
  var price;
  var llocation;
  var area;
  var descreptionn;
  var stat;
  var  image;
  var iduser;
  var _token;
  PropertyDetailAdmin({this.id,this.price,this.stat,this.image,this.descreptionn,this.phone,this.llocation,this.area});  //

  @override
  _PropertyDetailAdminState createState() => _PropertyDetailAdminState();

}

class _PropertyDetailAdminState extends State<PropertyDetailAdmin> {


  Widget headerBuild(){
    return Container(
      padding: EdgeInsets.all(15.0),
      child:Stack(
        children: [
          Row(
            children: [
              //    *******    العودة إلى الشاشة الرئيسية ******
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Colors.grey[100],
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0,1),
                  )],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back,color: Colors.red,size: 30.0,),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ),

              Expanded(child: Text("")),


              //    *******   + إضافة العقار  + ******
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Colors.grey[100],
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0,1),
                  )],
                  borderRadius: BorderRadius.circular(15.0),
                ),
//Delete
                child: IconButton(
                  icon: Icon(Icons.delete_forever_outlined,color: Colors.red,size: 30.0,),
                  onPressed:  () async {
                    Delete().then((value) =>   Navigator.of(context).push(new MaterialPageRoute(builder:(context)=> new adminScreen())));


                  },
                ),
              ),
              SizedBox(
                width: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Colors.grey[100],
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0,1),
                  )],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                //UPLOAD
                child: IconButton(
                  icon: Icon(Icons.upload_outlined,color: Colors.red,size: 30.0,),
                  onPressed: ()  {

                    RegisterHome();
                    Delete().then((value) =>     Navigator.of(context).push(new MaterialPageRoute(builder:(context)=>new adminScreen())));




                  },
                ),
              ),
            ],
          ),
        ],
      )
    );
  }


  Widget imageProperty(String img){
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,

        boxShadow: [BoxShadow(
          color: Colors.grey[100],
          spreadRadius: 1,
          blurRadius: 0,
          offset: Offset(0,1),
        )],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.0),
          bottomRight: Radius.circular(50.0),
        ),
      ),
      child: Column(
        children: [
          Image.network("https://propertymanagment.000webhostapp.com/uploads/${img}"),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   //Padding(padding: EdgeInsets.only(top: 15.0)),
          //   children: [
          //     //    *******    العودة إلى الشاشة الرئيسية ******
          //     Container(
          //       decoration: BoxDecoration(
          //         color: Colors.red,
          //         boxShadow: [BoxShadow(
          //           color: Colors.grey[100],
          //           spreadRadius: 1,
          //           blurRadius: 1,
          //           offset: Offset(0,1),
          //         )],
          //         borderRadius: BorderRadius.circular(15.0),
          //       ),
          //       child: IconButton(
          //         icon: Icon(Icons.remove_circle_outlined,color: Colors.white,size: 30.0,),
          //         onPressed: (){
          //         },
          //       ),
          //     ),
          //
          //     Padding(
          //       padding: EdgeInsets.all(10.0),
          //       child: Text("1",
          //         style: TextStyle(color: Colors.black,fontSize: 25.0),
          //       ),
          //     ),
          //
          //
          //     //    *******   + إضافة العقار  + ******
          //     Container(
          //       decoration: BoxDecoration(
          //         color: Colors.red,
          //         boxShadow: [BoxShadow(
          //           color: Colors.grey[100],
          //           spreadRadius: 1,
          //           blurRadius: 1,
          //           offset: Offset(0,1),
          //         )],
          //         borderRadius: BorderRadius.circular(15.0),
          //       ),
          //       child: IconButton(
          //         icon: Icon(Icons.add_business_sharp,color: Colors.white,size: 30.0,),
          //         onPressed: (){},
          //       ),
          //     ),
          //
          //   ],
          // ),

        ],
      ),
    );

  }
@override
  void initState() {
    // TODO: implement initState
  getData();
  getUserToken();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            ListView(
              children: [
                headerBuild(),
                imageProperty(this.widget.image),
                Container(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(

                        "تفاصيل العقار المخصص لعملية الـ${this.widget.stat} :",
                        style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),
                      ),
                      // Row(
                      //   children: [
                      //     Icon(Icons.favorite_border_rounded,color: Colors.red,),
                      //     Text('5',style: TextStyle(fontSize: 16.0),),
                      //     Expanded(child: Text('')),
                      //     Icon(Icons.star_outline_rounded,color: Colors.orange,),
                      //     Text("5 Review",style: TextStyle(fontSize: 16.0),),
                      //   ],
                      // ),
                      Padding(padding: EdgeInsets.only(bottom: 15.0),),
                      Text(
                        "التكلفة  "
                            "\n${this.widget.price} \$"
                            "\n المساحة  "
                            "\n${this.widget.area} (m*m)\n"
                            "  الموقع "
                            "\n${this.widget.llocation}\n"
                            " الوصف"
                            "\n${this.widget.descreptionn}\n"
                            " الرقم للتواصل"
                            "\n${this.widget.phone}\n"
                        ,
                        style: TextStyle(fontSize: 20.0,color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),


            Positioned(
                top: 0.0,
                left:0.0 ,
                right: 0.0,
                height: 120.0,
                child: headerBuild()
            ),
          ],
        ),
      ),

      // bottomNavigationBar: Container(
      //   child: Row(
      //     children: [
      //       Text(this.widget.phone,style: TextStyle(fontSize: 30.0,color: Colors.white,fontWeight: FontWeight.bold),),
      //       Expanded(child: Text("")),
      //       Container(
      //         decoration: BoxDecoration(
      //           color: Colors.red[300],
      //           boxShadow: [BoxShadow(
      //             color: Colors.grey[100],
      //             spreadRadius: 1,
      //             blurRadius: 1,
      //             offset: Offset(0,1),
      //           )],
      //           borderRadius: BorderRadius.circular(40.0),
      //         ),
      //         margin: EdgeInsets.all(5.0),
      //         padding: EdgeInsets.only(left: 10.0),
      //         // child: Text(
      //         //   " امتلاك العقار  ",
      //         //   style: TextStyle(color: Colors.white,fontSize: 20.0),
      //         //
      //         // ),
      //       ),
      //       Container(
      //         child: Icon(
      //           Icons.call,
      //           color: Colors.white,
      //           size: 30.0,
      //         ),
      //       ),
      //     ],
      //
      //   ),
      //   padding: EdgeInsets.only(left: 50.0,right: 30.0),
      //   height: 75.0,
      //   decoration: BoxDecoration(
      //     // color: Colors.red[300],
      //     gradient: LinearGradient(
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter,
      //       colors: <Color>[
      //         Colors.red,
      //         Colors.red[300],
      //         Colors.red[300],
      //         Colors.red,
      //       ],
      //     ),
      //     boxShadow: [BoxShadow(
      //       color: Colors.grey[100],
      //       spreadRadius: 7,
      //       blurRadius: 4,
      //       offset: Offset(0,3),
      //     )],
      //     borderRadius: BorderRadius.circular(50.0),
      //   ),
      //
      // ),

    );
  }
  Future RegisterHome() async {

    var data = {
      "phone": this.widget.phone,
      "area": this.widget.area,
      "llocation": this.widget.llocation,
      "price": this.widget.price,
      "descreptionn":this.widget.descreptionn,
      "stat":this.widget.stat,
      "imagename":this.widget.image,
      "iduser":this.widget.iduser,
      "token":this.widget._token

    };

    var url = "https://propertymanagment.000webhostapp.com/uploadMain.php";
    var response = await http.post(Uri.parse(url), body: data);
    //var req =  jsonDecode(response.body);

    if (response.statusCode == 200) {

      // ignore: deprecated_member_use
      print("Upload successfulR");


      // ignore: deprecated_member_use

    } else {
      print("Upload isn't successfulR");
    }
  }

  Future Delete() async {

    var data = {
      "id": this.widget.id,
     "token":this.widget._token,

    };

    var url = "https://propertymanagment.000webhostapp.com/delete.php";
    var response = await http.post(Uri.parse(url), body: data);
    //var req =  jsonDecode(response.body);

    if (response.statusCode == 200) {

      // ignore: deprecated_member_use
      print("Delete successfulR");


      // ignore: deprecated_member_use

    } else {
      print("Delete isn't successfulR");
    }
  }
  Future<int> getData() async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      this.widget.iduser = pref.getString("id");

    }

    );
}
  Future<void>  getUserToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {

      this.widget._token = pref.getString("token")??"000";
    });

  }
}
