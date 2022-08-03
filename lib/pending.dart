// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../api_services/notary_service.dart';
// import '../../common/dialog.dart';
// import '../../common/order_detail_screen.dart';
// import '../../model/appointmenets.dart';
// import '../../utility/utility_widget.dart';
// import 'services/appointment_services.dart';

// class NewAppointmentScreen extends StatefulWidget {
//   static const String routeName = '/newappointment-screen';
//   const NewAppointmentScreen({Key? key}) : super(key: key);

//   @override
//   State<NewAppointmentScreen> createState() => _NewAppointmentScreenState();
// }

// bool isloading = false;

// int _pageSize = 30;

// final PagingController<int, dynamic> _pagingController =
//     PagingController(firstPageKey: 0);

// class _NewAppointmentScreenState extends State<NewAppointmentScreen> {
//   @override
//   void initState() {
//     _pagingController.addPageRequestListener((pageKey) {
//       _fetchPage(pageKey);
//     });
//     // _pagingController.refresh();
//     // _pageSize=1;
//     //   _fetchPage(1);

//     super.initState();
//   }

//   Future<void> _fetchPage(int pageKey) async {
//     try {
//       final newItems = await getDataFromApi();
//       print('******');
//       print(newItems);
//       final isLastPage = newItems.length < _pageSize;
//       if (isLastPage) {
//         _pagingController.appendLastPage(newItems);
//       } else {
//         final nextPageKey = pageKey + newItems.length;
//         _pagingController.appendPage(newItems, _pageSize++);
//       }
//     } catch (error) {
//       _pagingController.error = error;
//     }
//   }

//   Future<List<AppointmentInfo>> getDataFromApi() async {
//     List<AppointmentInfo> ai =
//         await NotaryServices.getPendingAppointment(PageNumber: 0);
//     return ai;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PagedListView<int, dynamic>(
//       pagingController: _pagingController,
//       builderDelegate: PagedChildBuilderDelegate<dynamic>(
//         itemBuilder: (context, item, index) =>
        
//          Column(
//           children: [
//             NewAppointmentCard(
//               singerFname: item.signerFirstName,
//               singerLname: item.signerLastName,
//               customerFname: item.customerFirstName,
//               customerLname: item.customerLastName,
//               comapnyName: item.companyName,
//               time: item.date,
//               customerEmail: item.customerEmailAddress,
//               singerEmail: item.signerEmailAddress,
//               customerPhone: item.customerPhoneNumber,
//               singerPhone: item.signerPhoneNumber,
//               drivingDistanceinMins: item.drivingDistanceinMins,
//               isOnlineSigning: item.isOnlineSigning,
//                 isPropertySigning: item.isPropertySigning,
//               appointment_id: item.appointment_id,
//             ),
//             if (index == _pagingController.itemList!.length - 1)
//               Container(
//                   padding: EdgeInsets.all(15), child: Text('NO More data'))
//           ],
//         ),
//       ),
//     );
//   }
// }



// class NewAppointmentCard extends StatefulWidget {
//   String? singerFname;
//   String? singerLname;
//   String? customerFname;
//   String? customerLname;
//   String? comapnyName;
//   String? time;
//   String? singerEmail;
//   String? customerEmail;
//   String? singerPhone;
//   String? customerPhone;
//   String? drivingDistanceinMins;
//   bool? isOnlineSigning;
//   bool? isPropertySigning;
//   String? appointment_id;
//   NewAppointmentCard({
//     this.singerFname,
//     this.singerLname,
//     this.customerFname,
//     this.customerLname,
//     this.comapnyName,
//     this.singerEmail,
//     this.customerEmail,
//     this.customerPhone,
//     this.singerPhone,
//     this.time,
//     this.drivingDistanceinMins,
//     this.isOnlineSigning,
//     this.isPropertySigning,
//     this.appointment_id,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<NewAppointmentCard> createState() => _NewAppointmentCardState();
// }

