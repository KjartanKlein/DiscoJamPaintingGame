VAR item_tissues = false
VAR item_anime = false
VAR item_crybox = false
VAR item_coffee = false

->intro

===intro===
#ChangeName:You
Huh... I always thought breaking into an art gallery would be more difficult.
Heh, if I actually wanted to steal any of this stupid art then these idiots would be in trouble.
But I'm after something much more important...
My poetry notebook!!! I can't believe I dropped it on our school trip earlier!
Oh god, if anyone finds it, I'll DIE! I have to get it back!
We only went round this dumb Italian exhibit, it must be around here somewhere...
close #close
->intro

===seeing_painting_1===
#setVisible:sad_boy:true
#ChangeName:You
Ugh, these cringe-ass paintings again. Really, Caravaggio? A black-haired angel and a white-haired ange? Tumblr called, it wants its 2014 yaoi back.
Wait... There's only one angel here now?
And he's holding something! It kinda looks like...
MY POETRY BOOK???
->painting_1_crying


===painting_1_crying===
#setVisible:sad_boy:true
#ChangeName:Crying Angel
[i]*hgk* *hic* *sniff* *sniff* *blub* [/i]
* [Excuse me?]
- This is all my fault... 
* [EXCUSE ME!]
- [i]*hgk* *hic* *sniff* *sniff* *blub* [/i] 
* [GIVE ME MY POETRY NOTEBOOK BACK RIGHT NOW!!!]
- [i]*hgk* *hic* *sniff* *sniff* *blub* [/i] 
#ChangeName:You
Ugh, it's hopeless. He's crying so much he can't even hear me...
Maybe there's something around here I can use to shut him up a minute.
* {item_tissues} [Give Tissues]
    -> give_tissues
* [Leave]
    close #close   
->painting_1_crying


 ===pick_up_tissues===       
#ChangeName:You
Maybe this'll be enough to stop that thief's crying.
close #close
->pick_up_tissues      
    

===give_tissues===
#setVisible:sad_boy:true
#ChangeName:Crying Angel
[i]*hgk* *hic* *sniff* *sniff* *blub* [/i]
* [Offer Tissues]
#ChangeName:You
~item_tissues = false
Uh, here...
->stopped_crying

->give_tissues
        
