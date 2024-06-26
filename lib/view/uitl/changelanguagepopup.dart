// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:shortnews/model/language_model.dart';
// import 'package:shortnews/view/uitl/appColors.dart';
// import 'package:shortnews/view/uitl/apphelper.dart';
// import 'package:shortnews/view/uitl/appstyle.dart';

// class EditLanguagePopup extends StatefulWidget {
//   final Function? callback;
//   const EditLanguagePopup({this.callback, super.key});

//   @override
//   State<EditLanguagePopup> createState() => _EditLanguagePopupState();
// }

// class _EditLanguagePopupState extends State<EditLanguagePopup> 
// {
//   List<bool> checklanguage = [true, false];
//   @override
//   Widget build(BuildContext context) {
//     if (AppHelper.language.toString() == "hi")
//      {
//       checklanguage = [false, true];
//      } else 
//      {
//       checklanguage = [true, false];
//     }
//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.all(1.h),
//         child: Stack(clipBehavior: Clip.none, children: [
//           Container(
//             width: 100.w,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(2.h)),
//               gradient: LinearGradient(
//                   colors: [
//                     AppColors.primarycolor,
//                     Color(0xffFCB69F),
//                   ],
//                   begin: const FractionalOffset(0.0, 0.0),
//                   end: const FractionalOffset(1.0, 0.0),
//                   stops: [0.0, 1.0],
//                   tileMode: TileMode.clamp),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     IconButton(
//                       color: AppColors.whiteColor,
//                       onPressed: () {
//                         widget.callback!("ok");
//                       },
//                       icon: Icon(Icons.close),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(0.5.h),
//                       child: ListView.builder(
//                           itemCount: 1,
//                           shrinkWrap: true,
//                           scrollDirection: Axis.vertical,
//                           itemBuilder: (context, index) {
//                             return Column(
//                               children: [
//                                 for (int i = 0;
//                                     i < LanguageModel.languageList().length;
//                                     i++)
//                                   InkWell(
//                                     onTap: () async {
//                                       for (int j = 0;
//                                           j < checklanguage.length;
//                                           j++) {
//                                         setState(() {
//                                           checklanguage[j] = false;
//                                         });
//                                       }

//                                       changeLanguage(
//                                           context,
//                                           LanguageModel.languageList()[i]
//                                               .languageCode);

//                                       SharedPreferences prefs =
//                                           await SharedPreferences.getInstance();

//                                       String languageCode = prefs.getString(
//                                               prefSelectedLanguageCode) ??
//                                           "en";

//                                       setState(() {
//                                         AppHelper.language =  LanguageModel.languageList()[i]
//                                                 .languageCode;
//                                         print(
//                                             "lkfghlkfglkhfghl ${LanguageModel.languageList()[i].languageCode}");
//                                       });

//                                       await prefs.setString(
//                                           prefSelectedLanguageCode,
//                                           LanguageModel.languageList()[i]
//                                               .languageCode);
//                                       if (languageCode ==
//                                           LanguageModel.languageList()[i]
//                                               .languageCode) {
//                                         setState(() {
//                                           checklanguage[i] = true;
//                                         });
//                                       }

//                                     },
//                                     child: Padding(
//                                       padding: EdgeInsets.only(bottom: 2.h),
//                                       child: Container(
//                                         width: 80.w,
//                                         // height: 11.h,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                               BorderRadius.circular(2.h),
//                                           border: checklanguage[i]
//                                               ? Border.all(
//                                                   color: AppColors.blackColor,
//                                                   width: 1)
//                                               : Border.all(
//                                                   color: AppColors.primarycolor,
//                                                   width: 1),
//                                         ),
//                                         child: Padding(
//                                           padding: EdgeInsets.all(2.h),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             // mainAxisAlignment:
//                                             //     MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 LanguageModel.languageList()[i]
//                                                     .flag,
//                                                 style: AppStyle.bodytext_white
//                                                     .copyWith(
//                                                         color: Colors.black,
//                                                         fontSize: 16.sp),
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     LanguageModel .languageList()[i]  .name,
//                                                     style: AppStyle
//                                                         .bodytext_black
//                                                         .copyWith(
//                                                             color: AppColors
//                                                                 .primarycolor,
//                                                             fontSize: 14.sp),
//                                                   ),
//                                                   if (checklanguage[i])
//                                                     Icon(
//                                                       Icons.done,
//                                                       color: Colors.red,
//                                                     )
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             );
//                           }),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }
