import 'package:cadastro_veiculos/datasources/datasources.dart';
import 'package:cadastro_veiculos/models/models.dart';
import 'package:cadastro_veiculos/ui/components/components.dart';
import 'package:cadastro_veiculos/ui/pages/pages.dart';
import 'package:flutter/material.dart';

class ModelosPage extends StatefulWidget {
  final Marca marca;

  const ModelosPage(this.marca, {Key? key}) : super(key: key);

  @override
  State<ModelosPage> createState() => _ModelosPageState();
}

class _ModelosPageState extends State<ModelosPage> {
  final _modeloHelper = ModeloHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.marca.nome),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _abrirCadastroModelo,
      ),
      body: FutureBuilder(
        future: _modeloHelper.getByMarca(widget.marca.codigo ?? 0),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const CirculoEspera();
            default:
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return _criarListagem(snapshot.data as List<Modelo>);
          }
        },
      ),
    );
  }

  Widget _criarListagem(List<Modelo> listaDados) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: listaDados.length,
        itemBuilder: (context, index) {
          return _criarItemLista(listaDados[index]);
        });
  }

  Widget _criarItemLista(Modelo modelo) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Text(modelo.nome),
            ],
          ),
        ),
      ),
      onTap: () {
        _abrirCadastroModelo(modelo: modelo);
      },
    );
  }

  void _abrirCadastroModelo({Modelo? modelo}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadModeloPage(
          marca: widget.marca,
          modelo: modelo,
        ),
      ),
    );

    setState(() {});
  }
}
