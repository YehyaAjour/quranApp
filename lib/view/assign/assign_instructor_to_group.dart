import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranapp/view/component/component.dart';
import 'package:quranapp/view_model/AppCupit/cubit.dart';
import 'package:quranapp/view_model/AppStates/state.dart';


class AssignInstructorToGroup extends StatelessWidget {
  var searchByNameController = TextEditingController();
  int instructor_id;

  AssignInstructorToGroup(this.instructor_id);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is AssignInstructorToGroupSuccessState) {
          showToast(
              message:
                  AppCubit.get(context).assignInstructorResponse.result.message,
              state: ToastState.SUCCESS);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                AppBar(
                  leading: AppCubit.get(context).isSearching
                      ? BackButton(
                          onPressed: () {
                            AppCubit.get(context)
                                .changeSearchState(isSearchingShown: false);
                          },
                        )
                      : BackButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
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
                          "Assign To Group",
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
                            title: Row(
                              children: [
                                CircleAvatar(
                                    child: Image.asset(
                                        "assets/icons/qurangroup.png")),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(AppCubit.get(context)
                                    .groupResponse
                                    .result
                                    .data
                                    .collection[index]
                                    .name
                                    .toString()),
                              ],
                            ),
                            onTap: () {
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
                                              .assignInstructorToGroup(
                                                  groupId: AppCubit.get(context)
                                                      .groupResponse
                                                      .result
                                                      .data
                                                      .collection[index]
                                                      .id,
                                                  instructorId: instructor_id)
                                              .then((value) {
                                            for (int x = 0; x < 1; x++) {
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
              ],
            ),
          ),
        );
      },
    );
  }
}
