import 'package:cadastro_veiculos/datasources/datasources.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BancoDados {
  static final BancoDados _instance = BancoDados._internal();
  factory BancoDados() => _instance;
  BancoDados._internal();

  Database? _db;
  Future<Database> get db async {
    _db = await _iniciarDb();
    return _db!;
  }

  Future<Database> _iniciarDb() async {
    const nomeBanco = "meus_veiculos.db";
    final path = await getDatabasesPath();
    final caminhoBanco = join(path, nomeBanco);

    return await openDatabase(caminhoBanco, version: 1,
        onCreate: (Database db, int newVersion) async {
      await db.execute(MarcaHelper.createSql);
      await db.execute(ModeloHelper.createSql);
    });
  }

  void close() async {
    _db?.close();
  }
}
