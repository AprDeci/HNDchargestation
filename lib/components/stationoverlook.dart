import 'package:chargestation/controller/Homecontroller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class stationcard extends StatelessWidget {
  final Map state;
  final String name;
  final HomeController mycontroller = Get.find();
  
  stationcard(this.state,this.name);


  @override
  Widget build(BuildContext context) {
    print(state);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: mapEquals(state, {"error": "请求超时"})
            ? _buildErrorLayout(context) // 错误状态布局
            : _buildNormalLayout(context), // 正常状态布局
      ),
    );
  }

  Widget _buildNormalLayout(BuildContext context) {
    return Column(
      children: [
        _buildHeader(name),
        _buildNumberGrid(context),
      ],
    );
  }

  Widget _buildErrorLayout(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(name),
                const SizedBox(height: 8),
                Text(
                  "达咩,请求超时了啊",
                  style: TextStyle(
                    color: Colors.red.shade700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100, // 图片区域宽度
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/Bawunai.gif'), // 替换你的图片路径
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }


// 头部组件
  Widget _buildHeader(String name) {
    return Row(
      children: [
        Text(name),
        const Spacer(),
      ],
    );
  }

  Widget _buildNumberGrid(context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemSize = (screenWidth - 20 * 2 - 5 * 18) / 10;
    return Row(
      children: List.generate(10, (index) => _buildNumberCell(index,itemSize)),
    );
  }

  Widget _buildNumberCell(int index,double size) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _getCellColor(index),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      child: Center(child: Text(index.toString())),
    );
  }


// 获取单元格颜色
  Color _getCellColor(int index) {
    final cellState = state["data"]?[index]["state"];
    return cellState == 1
        ? const Color(0xFF17969F)
        : const Color(0xFFE891A1);
  }

}
