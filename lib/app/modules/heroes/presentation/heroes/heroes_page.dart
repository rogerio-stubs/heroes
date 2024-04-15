import 'package:code_hero/app/modules/heroes/presentation/heroes/heroes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

class HeroesPage extends StatefulWidget {
  const HeroesPage({Key? key}) : super(key: key);

  @override
  State<HeroesPage> createState() => _HeroesPageState();
}

class _HeroesPageState extends State<HeroesPage> {
  final controller = Modular.get<HeroesController>();

  void initState() {
    super.initState();
    final initial = controller.getHeroes("");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BUSCA MARVEL TESTE FRONT-END',
                    style: TextStyle(color: Colors.red),
                  ),
                  Container(
                    height: 2,
                    width: 45,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Nome do Personagem',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 12, left: 30, right: 30),
              child: TextFormField(
                controller: controller.searchController,
                decoration: const InputDecoration(
                  labelText: 'Pesquisar',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                ),
                onTap: () async {
                  await controller.getHeroes(controller.searchController.text);
                },
              ),
            ),
            Container(
              color: Colors.red,
              height: 30,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Nome',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: controller.getHeroes(""),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else {
                    var heroes = snapshot.data;
                    return ListView.builder(
                      itemCount: heroes!.length >= 4 ? 4 : heroes.length,
                      itemBuilder: (_, index) {
                        return Consumer<HeroesController>(builder: (context, value, child){
                        var model = controller.heroes[index];
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              child: Row(
                                children: [
                                  Container(
                                    height: 70,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 18),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        model.image,
                                        fit: BoxFit.cover,
                                        scale: 100,
                                      ),
                                    ),
                                  ),
                                  Text(model.name)
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  color: Colors.red,
                                  width: MediaQuery.of(context).size.width,
                                  height: 2,
                                ),
                              ],
                            )
                          ],
                        );
                        },
                        );
                      },
                    );
                  }
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<HeroesController>(
                builder: (context, controller, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.setPagination(0);
                        },
                        child: Icon(Icons.arrow_left),
                      ),
                      Container(
                        height: 30, // Altura fixa para o ListView
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.pagination.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                controller.setPagination(index);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: controller.pagination[index]
                                        ? Colors.red
                                        : Colors.white,
                                    border:
                                        Border.all(color: Colors.red, width: 2),
                                  ),
                                  child: Center(
                                    child: Text((index + 1).toString()),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.setPagination(1);
                        },
                        child: Icon(Icons.arrow_right),
                      ),
                    ],
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 30, // Altura fixa para o ListView
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.pagination.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.pagination[index]
                                      ? Colors.red
                                      : Colors.white,
                                  border:
                                      Border.all(color: Colors.red, width: 2),
                                ),
                                child: Center(
                                  child: Text((index + 1).toString()),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
