import 'package:cadastro_veiculos/extensions/extensions.dart';

class Marca {
  static const Tabela = 'TbMarca';
  static const campoCodigo = 'codigo';
  static const campoNome = 'nome';

  int? codigo;
  String nome;

  Marca({this.codigo, required this.nome});

  factory Marca.fromMap(Map mapa) {
    return Marca(
      codigo: mapa[campoCodigo].toString().toInt(),
      nome: mapa[campoNome],
    );
  }

  Map<String, dynamic> toMap() {
    return {campoCodigo: codigo, campoNome: nome};
  }
}
