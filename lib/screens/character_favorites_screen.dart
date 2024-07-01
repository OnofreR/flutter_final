import 'package:flutter/material.dart';
import 'package:rick_morty_app/dao/character_dao.dart';
import 'package:rick_morty_app/models/character.dart';

class CharacterFavoritesScreen extends StatefulWidget {
  const CharacterFavoritesScreen({super.key});

  @override
  State<CharacterFavoritesScreen> createState() =>
      _CharacterFavoritesScreenState();
}

class _CharacterFavoritesScreenState extends State<CharacterFavoritesScreen> {
  List _favoriteCharacters = [];

  initilize() async {
    _favoriteCharacters = await CharacterDao().fetchAll();
    if (mounted) {
      setState(() {
        _favoriteCharacters = _favoriteCharacters;
      });
    }
  }

  @override
  void initState() {
    initilize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _favoriteCharacters.length,
          itemBuilder: (context, index) => CharacterFavoriteItem(
              favoriteCharacter: _favoriteCharacters[index],
              onReload: initilize)),
    );
  }
}

class CharacterFavoriteItem extends StatefulWidget {
  const CharacterFavoriteItem(
      {super.key, required this.favoriteCharacter, required this.onReload});
  final FavoriteCharacter favoriteCharacter;
  final VoidCallback onReload;

  @override
  State<CharacterFavoriteItem> createState() => _CharacterFavoriteItemState();
}

class _CharacterFavoriteItemState extends State<CharacterFavoriteItem> {
  final CharacterDao _characterDao = CharacterDao();

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(widget.favoriteCharacter.name),
      subtitle: Text(widget.favoriteCharacter.status),
      leading: Hero(
        tag: widget.favoriteCharacter.id,
        child: Image.network(widget.favoriteCharacter.image),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          _characterDao.deleteById(widget.favoriteCharacter.id);
          widget.onReload();
        },
      ),
    ));
  }
}
