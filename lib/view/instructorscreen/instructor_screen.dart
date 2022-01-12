import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranapp/view/assign/assign_instructor_to_group.dart';

import 'package:quranapp/view/component/component.dart';
import 'package:quranapp/view/getinstructorscreen/get_instructor_screen.dart';
import 'package:quranapp/view_model/AppCupit/cubit.dart';

import 'package:quranapp/view_model/AppStates/state.dart';

class InstructorScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var searchByNameController = TextEditingController();
  var searchByEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is CreateInstructorSuccessState) {
          showToast(message: "add Successful", state: ToastState.SUCCESS);
        } else if (state is CreateInstructorErrorState) {
          showToast(message: "Error", state: ToastState.ERROR);
        }
        if (state is UpdateInstructorSuccessState) {
          showToast(message: "update Successful", state: ToastState.SUCCESS);
        } else if (state is UpdateInstructorErrorState) {
          showToast(message: "Error", state: ToastState.ERROR);
        }
        if (state is DeleteInstructorSuccessState) {
          showToast(message: "delete Successful", state: ToastState.SUCCESS);
        } else if (state is DeleteInstructorErrorState) {
          showToast(message: "Error", state: ToastState.ERROR);
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            AppBar(
              leading: AppCubit.get(context).isSearching
                  ? BackButton(
                      onPressed: () {
                        AppCubit.get(context)
                            .changeSearchState(isSearchingShown: false);
                      },
                    )
                  : null,
              toolbarHeight: 65,
              title: AppCubit.get(context).isSearching
                  ? SizedBox(
                      height: 50,
                      child: defaultTextFormField(
                          onchange: (value) {
                            AppCubit.get(context).getInstructorSearchByName(
                                nameSearch: value, emailSearch: value);
                          },
                          prefix: Icons.search,
                          prefixColor: Colors.teal,
                          controller: searchByNameController,
                          keyboardType: TextInputType.text,
                          validate: (value) {
                            print("value");
                          },
                          labelText: "",
                          inputBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          fillBoxColor: Colors.white),
                    )
                  : Text(
                      "المحفظين",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
              backgroundColor: Colors.green[400],
              elevation: 0,
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    AppCubit.get(context)
                        .changeSearchState(isSearchingShown: true);
                  },
                )
              ],
            ),
            SizedBox(
              height: 1,
            ),
            ConditionalBuilder(
              condition: AppCubit.get(context).instructorResponse != null,
              builder: (context) {
                return Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        // showCheckboxColumn: false,
                        dataRowHeight: 70,
                        columnSpacing: 150,

                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent),

                        columns: [
                          DataColumn(
                            label: Text(
                              'إسم المحفظ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                        rows: AppCubit.get(context)
                            .instructorResponse
                            .result
                            .data
                            .collection
                            .map((e) => DataRow(cells: [
                                  DataCell(
                                      Text(
                                        e.name,
                                        style: TextStyle(fontSize: 15),
                                      ), onTap: () {
                                    AppCubit.get(context)
                                        .getAssignInstructor(e.id)
                                        .then((value) {
                                      navigateTo(
                                          context,
                                          GetInstructorScreen(
                                            instructor_email: e.email,
                                            instructor_name: e.name,
                                            instructor_join_at: e.joinedAt,
                                          ));
                                    });
                                  }),
                                  // DataCell(Text(e.email)),
                                  DataCell(
                                    Row(
                                      children: [
                                        PopupMenuButton(
                                          itemBuilder: (context) => [
                                            PopupMenuItem<int>(
                                              value: 0,
                                              child: Text(
                                                "Details",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            PopupMenuItem<int>(
                                              value: 1,
                                              child: Text(
                                                "Update",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            PopupMenuItem<int>(
                                              value: 2,
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            PopupMenuItem<int>(
                                              value: 3,
                                              child: Text(
                                                "Assign To Group",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                          onSelected: (value) {
                                            popItemSelected(
                                                value: value,
                                                email: e.email,
                                                name: e.name,
                                                context: context,
                                                id: e.id);
                                          },
                                        ),
                                        // InkWell(
                                        //   child: Icon(
                                        //     Icons.perm_device_information,
                                        //     size: 20,
                                        //   ),
                                        //   onTap: () {
                                        //     showDialog(
                                        //       context: context,
                                        //       builder: (context) => AlertDialog(
                                        //         title: Text("معلومات"),
                                        //         content: Column(
                                        //           crossAxisAlignment:
                                        //               CrossAxisAlignment.start,
                                        //           mainAxisSize:
                                        //               MainAxisSize.min,
                                        //           children: [
                                        //             Text(
                                        //               "البريد الإلكتروني",
                                        //               style: TextStyle(
                                        //                   fontSize: 20,
                                        //                   fontWeight:
                                        //                       FontWeight.bold),
                                        //             ),
                                        //             SizedBox(
                                        //               height: 10,
                                        //             ),
                                        //             Text(e.email),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     );
                                        //   },
                                        // ),
                                        // SizedBox(
                                        //   width: 20,
                                        // ),
                                        // InkWell(
                                        //   child: Icon(
                                        //     Icons.edit,
                                        //     size: 20,
                                        //   ),
                                        //   onTap: () {
                                        //     emailController.text = e.email;
                                        //     nameController.text = e.name;
                                        //
                                        //     showDialog(
                                        //         context: context,
                                        //         builder:
                                        //             (BuildContext context) {
                                        //           return AlertDialog(
                                        //             title: Text('تعديل'),
                                        //             content:
                                        //                 SingleChildScrollView(
                                        //               child: Container(
                                        //                 //  padding: EdgeInsets.all(16),
                                        //                 // color: Color(0xfff4f8fb),
                                        //                 child: Column(
                                        //                   mainAxisSize:
                                        //                       MainAxisSize.min,
                                        //                   children: [
                                        //                     Row(
                                        //                       children: [
                                        //                         Text(
                                        //                           "تغيير الإسم ",
                                        //                           style: TextStyle(
                                        //                               color: Colors
                                        //                                   .black,
                                        //                               fontWeight:
                                        //                                   FontWeight
                                        //                                       .bold),
                                        //                         ),
                                        //                       ],
                                        //                     ),
                                        //                     SizedBox(
                                        //                       height: 10,
                                        //                     ),
                                        //                     defaultTextFormField(
                                        //                         fillBoxColor:
                                        //                             Colors
                                        //                                 .white,
                                        //                         prefix: Icons
                                        //                             .person_rounded,
                                        //                         inputBorder:
                                        //                             OutlineInputBorder(),
                                        //                         controller:
                                        //                             nameController,
                                        //                         keyboardType:
                                        //                             TextInputType
                                        //                                 .text,
                                        //                         validate:
                                        //                             (value) {
                                        //                           if (value
                                        //                               .isEmpty) {
                                        //                             return "Enter Name pl";
                                        //                           }
                                        //                           return null;
                                        //                         },
                                        //                         labelText:
                                        //                             "الإسم الجديد"),
                                        //                     SizedBox(
                                        //                       height: 10,
                                        //                     ),
                                        //                     Row(
                                        //                       children: [
                                        //                         Text(
                                        //                           "تعديل البريد الإلكتروني ",
                                        //                           style: TextStyle(
                                        //                               color: Colors
                                        //                                   .black,
                                        //                               fontWeight:
                                        //                                   FontWeight
                                        //                                       .bold),
                                        //                         ),
                                        //                       ],
                                        //                     ),
                                        //                     SizedBox(
                                        //                       height: 10,
                                        //                     ),
                                        //                     defaultTextFormField(
                                        //                         fillBoxColor:
                                        //                             Colors
                                        //                                 .white,
                                        //                         prefix:
                                        //                             Icons.email,
                                        //                         inputBorder:
                                        //                             OutlineInputBorder(),
                                        //                         controller:
                                        //                             emailController,
                                        //                         keyboardType:
                                        //                             TextInputType
                                        //                                 .emailAddress,
                                        //                         validate:
                                        //                             (value) {
                                        //                           if (value
                                        //                               .isEmpty) {
                                        //                             return "Enter Name pl";
                                        //                           }
                                        //                           return null;
                                        //                         },
                                        //                         labelText:
                                        //                             "البريد الإلكتروني الجديد"),
                                        //                     SizedBox(
                                        //                       height: 10,
                                        //                     ),
                                        //                     Row(
                                        //                       children: [
                                        //                         Text(
                                        //                           "تعديل كلمة السر",
                                        //                           style: TextStyle(
                                        //                               color: Colors
                                        //                                   .black,
                                        //                               fontWeight:
                                        //                                   FontWeight
                                        //                                       .bold),
                                        //                         ),
                                        //                       ],
                                        //                     ),
                                        //                     SizedBox(
                                        //                       height: 10,
                                        //                     ),
                                        //                     defaultTextFormField(
                                        //                         fillBoxColor:
                                        //                             Colors
                                        //                                 .white,
                                        //                         prefix:
                                        //                             Icons.lock,
                                        //                         inputBorder:
                                        //                             OutlineInputBorder(),
                                        //                         controller:
                                        //                             passwordController,
                                        //                         keyboardType:
                                        //                             TextInputType
                                        //                                 .visiblePassword,
                                        //                         validate:
                                        //                             (value) {},
                                        //                         labelText:
                                        //                             "كلمة السر الجديدة"),
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //             actions: <Widget>[
                                        //               TextButton(
                                        //                 onPressed: () =>
                                        //                     Navigator.pop(
                                        //                         context,
                                        //                         'إلغاء'),
                                        //                 child:
                                        //                     const Text('إلغاء'),
                                        //               ),
                                        //               TextButton(
                                        //                 onPressed: () {
                                        //                   AppCubit.get(context)
                                        //                       .updateInstructor(
                                        //                     id: e.id,
                                        //                     name: nameController
                                        //                                 .text !=
                                        //                             e.name
                                        //                         ? nameController
                                        //                             .text
                                        //                         : null,
                                        //                     email: emailController
                                        //                                 .text !=
                                        //                             e.email
                                        //                         ? emailController
                                        //                             .text
                                        //                         : null,
                                        //                     password:
                                        //                         passwordController
                                        //                             .text,
                                        //                   );
                                        //                   Navigator.pop(
                                        //                       context, 'تعديل');
                                        //                 },
                                        //                 child:
                                        //                     const Text('تعديل'),
                                        //               ),
                                        //             ],
                                        //           );
                                        //         });
                                        //   },
                                        // ),
                                        // SizedBox(
                                        //   width: 20,
                                        // ),
                                        // InkWell(
                                        //   child: Icon(
                                        //     Icons.delete,
                                        //     size: 20,
                                        //   ),
                                        //   onTap: () {
                                        //     showDialog(
                                        //         context: context,
                                        //         builder:
                                        //             (BuildContext context) {
                                        //           return AlertDialog(
                                        //             title: Text(
                                        //                 'هل أنت متأكد من حذف  ' +
                                        //                     e.name),
                                        //             content: Text(
                                        //                 ' جميع بيانات ${e.name} سوف تحذف '),
                                        //             actions: <Widget>[
                                        //               TextButton(
                                        //                 onPressed: () =>
                                        //                     Navigator.pop(
                                        //                         context,
                                        //                         'إلغاء'),
                                        //                 child:
                                        //                     const Text('إلغاء'),
                                        //               ),
                                        //               TextButton(
                                        //                 onPressed: () {
                                        //                   AppCubit.get(context)
                                        //                       .deleteInstructor(
                                        //                           id: e.id);
                                        //                   Navigator.pop(
                                        //                       context, 'حذف');
                                        //                 },
                                        //                 child:
                                        //                     const Text('حذف'),
                                        //               ),
                                        //             ],
                                        //           );
                                        //         });
                                        //   },
                                        // ),
                                      ],
                                    ),
                                  ),
                                ]))
                            .toList(),
                      ),
                    ),
                  ),
                );
              },
              fallback: (context) => Expanded(
                  child: Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.green[300]))),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 16),
                child: FloatingActionButton(
                  backgroundColor: Colors.green[300],
                  child: Icon(AppCubit.get(context).floatIcon),
                  onPressed: () {
                    if (AppCubit.get(context).isBottomSheetShown) {
                      Navigator.pop(context);
                      AppCubit.get(context)
                          .changeBottomSheet(sheetShow: false, icon: Icons.add);
                    } else {
                      Scaffold.of(context).showBottomSheet((context) =>
                          SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              color: Color(0xfff4f8fb),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "إسم المحفظ ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  defaultTextFormField(
                                      fillBoxColor: Colors.white,
                                      prefix: Icons.person_rounded,
                                      prefixColor: Colors.green[300],
                                      inputBorder: OutlineInputBorder(),
                                      controller: nameController,
                                      keyboardType: TextInputType.text,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return "Enter Name pl";
                                        }
                                        return null;
                                      },
                                      labelText: ""),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "البريد الالكتروني للمحفظ ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  defaultTextFormField(
                                      fillBoxColor: Colors.white,
                                      prefix: Icons.email,
                                      prefixColor: Colors.green[300],
                                      inputBorder: OutlineInputBorder(),
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return "Enter Name pl";
                                        }
                                        return null;
                                      },
                                      labelText: ""),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "كلمة السر",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  defaultTextFormField(
                                      fillBoxColor: Colors.white,
                                      prefix: Icons.lock,
                                      prefixColor: Colors.green[300],
                                      inputBorder: OutlineInputBorder(),
                                      controller: passwordController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validate: (value) {},
                                      labelText: "إختياري"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ConditionalBuilder(
                                          condition: state
                                              is! CreateInstructorLoadingState,
                                          builder: (context) {
                                            return defaultButton(
                                                width: 50,
                                                function: () {
                                                  AppCubit.get(context)
                                                      .createInstructor(
                                                          name: nameController
                                                              .text,
                                                          email: emailController
                                                              .text);
                                                  Navigator.pop(context);
                                                },
                                                title: "إضافة",
                                                buttonColor: Colors.green[300],
                                                textColor: Colors.black);
                                          },
                                          fallback: (context) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: defaultButton(
                                          width: 50,
                                          function: () {
                                            Navigator.pop(context);
                                          },
                                          title: "إلغاء",
                                          buttonColor: Colors.white,
                                          textColor: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                          ));
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget popItemSelected(
      {int value, BuildContext context, String email, String name, id}) {
    if (value == 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("معلومات"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "البريد الإلكتروني",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(email),
            ],
          ),
        ),
      );
    } else if (value == 1) {
      emailController.text = email;
      nameController.text = name;

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('تعديل'),
              content: SingleChildScrollView(
                child: Container(
                  //  padding: EdgeInsets.all(16),
                  // color: Color(0xfff4f8fb),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            "تغيير الإسم ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      defaultTextFormField(
                          fillBoxColor: Colors.white,
                          prefix: Icons.person_rounded,
                          inputBorder: OutlineInputBorder(),
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          validate: (value) {
                            if (value.isEmpty) {
                              return "Enter Name pl";
                            }
                            return null;
                          },
                          labelText: "الإسم الجديد"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "تعديل البريد الإلكتروني ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      defaultTextFormField(
                          fillBoxColor: Colors.white,
                          prefix: Icons.email,
                          inputBorder: OutlineInputBorder(),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return "Enter Name pl";
                            }
                            return null;
                          },
                          labelText: "البريد الإلكتروني الجديد"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "تعديل كلمة السر",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      defaultTextFormField(
                          fillBoxColor: Colors.white,
                          prefix: Icons.lock,
                          inputBorder: OutlineInputBorder(),
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validate: (value) {},
                          labelText: "كلمة السر الجديدة"),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'إلغاء'),
                  child: const Text('إلغاء'),
                ),
                TextButton(
                  onPressed: () {
                    AppCubit.get(context).updateInstructor(
                      id: id,
                      name: nameController.text != name
                          ? nameController.text
                          : null,
                      email: emailController.text != email
                          ? emailController.text
                          : null,
                      password: passwordController.text,
                    );
                    Navigator.pop(context, 'تعديل');
                  },
                  child: const Text('تعديل'),
                ),
              ],
            );
          });
    } else if (value == 2) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('هل أنت متأكد من حذف  ' + name),
              content: Text(' جميع بيانات ${name} سوف تحذف '),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'إلغاء'),
                  child: const Text('إلغاء'),
                ),
                TextButton(
                  onPressed: () {
                    AppCubit.get(context).deleteInstructor(id: id);
                    Navigator.pop(context, 'حذف');
                  },
                  child: const Text('حذف'),
                ),
              ],
            );
          });
    } else if (value == 3) {
      navigateTo(context, AssignInstructorToGroup(id));
    }
  }
}
