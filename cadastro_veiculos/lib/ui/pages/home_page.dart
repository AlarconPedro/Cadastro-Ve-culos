import 'package:cadastro_veiculos/datasources/datasources.dart';
import 'package:cadastro_veiculos/enums/botao_enum.dart';
import 'package:cadastro_veiculos/models/models.dart';
import 'package:cadastro_veiculos/ui/components/components.dart';
import 'package:cadastro_veiculos/ui/pages/pages.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _marcaHelper = MarcaHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Veículos'), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _abrirCadastroMarca();
        },
      ),
      body: FutureBuilder(
        future: _marcaHelper.getTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CirculoEspera();
            default:
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return _criarListaMarca(snapshot.data as List<Marca>);
              }
          }
        },
      ),
    );
  }

  Widget _criarListaMarca(List<Marca> listMarca) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      itemCount: listMarca.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.horizontal,
          child: _criarItemLista(listMarca[index]),
          background: Container(
            alignment: const Alignment(-1, 0),
            color: Colors.blue,
            child: const Text(
              "Editar Marca",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          secondaryBackground: Container(
            alignment: const Alignment(1, 0),
            color: Colors.red,
            child: const Text(
              "Excluir Marca",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              _marcaHelper.apagar(listMarca[index]);
            } else if (direction == DismissDirection.startToEnd) {
              _abrirCadastroMarca(marca: listMarca[index]);
            }
          },
          confirmDismiss: (DismissDirection direction) async {
            if (direction == DismissDirection.endToStart) {
              return await MensagemAlerta().show(
                  context: context,
                  titulo: 'Atenção',
                  texto: 'Deseja excluir essa marca?',
                  botoes: [
                    Botao(
                      texto: 'Sim',
                      tipo: BotaoEnum.texto,
                      clique: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                    Botao(
                      texto: 'Não',
                      clique: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ]);
            }
            return true;
          },
        );
      },
    );
  }

  Widget _criarItemLista(Marca marca) {
    return GestureDetector(
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                marca.nome,
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ModelosPage(marca)));
      },
      onLongPress: () {
        _abrirCadastroMarca(marca: marca);
      },
    );
  }

  void _abrirCadastroMarca({Marca? marca}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadMarcaPage(
                  marca: marca,
                )));

    setState(() {});
  }
}
