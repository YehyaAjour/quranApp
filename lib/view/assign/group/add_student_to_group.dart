import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranapp/view/component/component.dart';
import 'package:quranapp/view_model/AppCupit/cubit.dart';
import 'package:quranapp/view_model/AppStates/state.dart';


class AddStudentsToGroup extends StatelessWidget {
  var searchByNameController = TextEditingController();
  var searchByEmailController = TextEditingController();
  final int groub_id;

  AddStudentsToGroup({@required this.groub_id});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is AssignStudentToGroupSuccessState) {
          showToast(
              message: "quran_students.assigned_to_group_successfully",
              state: ToastState.SUCCESS);
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Column(
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
                              "اضافة طلاب",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
                                dataRowHeight: 60,

                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.white),

                                columns: [
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
                                    .studentResponse
                                    .result
                                    .data
                                    .collection
                                    .map((e) => DataRow(
                                            selected: cubit.selectedStudent
                                                .contains(e.id),
                                            onSelectChanged: (isSelected) {
                                              AppCubit.get(context)
                                                  .changeSelectedStudent(
                                                      isSelected);
                                              cubit.isAdding
                                                  ? cubit.selectedStudent
                                                      .add(e.id)
                                                  : cubit.selectedStudent
                                                      .remove(e.id);
                                            },
                                            cells: [
                                              DataCell(
                                                Text(
                                                  e.name,
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ),
                                              // DataCell(Text(e.email)),
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
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: cubit.isAdding
                        ? FloatingActionButton(
                            child: Icon(Icons.add),
                            backgroundColor: Colors.green,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(""),
                                    content: Text("Are you sure to assign"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("cancel"),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      TextButton(
                                        child: Text("Assign"),
                                        onPressed: () {
                                          AppCubit.get(context)
                                              .assignStudentToGroup(
                                                  groupId: groub_id,
                                                  studentsId:
                                                      cubit.selectedStudent)
                                              .then((value) {
                                            for (int x = 0; x < 2; x++) {
                                              Navigator.pop(context);
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          )
                        : Container(),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
