import 'dart:convert';
import 'package:http/http.dart' as http;

class HTTPHelper {
// Consultar todos os itens
  Future<List<Map>> getAllItems() async {
    List<Map> items = [];

    // Pegar os dados da API
    http.Response response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    // Se o código for 200, ocorreu tudo certo com a consulta na API
    if (response.statusCode == 200) {
      // Pega os dados da resposta da API em formato JSON
      String jsonString = response.body;
      // Converte para List<Map>
      List data = jsonDecode(jsonString);
      items = data.cast<Map>();
    }

    return items;
  }

// Consultar detalhes de um item
  Future<Map> getItemById(itemId) async {
    Map item = {};

    // Pegar os dados da API
    http.Response response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/posts/$itemId"));

    // Se o código for 200, ocorreu tudo certo com a consulta na API
    if (response.statusCode == 200) {
      // Pega os dados da resposta da API em formato JSON
      String jsonString = response.body;
      // Converte para List<Map>
      item = jsonDecode(jsonString);
    }

    return item;
  }

// Adicionar um item
  Future<bool> addItem(Map dados) async {
    bool status = false;

    // Cadastrar os dados na API
    http.Response response = await http.post(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        body: jsonEncode(dados),
        headers: {'Content-Type': 'application/json'});

    // Se o código for 200, ocorreu tudo certo com a consulta na API
    // Trocar para 201 para retornar sem erro
    if (response.statusCode == 200) {
      // Retorna TRUE
      status = response.body.isNotEmpty;
    }

    return status;
  }

// Atualizar um item
  Future<bool> updateItem(Map dados, String itemId) async {
    bool status = false;

    // Atualizar os dados na API
    http.Response response = await http.put(
        Uri.parse("https://jsonplaceholder.typicode.com/posts/$itemId"),
        body: jsonEncode(dados),
        headers: {'Content-Type': 'application/json'});

    // Se o código for 200, ocorreu tudo certo com a consulta na API
    if (response.statusCode == 200) {
      // Retorna TRUE
      status = response.body.isNotEmpty;
    }

    return status;
  }

// Excluir um item
  Future<bool> deleteItem(String itemId) async {
    bool status = false;

    // Excluir os dados na API
    http.Response response = await http.delete(
        Uri.parse("https://jsonplaceholder.typicode.com/posts/$itemId"));

    // Se o código for 200, ocorreu tudo certo com a consulta na API
    if (response.statusCode == 200) {
      // Retorna TRUE
      status = true;
    }

    return status;
  }
}
