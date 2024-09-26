import 'package:database_302/note_model.dart';

abstract class DBMainState{}

class DBMainInitialState extends DBMainState{}
class DBMainLoadingState extends DBMainState{}
class DBMainLoadedState extends DBMainState{
  List<NoteModel> mData;
  DBMainLoadedState({required this.mData});
}
class DBMainErrorState extends DBMainState{
  String errorMsg;
  DBMainErrorState({required this.errorMsg});
}