// class _NewAppointmentCardState extends State<NewAppointmentCard> {
//   @override
//   Widget build(BuildContext context) {
//     final controllerTosingerEmail = widget.singerEmail;
//     final controllerTocustomerEmail = widget.customerEmail;
//     final singerPhoneNumber = widget.singerPhone;
//     final customerPhoneNumber = widget.customerPhone;
//     final singerurl = 'tel:$singerPhoneNumber';
//     // if (await canLaunch(url)) {
//     //   await launch(url);
//     final customerurl = 'tel:$customerPhoneNumber';
//     // if (await canLaunch(url)) {
//     //   await launch(url);
//     // }
//     // DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
//     // DateTime dateTime = dateFormat.parse(widget.time!);
//     // final day =   DateFormat.yMMMMEEEEd().format(widget.time!..toString());
//     return Card(
//       elevation: 10,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 4,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           if (widget.isOnlineSigning == false)
//                             const Icon(
//                               CupertinoIcons.location,
//                               color: Colors.grey,
//                               size: 20,
//                             ),
//                           Text(
//                             widget.isOnlineSigning == true
//                                 ? 'Remote Signing'
//                                 : 'In person signing',
//                             style: const TextStyle(fontSize: 12),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             widget.drivingDistanceinMins!,
//                             style: const TextStyle(fontSize: 12),
//                           ),
//                           Container(
//                             color: Colors.black,
//                             width: 1,
//                             margin: const EdgeInsets.symmetric(horizontal: 4),
//                             height: 12,
//                           ),
//                           const Text(
//                             "45 mins",
//                             style: TextStyle(fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SpaceWidget(2),
//                 MailAndCallWidget(
//                     title: widget.singerFname! + widget.singerLname!,
//                     titleTextStyle:
//                         const TextStyle(fontWeight: FontWeight.bold),
//                     mailonTap: () {
//                       launchEmail(toEmail: controllerTosingerEmail.toString());
//                     },
//                     phoneonTap: () async {
//                       if (await canLaunch(singerurl)) {
//                         await launch(singerurl);
//                       }
//                     }),
//                 const SpaceWidget(4),
//                 const Text(
//                   "Customer Information:",
//                   style: TextStyle(
//                     fontSize: 12,
//                   ),
//                 ),
//                 const SpaceWidget(4),
//                 MailAndCallWidget(
//                   title: widget.customerFname! + widget.customerLname!,
//                   titleTextStyle: const TextStyle(fontSize: 12),
//                   mailonTap: () {
//                     launchEmail(toEmail: controllerTocustomerEmail.toString());
//                   },
//                   phoneonTap: () async {
//                     if (await canLaunch(customerurl)) {
//                       await launch(customerurl);
//                     }
//                   },
//                 ),
//                 const SpaceWidget(4),
//                 Text(
//                   widget.comapnyName!,
//                   style: const TextStyle(fontSize: 12),
//                 ),
//                 const SpaceWidget(6),
//                 Text(
//                   "Time: ${widget.time}",
//                   style: const TextStyle(fontSize: 12),
//                 ),
//               ],
//             ),
//           ),
//           Divider(
//             thickness: 1,
//             color: Colors.grey.shade500,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   widget.isPropertySigning == true
//                       ? ' This is Real Estate Signing'
//                       : 'This is not Real Estate Signing',
//                 ),
//                 const SpaceWidget(4),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ElevatedButton(
//                       child: const Text(
//                         'Reject',
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                       onPressed: () {
//                         showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return DialogBox(
//                                   appointment_id: widget.appointment_id);
//                             });
//                       },
//                       style: ElevatedButton.styleFrom(
//                           fixedSize:
//                               Size(MediaQuery.of(context).size.width / 3.5, 32),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(32)),
//                           primary: const Color(0xFFfbb3ae)),
//                     ),
//                     const SizedBox(
//                       width: 8,
//                     ),
//                     ElevatedButton(
//                       child: isloading
//                           ? CircularProgressIndicator(
//                               color: Colors.white,
//                             )
//                           : Text(
//                               'Accept',
//                               style: const TextStyle(
//                                 color: Colors.black,
//                               ),
//                             ),
//                       onPressed: () async {
//                         if (isloading) return;
//                         setState(() {
//                           isloading = true;
//                         });
//                         await Future.delayed(Duration(seconds: 2));
//                         NotaryServices.acceptAppointment(widget.appointment_id!)
//                             .whenComplete(
//                                 () => {showtoast('Appointment Accepted')});
//                         setState(() {
//                           isloading = false;
//                         });
//                       },
//                       style: ElevatedButton.styleFrom(
//                           fixedSize:
//                               Size(MediaQuery.of(context).size.width / 3.5, 32),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(32)),
//                           primary: const Color(0xFF8a97d2)),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Future launchEmail({required String toEmail}) async {
//     final url = 'mailto:$toEmail';

//     if (await canLaunch(url)) {
//       await launch(url);
//     }
//   }
// }