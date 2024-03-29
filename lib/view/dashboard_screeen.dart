import 'package:card_swiper/card_swiper.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortnews/main.dart';
import 'package:shortnews/view/drower.dart';
import 'package:shortnews/view/uitl/appColors.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view/uitl/appimage.dart';
import 'package:shortnews/view/uitl/appstyle.dart';
import 'package:shortnews/view/uitl/translation_widget.dart';
import 'package:shortnews/view_model/dashboard_contoller.dart';
import 'package:shortnews/view_model/provider/ThemeProvider.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class DashBoardScreenActivity extends StatefulWidget {
  const DashBoardScreenActivity({super.key});

  @override
  State<DashBoardScreenActivity> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreenActivity> {
  DarkThemeProvider foodcategoriesProvider = DarkThemeProvider();
  final _advancedDrawerController = AdvancedDrawerController();
  final MyController myController = Get.put(MyController());

  void showSimpleSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('This is a Snackbar'),
      ),
    );
  }

  final FlickManager flickManager = FlickManager(
    videoPlayerController: VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
        builder: (context, darkThemeProvider, child) {
      return AdvancedDrawer(
          backdrop: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.transparent, Colors.blueGrey.withOpacity(0.2)],
              ),
            ),
          ),
          controller: _advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          // openScale: 1.0,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 0.0,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          drawer: MenuBarScreen(),
          child: Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            drawer: Container(),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: _handleMenuButtonPressed,
                  icon: ValueListenableBuilder<AdvancedDrawerValue>(
                    valueListenable: _advancedDrawerController,
                    builder: (_, value, __) {
                      return AnimatedSwitcher(
                        duration: Duration(milliseconds: 250),
                        child: Icon(
                          value.visible ? Icons.clear : Icons.menu,
                          color: AppHelper.themelight
                              ? Colors.white
                              : Colors.black,
                          key: ValueKey<bool>(value.visible),
                        ),
                      );
                    },
                  )),
              actions: [
                // Switch(
                //   value: myController.notification.value,
                //   activeColor: AppHelper.themelight
                //       ? AppColors.primarycolorYellow
                //       : AppColors.blackColor,
                //   onChanged: (bool value) {
                //     myController.notification.value = value;
                //   },
                // ),
                // FlutterSwitch(
                //   activeColor: AppHelper.themelight
                //       ? AppColors.primarycolorYellow
                //       : AppColors.blackColor,
                //   width: 15.0.w,
                //   height: 4.h,
                //   valueFontSize: 18.0.sp,
                //   //toggleSize: 45.0,
                //   value: myController.notification.value,
                //   //borderRadius: 30.0,
                //   //padding: 8.0,
                //   showOnOff: true,
                //   activeText: "Hi",
                //   inactiveText: "En",
                //   onToggle: (val) {
                //     setState(() {
                //       myController.notification.value = val;
                //     });
                //   },
                // ),
              ],
            ),
            body: Obx(() {
              if (myController.myData.isEmpty) {
                return Card(
                  child: Container(
                      height: 50.h,
                      color: Colors.white,
                      child: Center(child: CircularProgressIndicator())),
                );
              } else {
                return InkWell(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 0, right: 0, bottom: 10),
                    child: Swiper(
                      layout: SwiperLayout.STACK,

                      customLayoutOption:
                          CustomLayoutOption(startIndex: -1, stateCount: 3)
                            ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
                            ..addTranslate([
                              Offset(-370.0, -40.0),
                              Offset(0.0, 0.0),
                              Offset(370.0, -40.0)
                            ]),
                      itemWidth: MediaQuery.of(context).size.width,
                      itemHeight: MediaQuery.of(context).size.height,
                      itemBuilder: (context, index) {
                        var item = myController.myData[index];

                        print("lfkgjlkfgh ${item.img}");

                        return InkWell(
                          onTap: () {},
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 1, right: 1, bottom: 0),
                            child: Card(
                              color: AppHelper.themelight
                                  ? Colors.white
                                  : Colors.black,
                              child: Stack(
                                children: [
                                  if (myController.internet.value)
                                    item.img != ''
                                        ? Container(
                                            width: double.infinity,
                                            height: 25.h,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12.0),
                                                topRight: Radius.circular(12.0),
                                              ),
                                              image: DecorationImage(
                                                image: NetworkImage(item.img),
                                                fit: BoxFit.cover,
                                              ),
                                              color: Colors.transparent,
                                            ),
                                          )
                                        : Container(
                                            width: double.infinity,
                                            height: 25.h,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12.0),
                                                topRight: Radius.circular(12.0),
                                              ),
                                              color: Colors.transparent,
                                            ),
                                            child: FlickVideoPlayer(
                                                flickManager: FlickManager(
                                              videoPlayerController:
                                                  VideoPlayerController.network(
                                                item.video,
                                              ),
                                            )),
                                          ),
                                  Positioned(
                                    top: myController.internet.value
                                        ? 25.h
                                        : 1.h,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        padding: EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppHelper.themelight
                                                  ? AppStyle.heading_black
                                                  : AppStyle.heading_white,
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Container(
                                              height: 39.h,
                                              child: Text(
                                                item.description,
                                                // overflow: TextOverflow.ellipsis,
                                                style: AppHelper.themelight
                                                    ? AppStyle.bodytext_black
                                                    : AppStyle.bodytext_white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Text(
                                              "${item.from} / few minutes ago" ??
                                                  "",
                                              style: TextStyle(
                                                  color: AppHelper.themelight
                                                      ? Colors.black
                                                          .withOpacity(0.1)
                                                      : Colors.white38,
                                                  fontSize: 18),
                                            )
                                          ],
                                        )),
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: Container(
                                        height: 2.5.h,
                                        width: 20.w,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(7.0),
                                            topRight: Radius.circular(1.0),
                                            bottomRight: Radius.circular(7.0),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(1),
                                        child: Text(
                                          "ShorTnews",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  ),
                                  Positioned(
                                    left: 1.w,
                                    top: 0.2.h,
                                    child: Container(
                                        width: 10.w,
                                        height: 5.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        ),
                                        padding: EdgeInsets.all(1),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.asset(
                                              AppImages.welcomescreenillimage,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 3,
                                    child: InkWell(
                                      onTap: () {
                                        _launchUrl(Uri.parse(item.news_link));
                                      },
                                      child: item.img != ""
                                          ? Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(12.0),
                                                  bottomRight:
                                                      Radius.circular(12.0),
                                                ),
                                                image: DecorationImage(
                                                    image: item.img != ""
                                                        ? NetworkImage(item.img)
                                                        : NetworkImage(""),
                                                    fit: BoxFit.cover,
                                                    opacity: 0.21),
                                              ),
                                              padding: EdgeInsets.all(20.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 80.w,
                                                    child: Text(
                                                      "${item.heading}",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppHelper
                                                              .themelight
                                                          ? AppStyle
                                                              .bodytext_black
                                                          : AppStyle
                                                              .bodytext_white,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Image.asset(
                                                    "assets/images/Animation.gif",
                                                    height: 20.0,
                                                    width: 20.0,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(12.0),
                                                    bottomRight:
                                                        Radius.circular(12.0),
                                                  ),
                                                  color: Colors.black26),
                                              padding: EdgeInsets.all(20.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 80.w,
                                                    child: Text(
                                                      "${item.heading}",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppHelper
                                                              .themelight
                                                          ? AppStyle
                                                              .bodytext_black
                                                          : AppStyle
                                                              .bodytext_white,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Image.asset(
                                                    "assets/images/Animation.gif",
                                                    height: 20.0,
                                                    width: 20.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: myController.myData.length,
                      scrollDirection: Axis.vertical,
                      //control: const SwiperControl(),
                    ),
                  ),
                );
              }
            }),
          ));
    });
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
