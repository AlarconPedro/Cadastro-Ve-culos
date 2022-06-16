import 'package:cadastro_veiculos/datasources/datasources.dart';
import 'package:cadastro_veiculos/models/models.dart';
import 'package:sqflite/sqflite.dart';

class MarcaHelper {
  static const createSql = '''
    CREATE TABLE IF NOT EXISTS ${Marca.Tabela} (
      ${Marca.campoCodigo} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Marca.campoNome} TEXT
    )
  ''';

  Future<Marca> inserir(Marca marca) async {
    Database db = await BancoDados().db;
    marca.codigo = await db.insert(Marca.Tabela, marca.toMap());

    db.close();
    return marca;
  }

  Future<int> alterar(Marca marca) async {
    Database db = await BancoDados().db;

    int retorno = await db.update(Marca.Tabela, marca.toMap(),
        where: '${Marca.campoCodigo} = ?', whereArgs: [marca.codigo]);

    db.close();
    return retorno;
  }

  Future<int> apagar(Marca marca) async {
    Database db = await BancoDados().db;

    int retorno = await db.delete(Marca.Tabela,
        where: '${Marca.campoCodigo} = ?', whereArgs: [marca.codigo]);
    db.close();

    return retorno;
  }

  Future<List<Marca>> getTodos() async {
    Database db = await BancoDados().db;

    List listaDados = await db.query(Marca.Tabela);

    return listaDados.map((e) => Marca.fromMap(e)).toList();
  }

  Future<Marca?> getMarca(int codigo) async {
    Database db = await BancoDados().db;

    List listaDados = await db.query(Marca.Tabela,
        columns: [Marca.campoCodigo, Marca.campoNome],
        where: '${Marca.campoCodigo} = ?',
        whereArgs: [codigo]);

    if (listaDados.isNotEmpty) {
      return Marca.fromMap(listaDados.first);
    }

    return null;
  }

  Future<int> getTotal() async {
    Database db = await BancoDados().db;

    return Sqflite.firstIntValue(
            await db.rawQuery("SELECT COUNT(*) FROM ${Marca.Tabela}")) ??
        0;
  }
}
