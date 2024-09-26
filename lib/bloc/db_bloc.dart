import 'package:database_302/bloc/db_event.dart';
import 'package:database_302/bloc/db_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../db_helper.dart';
import '../note_model.dart';

class DBBloc extends Bloc<DBEvent, DBMainState> {
  DBHelper dbHelper;

  DBBloc({required this.dbHelper}) : super(DBMainInitialState()) {
    on<AddNoteEvent>((event, emit) async {
      emit(DBMainLoadingState());
      bool check = await dbHelper.addNote(
          NoteModel(title: event.title, desc: event.desc, created_at: event.created_at));
      if (check) {
        var allNotes = await dbHelper.getAllNotes();
        emit(DBMainLoadedState(mData: allNotes));
      } else {
        emit(DBMainErrorState(errorMsg: "Note not added"));
      }
    });

    on<GetInitialNotesEvent>((event, emit) async {
      emit(DBMainLoadingState());
      var allNotes = await dbHelper.getAllNotes();
      emit(DBMainLoadedState(mData: allNotes));
    });

    /// update
    on<UpdateNoteEvent>((event, emit) async{
      emit(DBMainLoadingState());
      bool check = await dbHelper.updateNote(
          updatedTitle: event.updTitle,
          updatedDesc: event.updDesc,
          updatedAt: event.updCreated_at,
          id: event.id);

      if (check) {
        var allNotes = await dbHelper.getAllNotes();
        emit(DBMainLoadedState(mData: allNotes));
      } else {
        emit(DBMainErrorState(errorMsg: "Note not updated"));
      }

    });

    /// delete
  }
}
