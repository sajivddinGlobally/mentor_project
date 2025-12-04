import 'dart:developer';

import 'package:educationapp/coreFolder/Controller/getRequestStudentController.dart';
import 'package:educationapp/coreFolder/Controller/homeDataController.dart';
import 'package:educationapp/coreFolder/Controller/myListingController.dart';
import 'package:educationapp/coreFolder/Model/sendRequestBodyModel.dart';
import 'package:educationapp/coreFolder/network/api.state.dart';
import 'package:educationapp/coreFolder/utils/preety.dio.dart';
import 'package:educationapp/home/home.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestPage extends ConsumerStatefulWidget {
  const RequestPage({super.key});

  @override
  ConsumerState<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends ConsumerState<RequestPage> {
  String? requestLenght;
  bool isAccept = false;
  @override
  Widget build(BuildContext context) {
    final getRequestHomeData = ref.watch(getRequestStudentController);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "New Request",
          style: GoogleFonts.roboto(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          getRequestHomeData.when(
            data: (requestData) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  requestLenght = requestData.data.length.toString();
                });
              });

              if (requestData.data.isEmpty) {
                return Center(
                  child: Text(
                    "No Request Available",
                    style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: requestData.data.length,
                itemBuilder: (context, index) {
                  final student = requestData.data[index];
                  return GetRequestStudentBody(
                    image: student.studentProfile ??
                        "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png",
                    title: student.studentName,
                    subtitle: student.studentType,
                    email: student.studentEmail,
                    phone: student.studentPhone,
                    callBack: () async {
                      final body = AcceptRequestBodyModel(
                          requestId: requestData.data[index].id);
                      try {
                        setState(() {
                          isAccept = true;
                        });
                        final service = APIStateNetwork(createDio());
                        final response = await service.acceptRequest(body);
                        if (response.status == true) {
                          Fluttertoast.showToast(msg: response.message);
                          ref.invalidate(getHomeMentorDataProvider);
                          ref.invalidate(getRequestStudentController);
                          ref.invalidate(myListingController);
                        } else {
                          Fluttertoast.showToast(msg: response.message);
                        }
                      } catch (e, st) {
                        log("${e.toString()} /n ${st.toString()}");
                        Fluttertoast.showToast(msg: "Not Accept");
                      } finally {
                        setState(() {
                          isAccept = false;
                        });
                      }
                    },
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
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
