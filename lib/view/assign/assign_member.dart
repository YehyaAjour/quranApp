import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/widgets.dart';

import 'package:quranapp/view_model/AppCupit/cubit.dart';

import 'package:quranapp/view_model/AppStates/state.dart';

class AssignMember extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 300,
                      width: 100,
                      color: Colors.red,
                    )),
                    Text('group name'),
                    Expanded(
                        child: Container(
                      height: 300,
                      width: 100,
                      color: Colors.green,
                    ))
                  ],
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
                          return LongPressDraggable(
                            feedback: Container(color: Colors.red,),
                            child: ListTile(
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
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        TextButton(
                                          child: Text("Assign"),
                                          onPressed: () {},
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
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
              ],
            ),
          ),
        );
      },
    );
  }
}
