import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranapp/view/assign/group/add_student_to_group.dart';
import 'package:quranapp/view/assign/group/assign_group_to_instructor.dart';
import 'package:quranapp/view_model/AppStates/state.dart';

import 'package:quranapp/view/component/component.dart';
import 'package:quranapp/view_model/AppCupit/cubit.dart';

class GroupsScreen extends StatelessWidget {
  var nameController = TextEditingController();

  var searchByNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is CreateGroupSuccessState) {
          showToast(message: "add Successful", state: ToastState.SUCCESS);
        } else if (state is CreateGroupErrorState) {
          showToast(message: "Error", state: ToastState.ERROR);
        }
        if (state is UpdateGroupSuccessState) {
          showToast(message: "update Successful", state: ToastState.SUCCESS);
        } else if (state is UpdateGroupErrorState) {
          showToast(message: "Error", state: ToastState.ERROR);
        }
        if (state is DeleteGroupSuccessState) {
          showToast(message: "delete Successful", state: ToastState.SUCCESS);
        } else if (state is DeleteGroupErrorState) {
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
                            AppCubit.get(context).getGroupSearchByName(
                                nameSearch: value, emailSearch: value);
                          },
                          prefix: Icons.search,
                          prefixColor: Colors.green[300],
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
                      "الحلقات",
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
              condition: AppCubit.get(context).groupResponse != null,
              builder: (context) {
                return Expanded(
                  child: ListView.separated(
                    itemCount: AppCubit.get(context)
                        .groupResponse
                        .result
                        .data
                        .collection
                        .length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                    child: Image.asset(
                                        "assets/icons/qurangroup.png")),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  AppCubit.get(context)
                                      .groupResponse
                                      .result
                                      .data
                                      .collection[index]
                                      .name
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Assign member',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  width: 70,
                                  height: 50,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            IntrinsicHeight(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          navigateTo(
                                              context,
                                              AssignGroupToInstructorScreen(
                                                group_id: AppCubit.get(context)
                                                    .groupResponse
                                                    .result
                                                    .data
                                                    .collection[index]
                                                    .id,
                                              ));
                                        },
                                        child: Text(
                                          "تعيين محفظ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.black),
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    VerticalDivider(
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        navigateTo(
                                            context,
                                            AddStudentsToGroup(
                                              groub_id: AppCubit.get(context)
                                                  .groupResponse
                                                  .result
                                                  .data
                                                  .collection[index]
                                                  .id,
                                            ));
                                      },
                                      child: Text("إضافة طلاب",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem<int>(
                              value: 0,
                              child: Text(
                                "Edit",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            PopupMenuItem<int>(
                              value: 1,
                              child: Text(
                                "Delete",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                          onSelected: (item) =>
                              {popItemSelected(item, context, index)},
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
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
                                        "إسم الحلقة ",
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
                                    height: 15,
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
                                                      .createGroup(
                                                    name: nameController.text,
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                title: "إضافة",
                                                buttonColor: Colors.green[300],
                                                textColor: Colors.white);
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

  Widget popItemSelected(value, context, index) {
    if (value == 0) {
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
                    AppCubit.get(context).updateGroup(
                        id: AppCubit.get(context)
                            .groupResponse
                            .result
                            .data
                            .collection[index]
                            .id,
                        name: nameController.text);
                    Navigator.pop(context, 'تعديل');
                  },
                  child: const Text('تعديل'),
                ),
              ],
            );
          });
    } else if (value == 1) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'هل أنت متأكد من حذف  ' +
                    AppCubit.get(context)
                        .groupResponse
                        .result
                        .data
                        .collection[index]
                        .name,
                style: TextStyle(fontSize: 15),
              ),
              content: Text(
                ' جميع بيانات ${AppCubit.get(context).groupResponse.result.data.collection[index].name} سوف تحذف ',
                style: TextStyle(fontSize: 15),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'إلغاء'),
                  child: const Text('إلغاء'),
                ),
                TextButton(
                  onPressed: () {
                    AppCubit.get(context).deleteGroup(
                      id: AppCubit.get(context)
                          .groupResponse
                          .result
                          .data
                          .collection[index]
                          .id,
                    );
                    Navigator.pop(context, 'حذف');
                  },
                  child: const Text('حذف'),
                ),
              ],
            );
          });
    }
  }
}
