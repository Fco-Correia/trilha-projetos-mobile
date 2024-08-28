class Usuario {
  String? _idUsuario;
  String? _name;
  String? _email;
  String? _senha;
  String? _urlImagem;

  Usuario();

  String? get idUsuario => _idUsuario;
  set idUsuario(String? value) {
    _idUsuario = value;
  }

  String? get name => _name;
  set name(String? value) {
    _name = value;
  }

  String? get email => _email;
  set email(String? value) {
    _email = value;
  }

  String? get senha => _senha;
  set senha(String? value) {
    _senha = value;
  }

  String? get urlImagem => _urlImagem;
  set urlImagem(String? value) {
    _urlImagem = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "nome": this.name,
      "email": this.email,
    };
    return map;
  }
}
