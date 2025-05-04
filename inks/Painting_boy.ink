VAR item_tissues = false
VAR item_Boyfriend = false
VAR Consoled = false
VAR Won = false
VAR item_coffee = false

-> inital
=== inital === 
BooHooHoo BooHooHoo my boyfriend where is he #ChangeName:AnimeBoy
* What is wrong?
	-> dialog
* omg anime boy
	[i]Crying sounds[/i]
	-> inital
* ...
	[i]Crying sounds[/i]
	-> inital


=== dialog ===
He said... *sniff* He said I was to [shake]emotional[/shake] and that...#ChangeName:AnimeBoy
He cries inchoherently, maybe he needs tissues but i am not your boss #ChangeName:Narrator 
* {item_tissues} offer Tissues
	~ item_tissues = false
	-> tissues
* ...
- close #close
-> dialog

=== tissues ===
#ChangeName:AnimeBoy
Thank you...
How did you get this into the painting??
anyways, have you seen where my boyfriend went, he said... he said he needed some fresh air, so i think he mus be on the roof
There is a door in the other room
watch out for the guard, now that I have stopped crying he might get suspicious
~Consoled = true
close #close
->tissues

=== crybox ===
#ChangeName:AnimeBoy
Sniff sniff, [wave] blows nose [/wave]
* Can i have those tissues
	What
	why
	creep
	sure
	close #close 
	-> crybox
* ewwww
	close #close
	-> crybox

=== boyfriend ===
#ChangeName:boytoy
You have found my boyfriend
Mwah Mwah we are kissing
~Won = true
-> END


=== coffee_lady ===
#ChangeName:Tierd lady
I am so sleepy, I despritly need a pick me up
Oh the guard code? I know it it is.... actually get me a cup of joe and i will give you the code
close #close
-> coffee_lady

=== has_coffee ===
#ChangeName:Tierd lady
Oh is that for me?
* Throw at painting
* Give gently
- Perrrrrfeeeectttt, the code is 1123 they werwe trying some fibonachi code but it is dangerously simple
close #close
-> has_coffee


=== rooftop_boyfriend ===
#ChangeName:boytoy
The stars are so beutiful i want to kill them... or something
* Tell him about his boyfriend
- No he does not care about me, I dont belive you that he is crying about me
* Ill show him 
- close #close
-> rooftop_boyfriend



=== has_crybox ===
#ChangeName:boytoy
Oh he really does care about me? I dont belvie it, theese are his genuine tears, aquamarine blue
Take me to him NOW
close #close
-> has_crybox