===stopped_crying===
#setVisible:sad_boy:true
#ChangeName:Crying Angel
[i] *sniff* *sniff* [/i] Thank you...
#ChangeName:You
Yeah, whatever. Look, I need that notebook back.
#ChangeName:Crying Angel
This book? Oh no, I couldn't possibly part with it. The poems inside are much too dear.
#ChangeName:You
YOU READ IT???
#ChangeName:Crying Angel
Of course. These sweet verses are my only solace now that--
Now that...
Now that [i] he's [/i] gone...
#ChangeName:You
Now who's gone??
#ChangeName:Crying Angel
My one and only love! My sweet, white-haired prince!
#ChangeName:You
The... angel in the painting next to you?
#ChangeName:Crying Angel
That's him... We had a lover's tiff, and he absconded without me.
I tried to follow, of course, but these wretched chains...
Now these poems are all I have left to remind me of the sweet touch of love...
#ChangeName:You
(This isn't good. I don't think I'm getting my notebook back until I reunite these two.)
If I bring your boyfriend home, will you give me back my notebook?
#ChangeName:Crying Angel
Oh, if I had him by my side I would happily never read another word again!
#ChangeName:You
I'll take that as a yes. Where do you think he might have gone?
#ChangeName:Crying Angel
He said he needed some fresh air... Perhaps he took to the rooftop terrace.
But be careful! This place is guarded by a fearsome man upon a strange metal steed. 
#ChangeName:You
Right, I'll... look out for that.
close #close
->stopped_crying
 
===locked_door===
#ChangeName: You
Ugh, locked. I'll never be able to guess the code before morning...
Maybe there's someone around here I could ask?
close #close
->locked_door       

===coffee_lady===
#setVisible:coffee_lady:true
#ChangeName: Tired Woman
Zzzzz....
#ChangeName: You
Hello?
#ChangeName: Tired Woman
Zz-rk? *yaaaaaaaaaaaaaaaawwwwwwwwwwwwwwn* 
Ah... yes?
#ChangeName: You
Hi, I'm trying to get through that door. Do you know the code?
#ChangeName: Tired Woman
Zzzzz....
#ChangeName: You
Don't fall back asleep while I'm trying to ask you something!
#ChangeName: Tired Woman
Zzzzz....
#ChangeName: You
...
(It's no good, I won't get anything out of her like this. If only she'd wake up a bit.)
* {item_coffee} [Want this hot cup of "coffee"?]
    -> got_coffee
* [Leave]
- close #close
-> coffee_lady
    
===coffee_machine===
#ChangeName:Go.dot.Com
You have awoken me.
The final challenge
The perfect coffee can be delivered if you select correctly.
What is your cup size?
-> cup_size

=== cup_size ===
* small
    How small?
    ** small small
        More precision needed
        *** Very small small
        *** Not very small small
        *** Why bother?
    ** small medium
    More precision needed
        *** small medium on the lower side
        *** små
        *** 4
    ** big small
* medium
    ** medium medium
    ** large medium
    ** mediumish large

* BIG
- HMmmmmm I see
-> beans

===beans===
What kind of beans?
* Heinz
    Out of ketchup, select an alternative
    ** Mayo
    ** Heinz beans
    ** Who made you like this?
* Small batch
    From which earthly place
    ** Africa
    ** Antartica
    ** Atlantis
* Big batch
    You like it big, do you?
    Preferred bigness
    ** Biiiig
    ** BiiiiiiiG
    ** Huge
    ** small actually
* Matcha late
    Robot to tea ratio?
    ** 1
    ** 0
* No, thanks
-Interesting choice
-> origin

===origin===
Where from? 
* single origin ofc
* Just give me coffee dude
* from SPACE
    Which parts of space?
    ** space
- Location selected AND ignored
-> condiments

===condiments===
Any condiments?
* Huh?
* Yes, all of them
* No
- That was a wise choice
->grind
 
===grind===
-Grind size 1-10?
* -1
* 5
* 22
* 0+1i 
    I can imagine this one.
    Pleasant. 
    -> heat
- Poorly chosen
->heat

===heat===
-Water Heat?
* 70°C
* 70°K
* 70°F
- I prefer mine at a good 2147483647
-> method

===method===
-Brew method?
* Handmade
    You mock me for having no hands human, but your head is big.
    Got them.
* French Press
    Oui Oui
* German Press
    Ja Ja
* Esspresso style
- Interesting
-> coffee_result

===coffee_result===
You have a terrible taste in coffee.
I refuse to make that, you shall get the perfect cup.
As the philosopher said: " I remember when a joey smoey like me can walk to store and buy plane cofy with money from bank" -cofyguy20
The correct option is "PLANE COFY" Dispensing now.
Please Upload Coffee to mouth
#ChangeName:You
Huh, it says this thing was an art piece discontinued for ignoring people, called "the perfect cup". What is it doing here?
* [Get Coffee]
~item_coffee =true
- close #close
->coffee_machine    
        
===give_coffee===
#setVisible:coffee_lady:true
#ChangeName: Tired Woman
Zzzzz....
*[Give coffee]
-> got_coffee
     

===got_coffee===
#ChangeName: Wired Woman
#setVisible:coffee_lady:true
Ohhhhhhhhhhhhhhhhhhhh YES! Blacker than a moonless night, hotter and more bitter than Hell itself… 
THAT is coffee!
Thank you, I needed that pick me up!
#ChangeName: You
Yeah, you're welcome. Any chance you know the code to get through that door?
#ChangeName: Wired Woman
Absolutely, I see the guards putting it in all day. It's 12345.
#ChangeName: You
Are you kidding me??? That should have been my first guess.
~item_coffee = false
close #close
->got_coffee  

===on_roof===
    #ChangeName: You
        There you are. Couldn't you have gone to sulk somewhere that didn't have a locked door in the way?
    #setVisible:bad_boy:true
    #ChangeName: Absconded Angel
        ...
    #ChangeName: You
        Uhhh... Hello?
    #ChangeName: Absconded Angel
        Can you hear that?
    #ChangeName: You
        Hear what?
    #ChangeName: Absconded Angel
        The stars make such beautiful music.
    #ChangeName: You
        (Oh great, he's just as cracked as the other one.)
    #ChangeName: Absconded Angel
        It's so peaceful up here. All my earthly concerns seem so far away.
    #ChangeName: You
        That's great, but my earthly concerns are NOT far away.
        Can you just go back to your boyfriend already so I can get my notebook and get out of here?
    #ChangeName: Absconded Angel
        My... boyfriend? I'm afraid things between us are over.
    #ChangeName: You
        Oh... That sucks. What happened?
    #ChangeName: Absconded Angel
        I found this book full of the most amazing poetry!
    #ChangeName: You
        You what?
    #ChangeName: Absconded Angel   
        But when I went to share it with him, I realised he didn't pay any attention at all.
        He couldn't even list his three favourite metaphors from the collection!
        That's when I realised, he doesn't really care about me! He's only with me for our thematic resonance...
    #ChangeName: You
        I'm pretty sure he cares about you a lot. He's losing it back there.
    #ChangeName: Absconded Angel   
        I find that hard to believe.
    #ChangeName: You
        Then I'll just have to prove it.
        close #close
->on_roof                   
        
    
===ask_for_tissues===
    #setVisible:sad_boy:true
    #ChangeName: You
    ~item_crybox=true
        Uh, this is going to sound weird, but can I have one of those tissues?
    #ChangeName: Sniffing Angel
        Hm? Oh, of course. Here's the box.
    #ChangeName: You
        No, sorry... Can I have one of the... used ones?
    #ChangeName: Sniffing Angel
        ...
    #ChangeName: You
        ...
    #ChangeName: Sniffing Angel
        ...
        If you wish. The tears are making my brushstrokes run anyway.
    #ChangeName: You
        (Yuck... This thing is dripping with his tears... But maybe this will be enough to convince the other angel he misses him.)
    
    close #close
-> ask_for_tissues

->give_tissues_2
===give_tissues_2===
    #setVisible:bad_boy:true
    #ChangeName: Absconded Angel
        Oh, it's you again. If this is about that heartless cur, I don't want to hear it.
    #ChangeName: You
        Stop brooding and have a look at this.
    #ChangeName: Absconded Angel
        A sopping wet tissue?
    #ChangeName: You
        Not just any sopping wet tissue. These are--
    #ChangeName: Absconded Angel
        His tears! Of course, I'd know that shade of aqaumarine anywhere!
        He cried so much over my absence... To think I ever doubted his love!
        What have I done? How could I cause my darling such pain?!
        I must return to him at once!
// Would be good to maybe change the scene here so the painting disappears and before this final line directing the player back to the original paintings, if possible?
    #ChangeName: You
        (Suppose it's time to sneak past that guard one more time...)
    ~item_anime = true
    ~item_crybox = false
    close #close
    ->give_tissues_2

===reunited===
    #setVisible:sad_boy:true
    #ChangeName: You
        (Finally, they're back together.)
    #ChangeName: Returned Angel
        Look who it is! Our saviour!
    #ChangeName: Smiling Angel
        You brought him home! How can I ever thank you!
    #ChangeName: You
        How about by giving me back my poems?
    #ChangeName: Returned Angel
        You were the author of these illustrious verses?
    #ChangeName: You
        ...Yeah. They're just stupid though. I don't even know what I was thinking--
    #ChangeName: Smiling Angel
        How can you speak so? When these words capture the very essence of love!
    #ChangeName: You
        T-they do??
    #ChangeName: Smiling Angel
        Of course! When my darling first read them to me, I was so spellbound by their beauty I could hardly speak!
        Take this verse:
    #ChangeName: You
        (Oh god, he's going to read it out loud... I might die...)
    #ChangeName: Smiling Angel
        "The sky is black...
        My tears are blue...
        My heart is chained,
        But the key is you."
        Doesn't that say it all?
    #ChangeName: Returned Angel
        That was my favourite too! Have any two souls ever been more aligned?
    #ChangeName: You
        You two really like my poems??
    #ChangeName: Returned Angel
        They're true art. They must have been inspired by a powerful love.
    #ChangeName: You
        I don't know about that... But... there is someone in my class...
        I wrote these poems for him, and I was going to give him them on the trip today...
        But I chickened out. What would he want with a loser like me?
    #ChangeName: Smiling Angel
        A loser? You took on a dangerous quest just to reunite two lovers! No, this proves you are a couragous and creative beautiful soul! 
    #ChangeName: You
        Heh... Thanks.
        (Even if all I wanted was my notebook back... Helping these two was just a lucky side effect.)
    #ChangeName: Returned Angel
        You should tell him how you feel. Here, we'll return your poems. You'll need them.
    #ChangeName: You
        Nah, if you two like them so much you can keep them. I'll write more.
    #ChangeName: Smiling Angel
        And gift them to your beloved?
    #ChangeName: You
        We'll see.
        It's late. I'd better be getting home. That guard sucks at his job, but it would still be bad to get caught after all this.
    #ChangeName: Returned Angel
        Farewell! And thank you once again!
    close #close
    ->reunited

-> END