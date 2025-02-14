class RegistrationModel {
  dynamic massage, token;

  RegistrationModel({
    required this.massage,
    required this.token,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> Registration) {
    return RegistrationModel(
      massage: Registration['massage'],
      token: Registration['token'],
    );
  }

  RegistrationModel fromJson(Map<String, dynamic> json) {
    return RegistrationModel.fromJson(json);
  }

  factory RegistrationModel.init() {
    return RegistrationModel(
      massage: '',
      token: '',
    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<RegistrationModel> data = [];
    for (var post in jsonList) {
      data.add(RegistrationModel.fromJson(post));
    }
    return data;
  }

  Map<String, dynamic> toJson() => {
        'massage': massage,
        'token': token,
      };
}
