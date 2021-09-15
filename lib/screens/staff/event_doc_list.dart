import 'package:flutter/material.dart';
import 'package:pn_204_sam/widgets/nav_bar.dart';

class EventDocListScreen extends StatefulWidget {
  EventDocListScreen({Key? key}) : super(key: key);

  @override
  _EventDocListScreenState createState() => _EventDocListScreenState();
}

class _EventDocListScreenState extends State<EventDocListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: NavBar(
          text: "EVENT DOCUMENT LIST",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Anna Furrow",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "09|10|2020",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 2 / 3,
                              child: Text(
                                "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusdoloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventoreveritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enimipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia ",
                               textAlign: TextAlign.justify ,style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(height: 40,),
                            Container(
                              padding: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.image,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text("File - XYZ Event",textAlign: TextAlign.center ,style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),),

                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Container(width: double.infinity,height: 1,color: Colors.grey,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
             Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Anna Furrow",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "09|10|2020",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 2 / 3,
                              child: Text(
                                "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusdoloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventoreveritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enimipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia ",
                               textAlign: TextAlign.justify ,style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(height: 40,),
                            Container(
                              padding: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.image,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text("File - XYZ Event",textAlign: TextAlign.center ,style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),),

                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Container(width: double.infinity,height: 1,color: Colors.grey,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
             Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Anna Furrow",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "09|10|2020",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 2 / 3,
                              child: Text(
                                "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusdoloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventoreveritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enimipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia ",
                               textAlign: TextAlign.justify ,style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(height: 40,),
                            Container(
                              padding: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.image,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text("File - XYZ Event",textAlign: TextAlign.center ,style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),),

                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Container(width: double.infinity,height: 1,color: Colors.grey,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
             Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Anna Furrow",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "09|10|2020",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 2 / 3,
                              child: Text(
                                "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusdoloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventoreveritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enimipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia ",
                               textAlign: TextAlign.justify ,style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(height: 40,),
                            Container(
                              padding: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.image,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text("File - XYZ Event",textAlign: TextAlign.center ,style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),),

                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Container(width: double.infinity,height: 1,color: Colors.grey,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
