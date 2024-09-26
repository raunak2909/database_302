abstract class DBEvent{}

class GetInitialNotesEvent extends DBEvent{}

class AddNoteEvent extends DBEvent{
  String title, desc, created_at;
  AddNoteEvent({required this.title, required this.desc, required this.created_at});
}
class UpdateNoteEvent extends DBEvent{
  String updTitle, updDesc, updCreated_at;
  int id;
  UpdateNoteEvent({required this.id, required this.updCreated_at, required this.updTitle, required this.updDesc});
}
class DeleteNoteEvent extends DBEvent{
  int id;
  DeleteNoteEvent({required this.id});
}
