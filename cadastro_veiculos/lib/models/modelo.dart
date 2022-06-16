import 'dart:ffi';

import 'package:cadastro_veiculos/extensions/extensions.dart';
import 'package:cadastro_veiculos/models/models.dart';

class Modelo {
  static const Tabela = 'TbModelo';
  static const campoCodigo = 'codigo';
  static const campoModelo = 'modelo';
  static const campoMarca = 'marca';
  static const campoAno = 'ano';
  static const campoValor = 'valor';

  int? codigo;
  String nome;
  String ano;
  String valor;
  Marca marca;

  Modelo({
    this.codigo,
    required this.nome,
    required this.marca,
    required this.ano,
    required this.valor,
  });

  factory Modelo.fromMap(Map map, Marca marca) {
    return Modelo(
      codigo: map[campoCodigo].toString().toInt(),
      nome: map[campoModelo],
      marca: marca,
      ano: map[campoAno],
      valor: map[campoValor],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      campoCodigo: codigo,
      campoModelo: nome,
      campoMarca: marca.codigo,
      campoAno: ano,
      campoValor: valor
    };
  }
}
