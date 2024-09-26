import 'package:database_302/note_model.dart';

abstract class DBState{}

class DBInitialState extends DBState{}
class DBLoadingState extends DBState{}
class DBLoadedState extends DBState{
  List<NoteModel> mData;
  DBLoadedState({required this.mData});
}
class DBErrorState extends DBState{
  String errorMsg;
  DBErrorState({required this.errorMsg});
}