Scriptname RMA_AddPlayerPerks extends Quest

Perk[] property PerkArray Auto

event OnInit()
	actor player = Game.GetPlayer()
	int i = 0
	while i < PerkArray.Length
		player.AddPerk(PerkArray[i])
		i += 1
	endwhile
endevent