 import 'package:chargestation/controller/Mycontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class stationcard extends StatelessWidget {
  final Map state;
  final String name;
  final Mycontroller mycontroller = Get.find();
  stationcard(this.state,this.name);


  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              Row(
                children: [
                  Text("${name}"),
                  Spacer(),
                ],
              ),
              Row(
                children: List.generate(10, (index) {
                  return Container(
                    child: Center(
                      child: Text(index.toString()),
                    ),
                    margin: EdgeInsets.all(5),
                    width: 25,
                    height: 25,
                    // 根据testdata.data对应num的state来判断颜色,1为绿,2为红
                    decoration: BoxDecoration(
                      color: state["data"]?[index]["state"] == 1
                          ? Color(0xFF17969F)
                          : Color(0xFFE891A1),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                  );
                }),
              ),
            ])));
  }
}
