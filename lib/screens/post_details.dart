import 'package:flutter/material.dart';
import 'package:rest_api/HTTPHelper.dart';
import 'package:rest_api/screens/edit_post.dart';

class PostDetails extends StatelessWidget {
  PostDetails(this.itemId, {Key? key}) : super(key: key) {
    // Pegar o id no construtor
    _futurePost = HTTPHelper().getItemById(itemId);
  }

  String itemId;
  late Future<Map> _futurePost;
  late Map post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    // Faz o redirecionamento para a página de edição, passando o Map de dados
                    MaterialPageRoute(builder: (_) => EditPost(post)));
              },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () async {
                // Faz o redirecionamento para a página de exclusão, passando id como parâmetro
                bool deleted = await HTTPHelper().deleteItem(itemId);

                if (deleted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Post excluído')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Falha na exclusão do post')));
                }
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
      body: FutureBuilder<Map>(
        future: _futurePost,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Ocorreu algum erro ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            post = snapshot.data!;

            return Column(
              children: [
                Text(
                  '${post['title']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('${post['body']}'),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
