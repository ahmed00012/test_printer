

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';


import 'package:screenshot/screenshot.dart';
import 'package:untitled3/products_model.dart';







class Receipt extends StatelessWidget{
  final scr = GlobalKey();
  ScreenshotController screenshotController;
  final List<Products> products ;

  Receipt({required this.screenshotController, required this.products });

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: RepaintBoundary(
            key: scr,
            child: Screenshot(
              controller: screenshotController,
               child: Container(
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [


                      Image.asset(
                        'assets/logo.png',
                        height: 120,
                      ),

                        Text(
                          'Branch 1',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),

                      Text(
                        DateTime.now().toString().substring(0, 16),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),

                        Text(
                          'Cash',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),

                      SizedBox(
                        height: 10,
                      ),

                        Container(
                          width: 150,
                          decoration: BoxDecoration(border: Border.all(width: 2)),
                          child: Center(
                            child: Text(
                             'in resturant',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Table(
                            border: TableBorder.all(),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FixedColumnWidth(45),
                              1: FlexColumnWidth(),
                              2: FixedColumnWidth(90),
                            },
                            children: const [
                              TableRow(children: [
                                TableCell(
                                    verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Center(
                                        child: Text(
                                          'qty',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    )),
                                TableCell(
                                    verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Center(
                                        child: Text(
                                          'item',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    )),
                                TableCell(
                                    verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Center(
                                        child: Text(
                                          'price',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    )),
                              ])
                            ],
                          ),

                            Table(
                              border: TableBorder.all(),
                              columnWidths: const <int, TableColumnWidth>{
                                0: FixedColumnWidth(45),
                                1: FlexColumnWidth(),
                                // 2: FixedColumnWidth(90),
                                2: FixedColumnWidth(90),
                              },
                              children:
                              products.map((e) {
                                return TableRow(children: [
                                  TableCell(
                                    verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Center(
                                        child: Text(
                                          e.quantity.toString(),
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          e.title!,
                                          style: TextStyle(
                                              fontSize: size.height*0.02,
                                              height: 1,
                                              fontWeight:
                                              FontWeight.w500),
                                        )),
                                  ),
                                  TableCell(
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          e.price.toString(),
                                          style: TextStyle(
                                              fontSize: size.height*0.02,
                                              height: 1,
                                              fontWeight:
                                              FontWeight.w500),
                                        )),
                                  ),

                                ]);
                              }).toList(),
                            ),
                          SizedBox(
                            height: 40,
                          ),
                          Table(
                            border: TableBorder.all(),
                            children: [

                              const  TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                        'paid',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                        '100 SAR ',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ]),

                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                        'remaining',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                        '0 SAR ',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ]),

                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                        'tax',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                       '14.0 SAR ',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ]),


                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                        'discount',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                        '0 SAR',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ]),

                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Center(
                                      child: Text(
                                        'total',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Center(
                                      child: Text(
                                        '100.0 SAR ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ]),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),



                          SizedBox(
                            height: 20,
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
            ),
             ),
          ),
        ),
      ),
    );
  }
}
