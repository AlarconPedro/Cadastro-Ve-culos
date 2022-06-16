import 'package:cadastro_veiculos/datasources/datasources.dart';
import 'package:cadastro_veiculos/enums/botao_enum.dart';
import 'package:cadastro_veiculos/models/models.dart';
import 'package:cadastro_veiculos/ui/components/components.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class CadModeloPage extends StatefulWidget {
  final Marca marca;
  final Modelo? modelo;

  const CadModeloPage({required this.marca, this.modelo, Key? key})
      : super(key: key);

  @override
  State<CadModeloPage> createState() => _CadModeloPageState();
}

class _CadModeloPageState extends State<CadModeloPage> {
  final _modeloHelper = ModeloHelper();
  final _nomeController = TextEditingController();
  final _anoController = TextEditingController();
  final _valorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.modelo != null) {
      _nomeController.text = widget.modelo!.nome;
      _anoController.text = widget.modelo!.ano.toString();
      _valorController.text = widget.modelo!.valor.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Modelo'),
        centerTitle: true,
        actions: [
          Botao(icone: Icons.save, clique: _salvarModelo),
          _criarBotaoExcluir(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: _salvarModelo,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CampoTexto(controller: _nomeController, texto: 'Nome do Modelo'),
            CampoTexto(
              controller: _anoController,
              texto: 'Ano do Modelo',
              teclado: TextInputType.number,
            ),
            CampoTexto(
              controller: _valorController,
              texto: 'Valor do Modelo',
              teclado: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }

  void _salvarModelo() {
    if (_nomeController.text.isEmpty) {
      MensagemAlerta().show(
          context: context,
          titulo: 'Atenção',
          texto: 'Digite o nome do Modelo!',
          botoes: [
            Botao(
                texto: 'OK',
                tipo: BotaoEnum.texto,
                clique: () {
                  Navigator.pop(context);
                }),
          ]);
      return;
    }

    if (widget.modelo == null) {
      _modeloHelper.inserir(
        Modelo(
          nome: _nomeController.text,
          marca: widget.marca,
          ano: _anoController.text,
          valor: _valorController.text,
        ),
      );
    } else {
      _modeloHelper.alterar(
        Modelo(
          codigo: widget.modelo!.codigo,
          nome: _nomeController.text,
          marca: widget.marca,
          ano: _anoController.text,
          valor: _valorController.text,
        ),
      );
    }

    Navigator.pop(context);
  }

  Widget _criarBotaoExcluir() {
    if (widget.modelo != null) {
      return Botao(
        icone: Icons.delete,
        clique: () {
          _modeloHelper.apagar(
            Modelo(
              nome: _nomeController.text,
              marca: widget.marca,
              ano: _anoController.text,
              valor: _valorController.text,
            ),
          );
          Navigator.pop(context);
        },
      );
    }
    return Container();
  }
}
