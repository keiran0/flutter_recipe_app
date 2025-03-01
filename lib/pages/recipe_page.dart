import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipePage extends StatelessWidget{

  final Recipe recipe;

  RecipePage({
    required this.recipe
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, //to show the image behind the app bar
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white60,
        title: const Text("Recipe Book"),
      ),
      body: _buildUI(context)
    );
  }

  Widget _buildUI(BuildContext context){
    return SingleChildScrollView(
      child: Column(children: [
        _recipeImage(context),
        _recipeDetails(context),
        _recipeIngredients(context),
        _recipeInstructions(context)
      ]),
    );
  }

  Widget _recipeImage(BuildContext context){
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.4,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        image: DecorationImage( 
          //Boxdecoration expects an image with the type decoration image,
          //so we wrap the image in a decoration image first.
          image: NetworkImage(recipe.image), //network image because your image is over a network
          //if your image is an asset then use AssetImage. 
          fit: BoxFit.cover,
        )
      )
    );
  }

  Widget _recipeDetails(BuildContext context) {
    return Container(
      color: Colors.white, 
      width: MediaQuery.sizeOf(context).width, 
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 20.0
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${recipe.cuisine}, ${recipe.difficulty}", 
            style: TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.w300
            )
          ),
          Text(
            recipe.name,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            )
          ),
          Text("Prep time: ${recipe.prepTimeMinutes} | Cook Time: ${recipe.cookTimeMinutes} minutes", 
            style: TextStyle(
              fontSize: 15, 
              fontWeight: FontWeight.w300
            )
          ),
          Text("${recipe.rating.toString()} ⭐ |  ${recipe.reviewCount} reviews", 
            style: TextStyle(
              fontSize: 15, 
              fontWeight: FontWeight.w500
            )
          ),
        ],
      )
    );
  }

  Widget _recipeIngredients(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 20.0
      ),
      child: Column(children:
        recipe.ingredients.map((i){return Row(children:[
          const Icon(Icons.check_box),
          Text(i)
        ]);}).toList()
      )
    );
  }

  Widget _recipeInstructions(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 20.0
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: recipe.instructions.map((i){
          return Text(
            i, 
            maxLines: 3, 
            textAlign: TextAlign.start, 
            style: const TextStyle(fontSize: 15.0)
          );
        }).toList()
      )
      
    );
  }

}