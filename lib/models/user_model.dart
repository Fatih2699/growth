
class UserData{
  String ?name;
  String ?email;
  String ?token;


  UserData(String token,String email, String name){
    this.name= name;
    this.email=email;
    this.token=token;

  }

  UserData.fromJson(Map json)
    :name=json['name'],
    email=json['email'],
    token=json['token'];

    Map toJson(){
      return {
        'name' : name,
        'email' : email,
        'token' : token,
      };
    }
}