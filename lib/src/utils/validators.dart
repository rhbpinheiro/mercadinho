

String? nameValidator(String? name) {
  if (name != null || name!.isEmpty) {
    return 'Digite um nome';
  }
  final names = name.split('');
  if (names.length == 1) {
    return 'Digite seu nome completo';
  }
  return null;
}
String? Validator(String? name) {
  if (name != null || name!.isEmpty) {
    return 'Digite um nome';
  }
  final names = name.split('');
  if (names.length == 1) {
    return 'Digite seu nome completo';
  }
  return null;
}
// String? phoneValidator(String? phone) {
//   if (phone == null || phone.isEmpty) {
//     return 'Digite um Celular';

//   }
//   String newPhone = phone.replaceAll(from, replace)
//   if(phone.isPhoneNumber)
//   // final names = name.split('');
//   // if (names.length == 1) {
//   //   return 'Digite seu nome completo';
//   // }
//   return null;
// }
