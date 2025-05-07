using Godot;
using System;

public partial class MainGame : Node2D
{
	// Called when the node enters the scene tree for the first time.
	void _on_enemy_end_game(){
		GetTree().ChangeSceneToFile("res://scenes/game_over.tscn");
		GD.Print("hello world");
	}
}
