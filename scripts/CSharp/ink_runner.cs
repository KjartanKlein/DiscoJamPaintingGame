using System.Runtime.Serialization;
using Godot;
using GodotInk;
using Ink;
//using Ink.Parsed;



public partial class ink_runner : CanvasLayer
{
    [Export]
    public InkStory story;
    [Export] public Theme buttonTheme;
    public RichTextLabel dialog, char_name;
    public HBoxContainer button_container;
    public bool is_animating_text = false;
    [Export]    public float letters_per_second = 100.0f;
    [Export]    public bool loud = false;
    [Signal]    public delegate void AnimationChangedEventHandler(string charName, string animationName);
    [Signal]    public delegate void FlipXEventHandler(string charName);
    [Signal]    public delegate void FlipYEventHandler(string charName);
    [Signal]    public delegate void ChangeLocationEventHandler(string charName,int x, int y);
    [Signal]    public delegate void ChangeBackroundEventHandler(string backroundName); 
    [Signal]    public delegate void SetCharVisibleEventHandler(string charName,bool visibility);
    [Signal]    public delegate void AnimationChangedSingleEventHandler(string charName,string animaition,string fallback);
    [Signal]    public delegate void DialogFinishedEventHandler();
    private bool button_choice = false;
    public bool is_active = false;
    public override void _Ready()
    {    
        
        dialog = GetNode<RichTextLabel>("text_box/dialog");
        //ContinueStory();
        char_name = GetNode<RichTextLabel>("name_box/name");
        button_container = GetNode<HBoxContainer>("button_container");

        //test_dialog();
        //getNext();
    }

    private double grace_period = 0.5; 
    public override void _Input(InputEvent @event)
    {
        if (@event.IsActionPressed("interact",false) && grace_period == 0.0)
        {
            if(!button_choice && is_active)
                getNext();
        }
    }
    public override void _Process(double delta)
    {
        if (is_animating_text){
            dialog.VisibleCharacters  = (int)( letters_per_second * (float)delta + dialog.VisibleCharacters);
            if (dialog.VisibleRatio >= 1.0f){
                is_animating_text = false;
            }
        }
        if (grace_period > 0){
            grace_period -=delta;
            if (grace_period <0){
                grace_period = 0.0;
            }
        }
    }
    
    public bool IsActive(){
        return is_active;
    }
    public void setActive(bool to_set){
        is_active=to_set;
    }
    private void stop_animation(){
        dialog.VisibleRatio = 1.0f;
        is_animating_text = false;
        return;
    }
    private void start_animation(){
        is_animating_text = true;
        dialog.VisibleRatio = 0.0f;
        return;

    }

    private void free_buttons(){
        foreach (Node child in button_container.GetChildren()){
            child.QueueFree();
            button_choice =false;
        }
        return;
    }

    private void create_button(string input_text, int index){
        Button button = new() { Text = input_text, Theme = buttonTheme};
        Vector2 min_size;
        min_size.X = 250;
        min_size.Y = 50; 
        button.CustomMinimumSize = min_size;
        button.SizeFlagsHorizontal = Control.SizeFlags.ExpandFill;
        button.Pressed += delegate
            {
                button_function(index);
            };
            button_container.AddChild(button);
    }
    private void button_function(int index){
        if (!is_animating_text){
            story.ChooseChoiceIndex(index);
            getNext();
        }else{
            stop_animation();
        }
    }

