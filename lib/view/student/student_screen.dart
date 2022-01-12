import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranapp/view/component/component.dart';
import 'package:quranapp/view/groups/group_list_screen.dart';
import 'package:quranapp/view_model/AppCupit/cubit.dart';

import 'package:quranapp/view_model/AppStates/state.dart';

class StudentScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var searchByNameController = TextEditingController();
  var searchByEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cupit = AppCubit.get(context);
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
                          AppCubit.get(context).getStudentSearchByName(
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
                        fillBoxColor: Colors.white,
                      ),
                    )
                  : Text(
                      "الطلاب",
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
              condition: AppCubit.get(context).studentResponse != null,
              builder: (context) {
                return Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        // showCheckboxColumn: false,
                        dataRowHeight: 70,

                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),

                        columns: [
                          DataColumn(
                            label: Text(
                              'اسم الطالب',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                          DataColumn(
                            label: cupit.selectedStudent.isNotEmpty
                                ? SizedBox(
                                    width: 200,
                                    height: 30,
                                    child: defaultButton(
                                        function: () {
                                          navigateTo(
                                              context,
                                              GroupListScreen(
                                                studentsId:
                                                    AppCubit.get(context)
                                                        .selectedStudent,
                                              ));
                                        },
                                        title: "Assign To Group",
                                        buttonColor: Colors.green[300],
                                        textColor: Colors.white),
                                  )
                                : Text(
                                    '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black),
                                  ),
                          ),
                        ],
                        rows: AppCubit.get(context)
                            .studentResponse
                            .result
                            .data
                            .collection
                            .map((e) => DataRow(
                                    selected:
                                        cupit.selectedStudent.contains(e.id),
                                    onSelectChanged: (isSelected) {
                                      AppCubit.get(context)
                                          .changeSelectedStudent(isSelected);
                                      cupit.isAdding
                                          ? cupit.selectedStudent.add(e.id)
                                          : cupit.selectedStudent.remove(e.id);
                                    },
                                    cells: [
                                      DataCell(
                                        Text(
                                          e.name,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
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
                backgroundColor: Colors.green[300],
              ))),
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
                                        "إسم الطالب ",
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
                                        "البريد الالكتروني للطالب ",
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
                                        condition:
                                            state is! CreateStudentLoadingState,
                                        builder: (context) {
                                          return defaultButton(
                                              width: 50,
                                              function: () {
                                                AppCubit.get(context)
                                                    .createStudent(
                                                        name:
                                                            nameController.text,
                                                        email: emailController
                                                            .text);
                                                Navigator.pop(context);
                                              },
                                              title: "إضافة",
                                              buttonColor: Colors.green[300],
                                              textColor: Colors.white);
                                        },
                                        fallback: (context) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      )),
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
                    AppCubit.get(context).updateStudent(
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
                    AppCubit.get(context).deleteStudent(id: id);
                    Navigator.pop(context, 'حذف');
                  },
                  child: const Text('حذف'),
                ),
              ],
            );
          });
    } else if (value == 3) {
      // navigateTo(context, AssignInstructorToGroup(id));
    }
  }
}
