// import 'package:flutter/material.dart';

// import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';
// import 'package:myshop/views/home_screen.dart';
// import '../constant.dart';
// import '../utils/screen_size.dart';
// import '../view_models/currency_changer.dart';
// import '../view_models/store_view_model.dart';
// import 'button.dart';

// confirmModal(context, Map item) async {
//   return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!

//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           clipBehavior: Clip.antiAliasWithSaveLayer,
//           contentPadding: const EdgeInsets.all(0),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           insetPadding:
//               EdgeInsets.symmetric(vertical: ScreenSize().getScreenWidth(0)),
//           content: SizedBox(
//               height: Displaylandscape
//                   ? ScreenSize().getScreenHeight(25)
//                   : ScreenSize().getScreenHeight(15),
//               width: Displaylandscape
//                   ? ScreenSize().getScreenWidth(30)
//                   : ScreenSize().getScreenWidth(24),
//               child: Consumer2<StoreViewModel, CurrencyViewModel>(
//                 builder: (context, myStore, myCurrency, child) {
//                   return Container(
//                       clipBehavior: Clip.antiAliasWithSaveLayer,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: BACKGROUND_PAIR_COLOR,
//                         borderRadius: BorderRadius.circular(
//                           ScreenSize().getScreenHeight(0),
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Container(
//                             height: Displaylandscape
//                                 ? ScreenSize().getScreenHeight(8)
//                                 : ScreenSize().getScreenHeight(5),
//                             width: Displaylandscape
//                                 ? ScreenSize().getScreenWidth(60)
//                                 : ScreenSize().getScreenWidth(60),
//                             color: Colors.white,
//                             child: Center(
//                               child: Image.asset(
//                                 'assets/images/${IMAGES[0]}',
//                                 height: Displaylandscape
//                                     ? ScreenSize().getScreenHeight(6)
//                                     : ScreenSize().getScreenHeight(2.8),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: ScreenSize().getScreenHeight(1),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Do You Want to Remove  this ',
//                                 style: TextStyle(
//                                     fontSize: Displaylandscape
//                                         ? ScreenSize().getScreenHeight(2)
//                                         : ScreenSize().getScreenHeight(1),
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Item From Cart?',
//                                 style: TextStyle(
//                                     fontSize: Displaylandscape
//                                         ? ScreenSize().getScreenHeight(2)
//                                         : ScreenSize().getScreenHeight(1),
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                             ],
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: Displaylandscape
//                                     ? ScreenSize().getScreenWidth(2.5)
//                                     : ScreenSize().getScreenWidth(2),
//                                 vertical: Displaylandscape
//                                     ? ScreenSize().getScreenHeight(1.5)
//                                     : ScreenSize().getScreenHeight(1)),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               //  crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     Provider.of<StoreViewModel>(context,
//                                             listen: false)
//                                         .removeItem(context, item);
//                                     Navigator.pop(context);
//                                   },
//                                   // ignore: prefer_const_constructors
//                                   child: ConfigBtn(
//                                     btn: SECONDARY_COLOR,
//                                     btnText: 'REMOVE',
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: ScreenSize().getScreenHeight(0.8),
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: const ConfigBtn(
//                                     btn: PRIMARY_COLOR,
//                                     btnText: 'CANCEL',
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ));
//                 },
//               )),
//         );
//       });
// }
