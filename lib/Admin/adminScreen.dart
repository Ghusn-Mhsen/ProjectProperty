import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:background_app_bar/background_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:project_property/API.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:project_property/page/component/home/appbar.dart';
import 'package:project_property/propertydetails/property.dart';

import 'package:project_property/Basic Ui/PropertyDetail.dart';
import 'package:project_property/Admin/PropertyDetailAdmin.dart';

class adminScreen extends StatefulWidget {
  
  @override
  _adminScreenState createState() => _adminScreenState();
List list;

  //static int i;
}

class _adminScreenState extends State<adminScreen> {
  var phone;
  var area;
  var llocation;
  var price;
  var imagee;
  var descreptionn;
  var stat;
  var id;

  var currentStepIndex = 0;

   Future getProperty() async {
    try {

      var url = "https://propertymanagment.000webhostapp.com/download.php";

      var response = await http.get(Uri.parse(url));

      return json.decode(response.body);
    } catch (e) {
      print("can't upload");
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    getProperty();
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            headline: //head line is key only
                TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              fontStyle: FontStyle.italic,
            ),
            body2: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              fontStyle: FontStyle.italic,
            ),
          ),
          iconTheme: IconThemeData(
            size: 50,
            color: Colors.black54,
          ),
        ),
        home: Scaffold(

          appBar: null,
          resizeToAvoidBottomInset: false,
          body: RefreshIndicator(

            onRefresh: () {
             try {

             return getProperty();

             }
             catch(e)
              {

              }

            },
            child: FutureBuilder(
              future: getProperty(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                   widget.list = snapshot.data;

                  return Directionality(textDirection:
                      TextDirection.rtl, //  =====>> اتجاه البرنامج (عربي)
                   child: Column(
                      children: [
                        CreateAppBar(label:"وحدة التحكم :"),
                        Container(
                          // **********          for List of  Property ***********
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.6,

                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                if(widget.list[i]==null)
                                  return Center(child: CircularProgressIndicator());
                                return SingleProperty(



                                id: widget.list[i]['id'],
                                phone: widget.list[i]['phone'],
                                price: widget.list[i]['price'],
                                llocation: widget.list[i]['llocation'],
                                area: widget.list[i]['area'],
                                descreptionn: widget.list[i]['descreptionn'],
                                stat: widget.list[i]['stat'],
                                image: widget.list[i]['imagee'],

                                );
                              }),
                        ),
                      ],
                    ));
                //  );
                }

                else if (snapshot.hasError)
                  return Center(child: Text("Sorry,there is an Error"));
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),

          // bottomNavigationBar: BottomNavigationBar(
          //   currentIndex: 0,
          //   selectedItemColor: Colors.red,
          //   selectedFontSize: 14,
          //   unselectedItemColor: Colors.grey,
          //   unselectedFontSize: 12,
          //   showSelectedLabels: true,
          //   type: BottomNavigationBarType.fixed,
          //   items: [
          //     BottomNavigationBarItem(
          //       icon:Icon(Icons.home_outlined,size: 30.0,),
          //       title: Text('الرئيسية'),
          //     ),
          //     BottomNavigationBarItem(
          //       icon:Icon(Icons.fiber_new_sharp,size: 30.0,),
          //       title: Text('الجديد'),
          //     ),
          //     BottomNavigationBarItem(
          //       icon:Icon(Icons.account_circle_outlined,size: 30.0,),
          //       title: Text('حسابي'),
          //     ),
          //
          //   ],
          // ),
        ));
  }
}

class SingleProperty extends StatelessWidget {
  final id;
  final phone;
  var price;
  var llocation;
  var area;
  var descreptionn;
  var stat;
  var image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //  *********  الانتقال الى صفحة التفاصيل*********
        Navigator.push(
            context,new
            MaterialPageRoute(
                builder: (context) => PropertyDetailAdmin(
                    id: this.id,
                    price: this.price,
                    stat: this.stat,
                    image: this.image,
                    descreptionn: this.descreptionn,
                    phone: this.phone,
                    llocation: this.llocation,
                    area: this.area)));
      },
      child: Container(
        // ********************  for property **************
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                      NetworkImage("https://propertymanagment.000webhostapp.com/uploads/${image}"),
                ),
              ),
            ),
            Text(
              "عقار مخصص للـ ${stat}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            Text(
              "التكلفة هي${price}",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  SingleProperty(
      {this.id,
      this.price,
      this.stat,
      this.image,
      this.descreptionn,
      this.phone,
      this.llocation,
      this.area}); // ****************   Default Constructor  **********
}
