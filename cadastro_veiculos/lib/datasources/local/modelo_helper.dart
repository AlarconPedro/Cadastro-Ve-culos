import 'package:cadastro_veiculos/datasources/datasources.dart';
import 'package:cadastro_veiculos/models/models.dart';
import 'package:sqflite/sqflite.dart';

class ModeloHelper {
  static const createSql = '''
    CREATE TABLE IF NOT EXISTS ${Modelo.Tabela} (
      ${Modelo.campoCodigo} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Modelo.campoModelo} TEXT,
      ${Modelo.campoMarca} TEXT,
      ${Modelo.campoAno} TEXT,
      ${Modelo.campoValor} TEXT,
      FOREIGN KEY(${Modelo.campoMarca})
        REFERENCES ${Marca.Tabela}(${Marca.campoCodigo})
    )
  ''';

  Future<Modelo> inserir(Modelo modelo) async {
    Database db = await BancoDados().db;

    modelo.codigo = await db.insert(Modelo.Tabela, modelo.toMap());

    db.close();
    return modelo;
  }

  Future<int> alterar(Modelo modelo) async {
    Database db = await BancoDados().db;

    int linhasAfetadas = await db.update(Modelo.Tabela, modelo.toMap(),
        where: '${Modelo.campoCodigo} = ?', whereArgs: [modelo.codigo]);

    db.close();
    return linhasAfetadas;
  }

  Future<int> apagar(Modelo modelo) async {
    Database db = await BancoDados().db;

    int linhasAfetadas = await db.delete(Modelo.Tabela,
        where: '${Modelo.campoCodigo} = ?', whereArgs: [modelo.codigo]);

    db.close();
    return linhasAfetadas;
  }

  Future<List<Modelo>> getByMarca(int codMarca) async {
    Marca? marca = await MarcaHelper().getMarca(codMarca);

    if (marca != null) {
      Database db = await BancoDados().db;

      List listaDados = await db.query(Modelo.Tabela,
          where: '${Modelo.campoMarca} = ?',
          whereArgs: [codMarca],
          orderBy: Modelo.campoModelo);
      return listaDados.map((e) => Modelo.fromMap(e, marca)).toList();
    }

    return [];
  }
}
