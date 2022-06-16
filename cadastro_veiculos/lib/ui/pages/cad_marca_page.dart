import 'package:cadastro_veiculos/datasources/datasources.dart';
import 'package:cadastro_veiculos/enums/botao_enum.dart';
import 'package:cadastro_veiculos/models/models.dart';
import 'package:cadastro_veiculos/ui/components/components.dart';
import 'package:flutter/material.dart';

class CadMarcaPage extends StatefulWidget {
  final Marca? marca;

  const CadMarcaPage({this.marca, Key? key}) : super(key: key);

  @override
  State<CadMarcaPage> createState() => _CadMarcaPageState();
}

class _CadMarcaPageState extends State<CadMarcaPage> {
  final _marcaHelper = MarcaHelper();
  final _nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.marca != null) {
      _nomeController.text = widget.marca!.nome;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro Marca'), centerTitle: true),
      body: ListView(
        children: [
          CampoTexto(controller: _nomeController, texto: 'Nome da Marca'),
          Botao(texto: 'Salvar', clique: _salvarMarca),
          _criarBotaoExcluir(),
        ],
      ),
    );
  }

  Widget _criarBotaoExcluir() {
    if (widget.marca != null) {
      return Botao(
        texto: 'Excluir',
        clique: _excluirMarca,
      );
    }
    return Container();
  }

  void _excluirMarca() {
    MensagemAlerta().show(
        context: context,
        titulo: 'Atenção',
        texto: 'Deseja realmente excluir essa Marca?',
        botoes: [
          Botao(texto: 'Sim', tipo: BotaoEnum.texto, clique: _confirmaExclusao),
          Botao(
              texto: 'Não',
              clique: () {
                Navigator.pop(context);
              }),
        ]);
  }

  void _confirmaExclusao() {
    if (widget.marca != null) {
      _marcaHelper.apagar(widget.marca!);
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void _salvarMarca() {
    if (_nomeController.text.trim().isEmpty) {
      MensagemAlerta().show(
          context: context,
          titulo: 'Atenção',
          texto: 'Digite o nome da Marca!',
          botoes: [
            Botao(
                texto: 'OK',
                tipo: BotaoEnum.texto,
                clique: () {
                  Navigator.pop(context);
                })
          ]);

      return;
    }

    if (widget.marca == null) {
      _marcaHelper.inserir(
        Marca(
          nome: _nomeController.text,
        ),
      );
    } else {
      _marcaHelper.alterar(
        Marca(
          codigo: widget.marca!.codigo,
          nome: _nomeController.text,
        ),
      );
    }

    Navigator.pop(context);
  }
}
