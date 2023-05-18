import 'package:flutter/material.dart';
import 'package:rest_api/HTTPHelper.dart';

class EditPost extends StatefulWidget {
  // Permitirá pegar formulário já preenchido no modo de edição, pela variável this.post
  EditPost(this.post, {Key? key}) : super(key: key);
  Map post;

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  // Cria os controladores que serão usados nos formulários
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerBody = TextEditingController();

  // Define o estado inicial da tela com os dados do formulário preenchido
  initState() {
    super.initState();
    _controllerTitle.text = widget.post['title'];
    _controllerBody.text = widget.post['body'];
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              // Campo de texto do título
              TextFormField(
                controller: _controllerTitle,
              ),
              // Campo de texto do corpo do texto
              TextFormField(
                controller: _controllerBody,
                maxLines: 5,
              ),
              // botão para enviar os dados, o tipo Map é chave e valor de duas strings
              // a serem enviadas
              ElevatedButton(
                  onPressed: () async {
                    Map<String, String> dataToUpdate = {
                      'title': _controllerTitle.text,
                      'body': _controllerBody.text,
                    };

                    bool status = await HTTPHelper()
                        .updateItem(dataToUpdate, widget.post['id'].toString());

                    // Verificação da atualização dos dados
                    if (status) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Post atualizado')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Falha na atualização do post')));
                    }
                  },
                  child: Text('Atualizar'))
            ],
          ),
        ),
      ),
    );
  }
}
