import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

import 'package:quranapp/view_model/AppCupit/cubit.dart';

class GetInstructorScreen extends StatelessWidget {
  String instructor_name;
  String instructor_email;
  String instructor_join_at;

  GetInstructorScreen(
      {this.instructor_email, this.instructor_join_at, this.instructor_name});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                BackButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: double.infinity,
                        height: 180,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              child: FlutterLogo(
                                size: 40,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              instructor_name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              instructor_email,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              instructor_join_at,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ConditionalBuilder(
                        condition: AppCubit.get(context)
                            .getInstructorResponse
                            .result
                            .data
                            .instructor
                            .group
                            .isNotEmpty,
                        builder: (context) {
                          return Container(
                            width: double.infinity,
                            //  height: 120,
                            decoration: BoxDecoration(
                                // gradient: LinearGradient(
                                //     // begin: FractionalOffset.topRight,
                                //     // end: FractionalOffset.bottomLeft,
                                //     colors: [
                                //       Colors.green[300],
                                //       Colors.green[600]
                                //     ]),
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Assignd group",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Group Name:",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        width: 150,
                                        child: Text(
                                          AppCubit.get(context)
                                              .getInstructorResponse
                                              .result
                                              .data
                                              .instructor
                                              .group[0]
                                              .name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Created At :",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        width: 150,
                                        child: Text(
                                          AppCubit.get(context)
                                              .getInstructorResponse
                                              .result
                                              .data
                                              .instructor
                                              .group[0]
                                              .createdAt,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        fallback: (context) => Text("Not Assign in group"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ConditionalBuilder(
                      condition: AppCubit.get(context)
                              .getInstructorResponse
                              .result
                              .data
                              .instructor
                              .group
                              .isNotEmpty &&
                          AppCubit.get(context)
                              .getInstructorResponse
                              .result
                              .data
                              .instructor
                              .group[0]
                              .students
                              .isNotEmpty,
                      builder: (context) {
                        return GridView.builder(
                          padding: EdgeInsets.all(20.0),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 15,
                            mainAxisExtent: 70,
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: FractionalOffset.topRight,
                                    end: FractionalOffset.bottomLeft,
                                    colors: [Colors.green[300], Colors.green]),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                  child: Text(
                                AppCubit.get(context)
                                    .getInstructorResponse
                                    .result
                                    .data
                                    .instructor
                                    .group[0]
                                    .students[index]
                                    .name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                            );
                          },
                          itemCount: AppCubit.get(context)
                              .getInstructorResponse
                              .result
                              .data
                              .instructor
                              .group[0]
                              .students
                              .length,
                        );
                      },
                      fallback: (context) => Text("No Student To Show"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
