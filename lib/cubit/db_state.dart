abstract class DBState{}

class DBInitialState extends DBState{}
class DBLoadingState extends DBState{}
class DBLoadedState extends DBState{
  List<Map<String, dynamic>> mData;
  DBLoadedState({required this.mData});
}
class DBErrorState extends DBState{
  String errorMsg;
  DBErrorState({required this.errorMsg});
}