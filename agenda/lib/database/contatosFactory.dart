import 'package:agenda/database/database.dart';
import 'package:agenda/models/contato.dart';
import 'package:sqflite/sqflite.dart';

class ContatoFactory {
  Database _database;
  final String _tableContatos = "contato";

  Future<int> salvar(Contato contato) async {
    _database = await createDatabase();
    return _database.insert(_tableContatos, contato.getMap());
  }

  Future<List<Contato>> ler() async {
    _database = await createDatabase();
    List<Contato> listaDeContatos = new List();
    List<Map<String, dynamic>> mapContatos =
        await _database.query(_tableContatos);

    for (Map<String, dynamic> map in mapContatos) {
      Contato contato = new Contato(
        map['nome'],
        map['telefone'],
      );
      contato.setId(map['id']);
      listaDeContatos.add(contato);
    }
    return listaDeContatos;
  }

  Future<int> deletar(int id) async {
    _database = await createDatabase();

    return _database.delete(_tableContatos, where: "id = ?", whereArgs: [id]);
  }
}
