import 'package:flutter/material.dart';
import 'package:project_property/Admin/adminScreen.dart';
import 'package:project_property/newProperty/addNewHome.dart';
import 'package:project_property/ofline_storage/shared_preference.dart';
import 'package:project_property/page/component/Shearch/Search.dart';
import 'package:project_property/user/color/color.dart';
import 'package:project_property/user/login.dart';
import 'package:project_property/user/registration.dart';
import 'package:project_property/user/splash_screen.dart';

import '../drawers.dart';
import 'component/home/ButtonBottom.dart';
import 'component/home/appbar.dart';
import 'component/home/property.dart';
import 'component/home/sliderButton.dart';
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
import 'package:project_property/propertydetails/property.dart';

import 'package:project_property/Basic Ui/PropertyDetail.dart';
import 'package:project_property/Admin/PropertyDetailAdmin.dart';

class Home extends StatefulWidget {
  static List list;
  static var lastindex;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var filter;
  Future getProperty() async {
    try {


      var url = "https://propertymanagment.000webhostapp.com/downloadMain.php";
      var response = await http.get(Uri.parse(url),);
      var req =jsonDecode(response.body);




      return req;
    } catch (e) {
      //  print("can't upload");
    }

  }

  @override
  void initState() {
    // TODO: implement initState

    getProperty();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer:Drawers(),
        backgroundColor: white,
        appBar: null,
        body: FutureBuilder(
          future: getProperty(),

          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Home.list = snapshot.data;
              if( Home.list.isEmpty)
                return Text("");
              else{
               Home.lastindex= Home.list[(Home.list.length)-1]['id'];



              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      CreateAppBar(label:"Find your dream house"),
                      SliderButton(),
                      Property(list: Home.list,icon: Icons.favorite,),
                    ],
                  ),
                  ButtonBottom(
                    icon: Icons.search_rounded,
                    function: () {

                      showSearch(context: context, delegate: DataSearch());
                    },
                    txt: "Search",
                  ),
                ],
              );}
            } else if (snapshot.hasError)
              return Text("Sorry,there is an Error");
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
final searchController=TextEditingController();
class DataSearch  extends SearchDelegate<String> {

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(onPressed: () {
        query = "";
      }, icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    // return Text(query);
    return NotFound();
  }

  @override
  Widget buildSuggestions(BuildContext context) {


   var filter=Home.list.where((element) {
      return element['stat'].toString().startsWith(query)||element['price'].toString().startsWith(query)||element['descreptionn'].toString().contains(query)
          ||element['llocation'].toString().contains(query)||element['area'].toString().startsWith(query);
    }).toList();
    return Property(list: filter);

  }
  
}