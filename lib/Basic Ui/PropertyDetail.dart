import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class PropertyDetail extends StatefulWidget {
  var  id;
  var phone;
  var price;
  var llocation;
  var area;
  var descreptionn;
  var stat;
  var  image;
  PropertyDetail({this.id,this.price,this.stat,this.image,this.descreptionn,this.phone,this.llocation,this.area});  //

  @override
  _PropertyDetailState createState() => _PropertyDetailState();

}

class _PropertyDetailState extends State<PropertyDetail> {


  Widget headerBuild(){
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Row(
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
            child: IconButton(
              icon: Icon(Icons.add_business_sharp,color: Colors.red,size: 30.0,),
              onPressed: (){},
            ),
          ),

        ],
      ),
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
          Image.network("https://10.0.2.2/project/uploads/${img}"),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //Padding(padding: EdgeInsets.only(top: 15.0)),
            children: [
              //    *******    العودة إلى الشاشة الرئيسية ******
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  boxShadow: [BoxShadow(
                    color: Colors.grey[100],
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0,1),
                  )],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: IconButton(
                  icon: Icon(Icons.remove_circle_outlined,color: Colors.white,size: 30.0,),
                  onPressed: (){
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("1",
                  style: TextStyle(color: Colors.black,fontSize: 25.0),
                ),
              ),


              //    *******   + إضافة العقار  + ******
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  boxShadow: [BoxShadow(
                    color: Colors.grey[100],
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0,1),
                  )],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: IconButton(
                  icon: Icon(Icons.add_business_sharp,color: Colors.white,size: 30.0,),
                  onPressed: (){},
                ),
              ),

            ],
          ),

        ],
      ),
    );

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

                        "تفاصيل العقار المخصص لعملية الـ ${this.widget.stat} :",
                        style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(Icons.favorite_border_rounded,color: Colors.red,),
                          Text('5',style: TextStyle(fontSize: 16.0),),
                          Expanded(child: Text('')),
                          Icon(Icons.star_outline_rounded,color: Colors.orange,),
                          Text("5 Review",style: TextStyle(fontSize: 16.0),),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 15.0),),
                      Text(
                        "التكلفة  "
                            "\n${this.widget.price} \$"
                            "\n المساحة  "
                            "\n${this.widget.area} (m*m)\n"
                      "  الموقع "
                            "\n${this.widget.llocation}\n"
                          " الوصف"
                            "\n${this.widget.descreptionn}",
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

      bottomNavigationBar: Container(
        child: Row(
          children: [
            Text(this.widget.phone,style: TextStyle(fontSize: 30.0,color: Colors.white,fontWeight: FontWeight.bold),),
            Expanded(child: Text("")),
            Container(
              decoration: BoxDecoration(
                color: Colors.red[300],
                boxShadow: [BoxShadow(
                  color: Colors.grey[100],
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0,1),
                )],
                borderRadius: BorderRadius.circular(40.0),
              ),
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.only(left: 10.0),
              // child: Text(
              //   " امتلاك العقار  ",
              //   style: TextStyle(color: Colors.white,fontSize: 20.0),
              //
              // ),
            ),
            Container(
              child: Icon(
                Icons.call,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ],

        ),
        padding: EdgeInsets.only(left: 50.0,right: 30.0),
        height: 75.0,
        decoration: BoxDecoration(
          // color: Colors.red[300],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Colors.red,
              Colors.red[300],
              Colors.red[300],
              Colors.red,
            ],
          ),
          boxShadow: [BoxShadow(
            color: Colors.grey[100],
            spreadRadius: 7,
            blurRadius: 4,
            offset: Offset(0,3),
          )],
          borderRadius: BorderRadius.circular(50.0),
        ),

      ),

    );
  }
 
 

}
