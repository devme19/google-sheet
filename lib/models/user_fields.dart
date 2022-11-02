class UserFields{
  static const String action = 'action';
  static const String id = 'id';
  static const String name = 'name';
  static const String email = 'email';

  static List<String> getFields()=>[action,id,name,email];
}
class User{
  final String? id;
  final String name;
  final String email;

  User({this.id,required this.name,required this.email});

  Map<String,dynamic> toJson()=>
      {
        UserFields.id:id,
        UserFields.name:name,
        UserFields.email:email,
      };
  static User fromJson(Map<String,dynamic> json)=> User(
    id:json[UserFields.id],
    name:json[UserFields.name],
    email:json[UserFields.email],

  );
}