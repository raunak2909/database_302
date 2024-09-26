import 'package:database_302/add_note_page.dart';
import 'package:database_302/bloc/db_bloc.dart';
import 'package:database_302/bloc/db_event.dart';
import 'package:database_302/bloc/db_state.dart';
import 'package:database_302/cubit/db_cubit.dart';
import 'package:database_302/cubit/db_state.dart';
import 'package:database_302/db_helper.dart';
import 'package:database_302/db_provider.dart';
import 'package:database_302/note_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  List<NoteModel> allNotes = [];
  DateFormat mFormat = DateFormat.yMd();

  @override
  Widget build(BuildContext context) {
    /*context.read<DBProvider>().getInitialNotes();*/
   // context.read<DBCubit>().getInitialNotes();
   context.read<DBBloc>().add(GetInitialNotesEvent());



    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: BlocBuilder<DBBloc, DBMainState>(
        builder: (_, state) {
          if (state is DBMainLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is DBMainErrorState) {
            return Center(
              child: Text('Error: ${state.errorMsg}'),
            );
          }

          if (state is DBMainLoadedState) {
            allNotes = state.mData;

            return allNotes.isNotEmpty
                ? ListView.builder(
                    itemCount: allNotes.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(allNotes[index].title),
                            Text(
                              mFormat.format(
                                  DateTime.fromMillisecondsSinceEpoch(int.parse(
                                      allNotes[index].created_at))),
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        subtitle:
                            Text(allNotes[index].desc),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              ///update
                              IconButton(
                                  onPressed: () async {
                                    /*var title = allNotes[index]
                                        [DBHelper.COLUMN_NOTE_TITLE];
                                    var desc = allNotes[index]
                                        [DBHelper.COLUMN_NOTE_DESC];
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddNotePage(
                                            isUpdate: true,
                                            id: allNotes[index]
                                                [DBHelper.COLUMN_NOTE_ID],
                                            title: title,
                                            desc: desc,
                                          ),
                                        ));*/

                                    /*showModalBottomSheet(context: context, builder: (_){
                                return getBottomSheetUI(isUpdate: true, id: allNotes[index][DBHelper.COLUMN_NOTE_ID]);
                              });*/
                                  },
                                  icon: Icon(Icons.edit)),

                              ///delete
                              IconButton(
                                  onPressed: () async {
                                    /*bool check = await dbHelper.deleteNote(id: allNotes[index][DBHelper.COLUMN_NOTE_ID]);
                              if(check){
                                getMyNotes();
                              }*/
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No Notes yet'),
                        OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddNotePage(),
                                  ));

                              /*showModalBottomSheet(
                            isDismissible: false,
                            enableDrag: false,
                            context: context,
                            builder: (_) {
                              return getBottomSheetUI();
                            });*/
                            },
                            child: Text('Add First Note'))
                      ],
                    ),
                  );
          }

          return Container();
        },
      ),
      floatingActionButton: BlocBuilder<DBBloc, DBMainState>(
        builder: (_, state) {
          if (state is DBMainLoadedState) {
            if (state.mData.isNotEmpty) {
              return FloatingActionButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNotePage(),
                      ));
                  /*showModalBottomSheet(
                    isDismissible: false,
                    enableDrag: false,
                    context: context,
                    builder: (_) {
                      return getBottomSheetUI();
                    });*/
                },
                child: Icon(Icons.add),
              );
            } else {
              return Container();
            }
          }

          return Container();
        },
      ),
    );
  }

/*void getMyNotes() async {
    allNotes = await dbHelper.getAllNotes();
    setState(() {});
  }*/

/*Widget getBottomSheetUI({bool isUpdate = false, int id = 0}){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(11),
      child: Column(
        children: [
          Text(
            isUpdate ? 'Update Note' : 'Add Note',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 21,
          ),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Enter title here..",
              label: Text('Title'),
              enabledBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(11)),
              focusedBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(11)),
            ),
          ),
          SizedBox(
            height: 11,
          ),
          TextField(
            controller: descController,
            minLines: 2,
            maxLines: 3,
            decoration: InputDecoration(
              label: Text('Description'),
              hintText: "Enter desc here..",
              enabledBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(11)),
              focusedBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(11)),
            ),
          ),
          SizedBox(
            height: 11,
          ),
          Row(
            children: [
              Expanded(
                  child: OutlinedButton(
                      onPressed: () async {
                        if (titleController.text.isNotEmpty &&
                            descController.text.isNotEmpty) {

                          bool check = false;

                          if(isUpdate){
                            check = await dbHelper.updateNote(
                                updatedTitle:
                                titleController.text,
                                updatedDesc: descController.text,
                                updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                id: id);

                          } else {
                            check = await dbHelper.addNote(
                                title: titleController.text,
                                desc: descController.text,
                                createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                            );

                          }

                          if (check) {
                            getMyNotes();
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Text(isUpdate ? 'Update' : 'Add'))),
              SizedBox(
                width: 11,
              ),
              Expanded(
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'))),
            ],
          ),
        ],
      ),
    );
  }*/
}
