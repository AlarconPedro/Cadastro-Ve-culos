import 'package:cadastro_veiculos/enums/botao_enum.dart';
import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final String texto;
  final BotaoEnum tipo;
  final VoidCallback clique;
  final IconData? icone;

  const Botao(
      {this.texto = '',
      this.tipo = BotaoEnum.quadrado,
      required this.clique,
      this.icone,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (tipo) {
      case BotaoEnum.quadrado:
        return _criarBotaoQuadrado();
      case BotaoEnum.texto:
        return _criarBotaoTexto();
      default:
        return Container();
    }
  }

  Widget _criarBotaoTexto() {
    return TextButton(child: _criarItemBotao(), onPressed: clique);
  }

  Widget _criarBotaoQuadrado() {
    return ElevatedButton(child: _criarItemBotao(), onPressed: clique);
  }

  Widget _criarItemBotao() {
    return icone != null ? Icon(icone) : Text(texto);
  }
}