    private void handle_tags(){
        foreach(string tag in story.CurrentTags ){
            foreach(string requested_changes in tag.Split(",")){
                string changes = requested_changes.Trim(' ');
                string[] command_pair = changes.Split(":");
                if(loud)                                            GD.Print("command pair is ", command_pair[0]," : ", command_pair[1]);
                string command = command_pair[0].ToLower().Trim();

                switch (command){
                    default:
                        GD.Print("UNKOWN COMMAND IN TAG, #",tag,"   , split to ->",command);
                        break;
                    case "changebackround": //should be used changeBackround:backroundName
                        if(loud)                                    GD.Print("changing the backroudn to ", command_pair[1]);
                        EmitSignal(SignalName.ChangeBackround, command_pair[1]);
                        break;
                    case "changename": //changes name box should be used changeName:name
                        if (loud)                                   GD.Print("changing the name to ", command_pair[1]);
                        char_name.Text = command_pair[1];
                        break;
                    case "changesprite": // unsure of usage
                        if(loud)                                    GD.Print("trying to change sprite");
                        break;
                    case "changeanimation":// should be used as changeAnimation:name:animationName
                        if (loud)                                   GD.Print("Emitting singal with ", char_name.Text," : ", command_pair[1]);
                        EmitSignal(SignalName.AnimationChanged,command_pair[1],command_pair[2]);
                        break;
                    case "changeanimationsingle": //ChangeAnimationSingle:Name:Animation:Fallback
                        if (loud)                                   GD.Print("trying to do complex animation sequence");
                        EmitSignal(SignalName.AnimationChangedSingle,command_pair[1],command_pair[2],command_pair[3]);
                        break;
                    case "changelocation":// should be used as changeLocation:name:x:y
                        if(loud)    GD.Print("Changing location, to", command_pair[1], "->", command_pair[1], ":", command_pair[2]);
                        EmitSignal(SignalName.ChangeLocation,command_pair[1],command_pair[2],command_pair[3]);
                        break;
                    case "flipx":// Should be used as FlipX:name
                        EmitSignal(SignalName.FlipX,command_pair[1]);
                        break;
                    case "flipy": // Should be used as FlipY:name
                        EmitSignal(SignalName.FlipY,command_pair[1]);
                        break;
                    case "setvisible":// setVisible:name:bool
                        bool is_visible = false;
                        if (command_pair[2] == "true") is_visible = true;
                        EmitSignal(SignalName.SetCharVisible,command_pair[1],is_visible);
                        break;
                    case "boxvisible": // setBoxVisible:bool
                        if (command_pair[1] == "true"){
                            Visible=true;
                            GD.Print("Enbling the box");
                        }else if (command_pair[1] == "false"){
                            GD.Print("disabling the box");
                            Visible=false;
                        }
                        break;
                    case "close":
                        GD.Print("closeign story");
                        EmitSignal(SignalName.DialogFinished);
                        break;
                    }//switch
                }// req changes
            } //tags
    }
    public void getNext(){
        // We have not finished animating
        grace_period = 0.5;
        if (is_animating_text){
            stop_animation();
            return;
        }
        start_animation();
        free_buttons();
        if(!story.CanContinue){
            GD.Print("out of stories :(");
            EmitSignal(SignalName.DialogFinished);
            return;
        }
        dialog.Text = story.Continue();
        if(dialog.Text == ""){
            GD.Print("GotNothing");
        }
        int  i = 0;
        foreach(InkChoice choice in story.CurrentChoices){
            create_button(choice.Text, choice.Index);
            i++;
        }
        if (i != 0) button_choice = true;

        handle_tags();
    }
    public bool getItem(string item_name){
        bool status = story.FetchVariable<bool>(item_name);
        GD.Print(item_name," got ", status );
        return status;
    }

    public void addItem(string item_name){
        GD.Print("adding item", item_name);
        switch (item_name){
        case "tissues":
                GD.Print("tissues ", item_name);
                story.StoreVariable("item_tissues", true);
            break;
        case "crybox":
                GD.Print("crybox " , item_name);
                story.StoreVariable("item_crybox", true);
            break;
        case "coffee":
                GD.Print("coffee ", item_name);
                story.StoreVariable("item_coffee", true);
            break;
        case "anime":
                GD.Print("anime ", item_name);
                story.StoreVariable("item_anime", true);
            break;
        default:
            GD.Print("bad item -> ", item_name);
            break;
        }
    }


    public void setItem(string item_name, bool cond){
        return;
        GD.Print("setting item", item_name);
        switch (item_name){
        case "tissues":
                GD.Print("tissues ", item_name);
                story.StoreVariable("item_tissues", cond);
            break;
        case "crybox":
                GD.Print("crybox " , item_name);
                story.StoreVariable("item_crybox", cond);
            break;
        case "coffee":
                GD.Print("coffee ", item_name);
                story.StoreVariable("item_coffee", cond);
            break;
        case "anime":
                GD.Print("anime ", item_name);
                story.StoreVariable("item_anime", cond);
            break;
        default:
            GD.Print("bad item -> ", item_name);
            break;
        }
    }
    public void goTo_knot(string knot_name){
        story.ChoosePathString(knot_name);
    }
}

