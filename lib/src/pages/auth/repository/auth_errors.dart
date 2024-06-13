String authErrorsString(String? code) {
  switch (code) {
    case 'CREDÊNCIAIS INVALIDAS':
      return 'Email e/ou senhas invalidos';
    case 'Invalid session token':
      return 'Sua sessão expirou, realize um novo login';
    case 'DADOS INVALIDOS':
      return 'Ocorreu um erro ao cadastrar, dados invalidos tente novamente';
    default:
      return 'Um erro indefinido ocorreu';
  }
}
