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

class home extends StatefulWidget {
  static List list;
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  var phone;
  var area;
  var llocation;
  var price;
  var imagee;
  var descreptionn;
  var stat;
  var id;

  Future getProperty() async
  {
    try{
      var url = "https://propertymanagment.000webhostapp.com/downloadMain.php";

      var response=await http.get(Uri.parse(url));

      return json.decode(response.body);

    }
    catch(e)
    {
      print("can't upload");
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
        theme: ThemeData(
          textTheme: TextTheme(
            headline://head line is key only
            TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              fontStyle: FontStyle.italic,
            ),
            body2:
            TextStyle(
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
          body:  FutureBuilder(
            future: getProperty(),
            builder: (context,AsyncSnapshot snapshot){
              if(snapshot.hasData)
              {

               home.list = snapshot.data;

                return Directionality(

                  textDirection: TextDirection.rtl ,  //  =====>> اتجاه البرنامج (عربي)
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.bottomRight,
                          margin: EdgeInsets.only(top: 20.0),
                          padding: EdgeInsets.only(right:15.0),
                          child: Center(
                            child: Text('نظام إدارة الممتلكات',
                              style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 25,fontFamily: 'Arial'),
                            ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Icon(Icons.menu,color: Colors.red,size: 35,),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.only(right: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:   BorderRadius.circular(25.0),
                                  ),
                                  child:
                                      IconButton(
                                        icon: Icon(Icons.search) ,
                                        onPressed: ()=>showSearch(context: context, delegate: DataSearch()),
                                      )

                                ),
                              ),
                            ],
                          ),
                        ),


                        Container(  // **********          for List of  Property ***********
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/1.5 ,

                          child:
                          ListView.builder(
                              itemCount: snapshot.data.length,itemBuilder:(context,i){
                            return SingleProperty(
                              id: home.list[i]['id'],
                              phone: home.list[i]['phone'],
                              price: home.list[i]['price'],
                              llocation: home.list[i]['llocation'],
                              area: home.list[i]['area'],
                              descreptionn: home.list[i]['descreptionn'],
                              stat: home.list[i]['stat'],
                              image: home.list[i]['imagee'],
                            ) ;
                          }
                          ),
                        ),


                      ],
                    ),
                  ),
                );




              }
              else if(snapshot.hasError)
                return Text("Sorry,there is an Error");
              return  Center(child: CircularProgressIndicator());
            },
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            selectedItemColor: Colors.red,
            selectedFontSize: 14,
            unselectedItemColor: Colors.grey,
            unselectedFontSize: 12,
            showSelectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon:Icon(Icons.home_outlined,size: 30.0,),
                title: Text('الرئيسية'),
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.fiber_new_sharp,size: 30.0,),
                title: Text('الجديد'),
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.account_circle_outlined,size: 30.0,),
                title: Text('حسابي'),
              ),

            ],
          ),


        )
    );
  }


}
class SingleProperty extends StatelessWidget {
  final  id;
  final phone;
  var price;
  var llocation;
  var area;
  var descreptionn;
  var stat;
  final  image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ //  *********  الانتقال الى صفحة التفاصيل*********
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PropertyDetail(id:this.id,price:this.price,stat:this.stat,image:this.image,descreptionn:this.descreptionn,phone:this.phone,llocation:this.llocation,area:this.area)));
      },
      child: Container(                    // ********************  for property **************
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  fit: BoxFit.cover,

                  image: NetworkImage("https://10.0.2.2/project/uploads/${image}"),
                ),
              ),
            ),
            Text("عقار مخصص للـ ${stat}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
            Text("التكلفة هي${price}",style: TextStyle(color: Colors.grey),),
          ],
        ),
      ),
    );
  }

  SingleProperty({this.id,this.price,this.stat,this.image,this.descreptionn,this.phone,this.llocation,this.area});  // ****************   Default Constructor  **********
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
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.mood_bad_sharp,color: Colors.black54,size: 200,),
       Text("Not Found",style:TextStyle(color: Colors.black54,fontSize: 50)),
      ],
    ),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List filter=home.list.where((element) {
     return element['stat'].toString().startsWith(query)||element['price'].toString().startsWith(query)||element['descreptionn'].toString().contains(query)
     ||element['llocation'].toString().contains(query)||element['area'].toString().startsWith(query);
    }).toList();
    return Directionality(

        textDirection: TextDirection.rtl ,  //  =====>> اتجاه البرنامج (عربي)
        child: SingleChildScrollView(child:
     Container(  // **********          for List of  Property ***********
        width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height/1.5 ,

        child:
    ListView.builder(
     itemCount: query==""?home.list.length:filter.length,
       itemBuilder: (context,i)
           {
try {
  return SingleProperty(id: query == "" ? home.list[i]['id'] : filter[i]['id'],
    phone: query == "" ? home.list[i]['phone'] : filter[i]['phone'],
    price: query == "" ? home.list[i]['price'] : filter[i]['price'],
    llocation: query == "" ? home.list[i]['llocation'] : filter[i]['llocation'],
    area: query == "" ? home.list[i][' area'] : filter[i][' area'],
    descreptionn: query == ""
        ? home.list[i]['descreptionn']
        : filter[i]['descreptionn'],
    stat: query == "" ? home.list[i]['stat'] : filter[i]['stat'],
    image: query == "" ? home.list[i]['imagee'] : filter[i]['imagee'],);
}
catch(e)
             {

             }
           }
   ))));
  }

}