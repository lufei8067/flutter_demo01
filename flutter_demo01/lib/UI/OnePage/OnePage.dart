import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo01/Common/SkinMgr.dart';
import 'package:flutter_demo01/common/Image_utils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:sprintf/sprintf.dart';

class OnePage extends StatefulWidget {
  const OnePage({Key key}) : super(key: key);

  @override
  _OnePageState createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  final List imgData = [
    "ic_hIcon01",
    "ic_hIcon02",
    "ic_hIcon03",
    "ic_hIcon04",
    "ic_hIcon05",
    "ic_hIcon06",
    "ic_hIcon07",
    "ic_hIcon08",
    "ic_hIcon09",
    "ic_hIcon10"
  ];

  final List nameStr = [
    "账户",
    "团队",
    "商户",
    "库存",
    "划拔",
    "商城",
    "问题汇总",
    "线上课程",
    "分享赚钱",
    "新增商户"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        brightness: SkinMgr.getSkinType == SkinType.Day
            ? Brightness.light
            : Brightness.dark,
        backgroundColor: SkinMgr.Bg,
      ),
      body: Material(
        child: Column(
          children: [
            Container(
              height: 60,
              color: SkinMgr.Bg,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "支付联盟",
                        style: TextStyle(
                            color: SkinMgr.Font,
                            fontSize: 26,
                            fontWeight: FontWeight.w700),
                      ),
                      Expanded(child: SizedBox()),
                      Badge(
                          padding: EdgeInsets.all(4),
                          position: BadgePosition.topEnd(top: -4, end: -4),
                          child: LfLoadAssetImage('mail', width: 32)),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text(
                      "创新平台，你我共赢未来",
                      style: TextStyle(
                        color: SkinMgr.Font,
                        fontSize: 14,
                      ),
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Flexible(
                child: new MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(children: [
                      _swiper(context),
                      _itemIcon(),
                      _voiceIcon(),
                      _billCarousel(),
                      Container(
                        child: Center(
                          child: Text(
                            "———— 支付联盟 ————",
                            style: TextStyle(
                                color: SkinMgr.LightFont, fontSize: 14),
                          ),
                        ),
                      )
                    ])))
          ],
        ),
        color: SkinMgr.Bg,
      ),
    );
  }

  //账单轮播
  _billCarousel() {
    return Container(
      //color: SkinMgr.Line,
      padding: const EdgeInsets.only(left: 10),
      height: 220, // 高度
      child: Swiper(
        scrollDirection: Axis.horizontal, // 横向
        itemCount: 4, // 数量
        autoplay: false, // 自动翻页
        itemBuilder: (BuildContext context, int index) {
          String strIcn =
              sprintf("assets/images/sider/sider%02d.png", [index + 2]);
          return Container(
            //margin: const EdgeInsets.only(bottom: 30),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage(strIcn), fit: BoxFit.fill),
                borderRadius: BorderRadius.all(Radius.circular(10))),

            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "本月收益（元）",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "1231242342353232",
                    style: TextStyle(color: Colors.white, fontSize: 26),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "本月收益（元）",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
        onTap: (index) {
          print('点击了第${index}');
        }, // 点击事件 onTap
        // pagination: SwiperPagination(
        //     // 分页指示器
        //     alignment: Alignment.bottomCenter, // 位置 Alignment.bottomCenter 底部中间
        //     margin: const EdgeInsets.fromLTRB(0, 0, 0, 5), // 距离调整
        //     builder: FractionPaginationBuilder(
        //       activeColor: SkinMgr.Font,
        //       color: SkinMgr.Font,
        //       fontSize: 15,
        //       activeFontSize: 25,
        //     )),
        viewportFraction: 1, // 当前视窗展示比例 小于1可见上一个和下一个视窗
        scale: 1, // 两张图片之间的间隔
        layout: SwiperLayout.STACK,
        itemWidth: MediaQuery.of(context).size.width - 40,
        itemHeight: MediaQuery.of(context).size.height,
      ),
    );
  }

  //voice 喇叭提示
  _voiceIcon() {
    return GestureDetector(
      onTap: () {
        print("voice");
      },
      child: Container(
        margin: EdgeInsets.only(top: 0, bottom: 10, right: 15, left: 15),
        constraints: BoxConstraints.expand(
          height: 42,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: SkinMgr.Line,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Image(
                height: 21,
                width: 19,
                image: ExactAssetImage('assets/images/ic_voice.png')),
            SizedBox(
              width: 10,
            ),
            Text(
              "张三购买合利宝电签一台",
              style: TextStyle(fontSize: 14, color: SkinMgr.Font),
            ),
            Spacer(),
            Image(
                height: 12,
                width: 7,
                image:
                    ExactAssetImage('assets/images/common/ic_arrow_gray.png')),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }

  //账户 团队 商户 ...

  _itemIcon() {
    return Container(
      //color: SkinMgr.LightFont,
      margin: EdgeInsets.only(top: 10, bottom: 30, right: 0, left: 0),
      height: 150,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //可以直接指定每行（列）显示多少个Item
            crossAxisCount: 5, //一行的Widget数量
            // crossAxisSpacing: 10, //水平间距
            // mainAxisSpacing: 4, //垂直间距
            childAspectRatio: 1, //子Widget宽高比例
          ),
          physics: NeverScrollableScrollPhysics(),
          //禁用滚动事件
          // padding: EdgeInsets.all(15),
          //GridView内边距
          itemCount: 10,
          itemBuilder: (context, index) {
            return _itemCell(context, index);
          }),
    );
  }

  _itemCell(context, index) {
    var _img = imgData[index];
    Widget _picture = LfLoadAssetImage(_img, width: 26);

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(1),
        //color: SkinMgr.Red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _picture,
            SizedBox(
              height: 5,
            ),
            Text(
              nameStr[index],
              style: TextStyle(color: SkinMgr.Font, fontSize: 12),
            )
          ],
        ),
      ),
      onTap: () {
        print("$index");
      },
      //onTap: () => _clickItemCell(context, index, _img),
    );
  }

  //轮播图
  Widget _swiper(context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
      height: 144,
      color: SkinMgr.Bg,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            //color: SkinMgr.Green,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/sider/sider01.png'),
                  fit: BoxFit.fill,
                )),
          );
        },
        autoplayDisableOnInteraction: true,
        itemCount: 3, //轮播图的数量
        itemWidth: double.infinity, //宽度
        //高度，如果Swiper外层爆过了其他容器，并且也设置了宽高，那么itemWidth和itemHeight是没有效果的
        //itemHeight: 200,
        //使用预先定义好的Images列表构建轮播项
        autoplay: true, //是否自动轮播
        //指示器样式，默认是小圆点，可以设置fraction、rect等形式
        pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
          size: 6,
          activeSize: 7,
          color: SkinMgr.Line,
          activeColor: SkinMgr.Orange,
        )),
        //control:  SwiperControl(), //两侧箭头
        scrollDirection: Axis.horizontal,
        scale: 0.9,
        //onTap: (index) => print('点击了第$index个'),
        onTap: (index) {},
      ),
    );
  }
}
