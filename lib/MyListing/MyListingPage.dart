import 'package:educationapp/coreFolder/Controller/myListingController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';

import 'package:hive/hive.dart';

class MyListing extends ConsumerStatefulWidget {
  const MyListing({super.key});

  @override
  ConsumerState<MyListing> createState() => _MyListingState();
}

class _MyListingState extends ConsumerState<MyListing> {
  int voletId = 0;
  int currentBalance = 0;
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userdata");
    var userType = box.get("userType");
    final myListingProvider = ref.watch(myListingController);
    return Scaffold(
      backgroundColor: Color(0xFF1B1B1B),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 70.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30.w,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 44.h,
                    width: 44.w,
                    decoration: BoxDecoration(
                        color: Color(0xFF1B1B1B),
                        borderRadius: BorderRadius.circular(500.r)),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF1B1B1B),
                        size: 15.w,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  "My Listing",
                  style: GoogleFonts.roboto(
                      fontSize: 18.w,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff008080)),
                ),
                Spacer(),
                Container(
                  height: 44.h,
                  width: 44.w,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(39, 255, 255, 255),
                    borderRadius: BorderRadius.circular(500.r),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.search,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.w,
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r))),
              child: myListingProvider.when(
                data: (myListingData) {
                  if (myListingData.data.isEmpty) {
                    return Center(
                      child: Text(
                        "No List Available",
                        style: GoogleFonts.inter(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                    itemCount: myListingData.data.length,
                    itemBuilder: (context, index) {
                      final item = myListingData.data[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🟩 STATUS TAG
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.h, horizontal: 10.w),
                                decoration: BoxDecoration(
                                  color: item.status == "accepted"
                                      ? Colors.green.withOpacity(0.15)
                                      : Colors.orange.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  item.status.toUpperCase(),
                                  style: GoogleFonts.roboto(
                                    color: item.status == "accepted"
                                        ? Colors.green[800]
                                        : Colors.orange[800],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),

                            // 👩‍🎓 STUDENT SECTION
                            if (userType == "Mentor") ...[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(40.r),
                                    child: Image.network(
                                      item.studentProfile,
                                      height: 60.h,
                                      width: 60.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Label
                                        // Container(
                                        //   padding: EdgeInsets.symmetric(
                                        //       vertical: 3.h, horizontal: 8.w),
                                        //   decoration: BoxDecoration(
                                        //     color: Colors.blue.withOpacity(0.1),
                                        //     borderRadius:
                                        //         BorderRadius.circular(6.r),
                                        //   ),
                                        //   child: Text(
                                        //     "Student",
                                        //     style: GoogleFonts.roboto(
                                        //       color: Colors.blue[700],
                                        //       fontSize: 12.sp,
                                        //       fontWeight: FontWeight.w600,
                                        //     ),
                                        //   ),
                                        // ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          item.studentName,
                                          style: GoogleFonts.roboto(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          item.studentEmail,
                                          style: GoogleFonts.roboto(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        Text(
                                          item.studentPhone,
                                          style: GoogleFonts.roboto(
                                            fontSize: 13.sp,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ] else ...[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(40.r),
                                    child: Image.network(
                                      item.mentorProfile,
                                      height: 60.h,
                                      width: 60.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Label
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 3.h, horizontal: 8.w),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.purple.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                          ),
                                          child: Text(
                                            "Mentor",
                                            style: GoogleFonts.roboto(
                                              color: Colors.purple[700],
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          item.mentorName,
                                          style: GoogleFonts.roboto(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          item.mentorEmail,
                                          style: GoogleFonts.roboto(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        Text(
                                          item.mentorPhone,
                                          style: GoogleFonts.roboto(
                                            fontSize: 13.sp,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ]
                          ],
                        ),
                      );
                    },
                  );
                },
                error: (error, stackTrace) {
                  log(stackTrace.toString());
                  return Center(
                    child: Text(error.toString()),
                  );
                },
                loading: () => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DraggableBottomSheetContent extends ConsumerStatefulWidget {
  final int currentBalance;
  final String voletid;
  final Function callback;

  DraggableBottomSheetContent(
      {super.key,
      required this.callback,
      required this.voletid,
      required this.currentBalance});

  @override
  ConsumerState<DraggableBottomSheetContent> createState() =>
      _DraggableBottomSheetContentState();
}

class _DraggableBottomSheetContentState
    extends ConsumerState<DraggableBottomSheetContent> {
  final coinsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.r), topRight: Radius.circular(40.r))),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7, // Customize height
      child: Padding(
        padding: EdgeInsets.all(15.0.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 5.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Add Coins",
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.w),
                )
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            TextFormField(
              controller: coinsController,
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Choose Payment Method",
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 16.w,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: 400.w,
              height: 70.h,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 241, 242, 246),
                  borderRadius: BorderRadius.circular(20.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16.w,
                  ),
                  Container(
                    height: 35.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/logos_mastercard.png"),
                            fit: BoxFit.contain)),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Payment Method",
                        style: GoogleFonts.roboto(
                            fontSize: 11.w,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      Text(
                        "8799 4566 XXXX",
                        style: GoogleFonts.roboto(
                            fontSize: 18.w,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: 44.h,
                    width: 44.w,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(30, 38, 50, 56),
                      borderRadius: BorderRadius.circular(500.r),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 52.h,
                width: 400.w,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 220, 248, 129),
                    borderRadius: BorderRadius.circular(40.r)),
                child: Center(
                  child: Text(
                    "Continue",
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 16.w,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
