import 'package:flutter/material.dart';
import 'package:project_property/page/Data/propertylist.dart';

class DetailsInfo extends StatelessWidget {
  var house;
  DetailsInfo({this.house});
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(30,20,25,0),
      child: Container(
       height:size.height *0.17,
       child:

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text('\$${this.house['price']}',style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,

                ),),
                SizedBox(height: 5,),
                Text('\$ ${house['llocation']}',style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,

                ),),
                SizedBox(height: 15,),
                Text("House Information",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,

                ),),
              ],
            ),
            SizedBox(width: 40,),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                // Text('${2} Hours ago',
                //     overflow: TextOverflow.ellipsis,
                //     style: TextStyle(
                //       fontSize: 18,
                //       fontWeight: FontWeight.bold,
                //     ),),

              ],
            ),

          ],
        ),


      ),
    );
  }
}

