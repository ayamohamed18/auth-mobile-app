class UserModel {
  String? userName;
  int ?id;
  String? password;
  String? email;
  String? gender, image;

  UserModel(
      {this.userName,
      this.password,
      this.email,
      this.id,
   
      this.gender,
      this.image});

    

  factory UserModel.fromJson(Map<String, dynamic> json){
      return UserModel(
        userName: json['username'],
        password: json['password'],
        email: json['email'],
        id:json['id'],
        image:json['image'],
          gender: json['gender'],
       
      );
}


 Map<String, dynamic> toJson() {
  return { 'username':userName,
            'password':password,
            'email':email,
            'id' : id,
            'image' : image,
            'gender' : gender,
  };
 
 }}

