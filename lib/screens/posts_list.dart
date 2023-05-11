import 'package:flutter/material.dart';
import 'package:rest_api/HTTPHelper.dart';
import 'post_details.dart';

class PostsList extends StatelessWidget {
  PostsList({Key? key}) : super(key: key);

  // Faz a instância da classe para pegar os dados da API
  Future<List<Map>> _futurePosts = HTTPHelper().getAllItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Posts"),
        ),
        body: FutureBuilder<List<Map>>(
          future: _futurePosts,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // Verificar os erros
            if (snapshot.hasError) {
              return Center(
                  child: Text("Ocorreu algum erro ${snapshot.error}"));
            }

            // Verificar se algum dado chegou
            if (snapshot.hasData) {
              List<Map> posts = snapshot.data;

              return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    Map thisItem = posts[index];
                    // Preenche a lista com os dados vindo da API
                    return ListTile(
                      title: Text('${thisItem['title']}'),
                      subtitle: Text('${thisItem['body']}'),
                      // Propriedade para tocar e exibir os detalhes dos dados
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                PostDetails(thisItem['id'].toString())));
                      },
                    );
                  });
            }

            // Apresentar o loader
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
