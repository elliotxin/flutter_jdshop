import 'dart:convert';
import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String homePageContent = '正在获取数据';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('百姓生活+'),
        ),
        body: FutureBuilder(
          future: getHomePageContnet(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //数据处理
              var data = json.decode(snapshot.data.toString());
              List<Map> swiper = (data['data']['slides'] as List).cast();
              List<Map> navigtorList =
                  (data['data']['category'] as List).cast();
              String adPicture =
                  data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leaderImage = data['data']['shopInfo']['leaderImage'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];
              List<Map> recommendList =
                  (data['data']['recommend'] as List).cast();
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SwiperDiy(swiperDateList: swiper),
                    TopNavigator(navigatorList: navigtorList),
                    AdBanner(
                      adPicture: adPicture,
                    ),
                    LeaderPhone(
                        leaderImage: leaderImage, leaderPhone: leaderPhone),
                    Recommend(recommendList),
                  ],
                ),
              );
            } else {
              return Center(child: Text('加载中.......'));
            }
          },
        ));
  }
}

//首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDateList;
  SwiperDiy({this.swiperDateList});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            '${swiperDateList[index]['image']}',
            fit: BoxFit.fill,
          );
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//顶部导航
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator({this.navigatorList});
  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

//广告区域
class AdBanner extends StatelessWidget {
  final String adPicture;
  AdBanner({this.adPicture});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

//拨打电话模块
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;
  LeaderPhone({this.leaderImage, this.leaderPhone});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchUR,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchUR() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'URL不能进行访问，异常';
    }
  }
}

//商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;
  Recommend(this.recommendList);

  //标题方法
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  //商品框方法
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(width: 0.5, color: Colors.black12),
            )),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('¥${recommendList[index]['mallPrice']}'),
            Text('¥${recommendList[index]['price']}',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.green,
                )),
          ],
        ),
      ),
    );
  }

  //横向列表
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(400),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList(),
        ],
      ),
    );
  }
}
