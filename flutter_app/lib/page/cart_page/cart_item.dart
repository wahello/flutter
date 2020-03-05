import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_app/model/cartInfo.dart';
import 'package:flutter_app/page/cart_page/cart_count.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app/provide/cart.dart';
import 'package:flutter_app/provide/currentIndex.dart';
import 'package:flutter_app/config/common.dart';
import 'package:flutter_app/utils/global.dart';

class CartItem extends StatelessWidget {
  final CartInfoMode item;
  CartItem(this.item);

  var url = "http://192.168.10.100";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          _cartImage(context, item),
          _cartGoodsName(item),
          _cartPrice(context, item)
        ],
      ),
    );
  }

  //商品图片
  Widget _cartImage(context, item) {
    return Container(
      margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              width: ScreenUtil().setWidth(190),
              height: ScreenUtil().setHeight(190),
            ),
          ),
          Positioned(
            left: 3,
            top: 3,
            child: Container(
              width: ScreenUtil().setWidth(177),
              height: ScreenUtil().setHeight(177),
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.0, 2.0), //阴影xy轴偏移量
                      spreadRadius: 1.0,
                      color: Color.fromRGBO(242, 242, 242, 1),
                      blurRadius: 5.0,
                    )
                  ]),
              child:
                  Image.network(url + item.goods_image, fit: BoxFit.cover),
//              getCacheImage(imageUrl:url + item['goods_image'], width:ScreenUtil().setWidth(170),height:ScreenUtil().setHeight(170))
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(60),
              height: ScreenUtil().setHeight(60),
              child: IconButton(
                padding: EdgeInsets.all(0),
                alignment: Alignment.topLeft,
                icon: Icon(
                  Icons.check_circle,
                  size: 28.0,
                  color: item.isCheck
                      ? Color.fromRGBO(236, 56, 56, 1)
                      : Color.fromRGBO(192, 196, 204, 1),
                ),
                onPressed: () {
                  var login =
                      Provide.value<CurrentIndexProvide>(context).isLogin;
                  if (login) {
                    Provide.value<CartProvide>(context).changeCheckState(item);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //商品名称
  Widget _cartGoodsName(item) {
    return Container(
      width: ScreenUtil().setWidth(460),
      padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTitle(item.localeGoodsName,18.0,Color.fromRGBO(48, 49, 51, 1),EdgeInsets.fromLTRB(0, 8, 0, 5),true),
          ListTitle(item.goods_attr_value,15.0,Color.fromRGBO(144, 147, 153, 1),EdgeInsets.fromLTRB(0, 3, 0, 5),false),
          ListTitle(tranFrom(item.goods_price) + '(' + item.goods_price + ")",18.0,Color.fromRGBO(236, 56, 56, 1),EdgeInsets.fromLTRB(0, 0, 0, 5),true),
          ListTitle('PV:' + item.goods_pv,15.0,Color.fromRGBO(144, 147, 153, 1),EdgeInsets.fromLTRB(0, 0, 0, 5),true),
          CartCount(item),
        ],
      ),
    );
  }

  //商品价格
  Widget _cartPrice(context, item) {
    return Container(
      width: ScreenUtil().setWidth(50),
      height: ScreenUtil().setHeight(180),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Container(
            child: InkWell(
              onTap: () {
                Provide.value<CartProvide>(context)
                    .deleteOneGoods(item.id);
              },
              child: Icon(
                Icons.close,
                color: Color.fromRGBO(144, 147, 153, 1),
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget ListTitle(title,size,color,padding,ishide){
    if(!ishide){
      if(title==""){
        return  Container(
          height: 0,
        );
      }
    }
    return  Padding(
      padding: padding,
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: size, color:color),
        maxLines: 1,
      ),
    );
  }
}
