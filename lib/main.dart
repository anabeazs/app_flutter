import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Pets',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => PetCrudPage(),
      },
    );
  }
}

class Pet {
  String nome;
  String raca;
  String porte;
  String emailDono;

  Pet({this.nome = '', this.raca = '', this.porte = '', this.emailDono = ''});
}

class PetCrudPage extends StatefulWidget {
  @override
  _PetCrudPageState createState() => _PetCrudPageState();
}

class _PetCrudPageState extends State<PetCrudPage> {
  List<Pet> pets = [];
  TextEditingController _nomeEditingController = TextEditingController();
  TextEditingController _racaEditingController = TextEditingController();
  TextEditingController _porteEditingController = TextEditingController();
  TextEditingController _emailDonoEditingController = TextEditingController();
  bool isEditing = false;
  int editingIndex = 0;

  @override
  void dispose() {
    _nomeEditingController.dispose();
    _racaEditingController.dispose();
    _porteEditingController.dispose();
    _emailDonoEditingController.dispose();
    super.dispose();
  }

  void addPet() {
    setState(() {
      Pet newPet = Pet(
        nome: _nomeEditingController.text,
        raca: _racaEditingController.text,
        porte: _porteEditingController.text,
        emailDono: _emailDonoEditingController.text,
      );
      pets.add(newPet);
      _nomeEditingController.clear();
      _racaEditingController.clear();
      _porteEditingController.clear();
      _emailDonoEditingController.clear();
    });
  }

  void updatePet() {
    setState(() {
      pets[editingIndex].nome = _nomeEditingController.text;
      pets[editingIndex].raca = _racaEditingController.text;
      pets[editingIndex].porte = _porteEditingController.text;
      pets[editingIndex].emailDono = _emailDonoEditingController.text;
      _nomeEditingController.clear();
      _racaEditingController.clear();
      _porteEditingController.clear();
      _emailDonoEditingController.clear();
      isEditing = false;
    });
  }

  void deletePet(int index) {
    setState(() {
      pets.removeAt(index);
    });
  }

  void editPet(int index) {
    setState(() {
      _nomeEditingController.text = pets[index].nome;
      _racaEditingController.text = pets[index].raca;
      _porteEditingController.text = pets[index].porte;
      _emailDonoEditingController.text = pets[index].emailDono;
      isEditing = true;
      editingIndex = index;
    });
  }

  void clearPetList() {
    setState(() {
      pets.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.network(
              'https://i.pinimg.com/originals/a8/e4/5b/a8e45bd6ff58df6e8358d3ae3ae00c4f.png', // caminho da imagem
              height: 40, // altura da imagem
            ),
            SizedBox(width: 8), // espaçamento entre a imagem e o texto
            Text('Cadastro de Pets'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xfff9f987),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Color(0xfff69898),
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Apagar Lista de Pets'),
              onTap: clearPetList,
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nomeEditingController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                  ),
                ),
                TextField(
                  controller: _racaEditingController,
                  decoration: InputDecoration(
                    labelText: 'Raça',
                  ),
                ),
                TextField(
                  controller: _porteEditingController, // corrigido
                  decoration: InputDecoration(
                    labelText: 'Porte',
                  ),
                ),
                TextField(
                  controller: _emailDonoEditingController, // corrigido
                  decoration: InputDecoration(
                    labelText: 'Email para contato',
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            child: Text(isEditing ? 'Atualizar' : 'Cadastrar'),
            onPressed: isEditing ? updatePet : addPet,
          ),
          ElevatedButton(
            child: Text('Ver Lista'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PetListPage(pets: pets),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PetListPage extends StatelessWidget {
  final List<Pet> pets;

  PetListPage({required this.pets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pets'),
      ),
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pets[index].nome),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Raça: ${pets[index].raca}'),
                Text('Porte: ${pets[index].porte}'),
                Text('Email de Contato: ${pets[index].emailDono}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
