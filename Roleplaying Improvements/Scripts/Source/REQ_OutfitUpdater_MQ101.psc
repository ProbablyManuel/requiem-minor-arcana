Scriptname REQ_OutfitUpdater_MQ101 extends Actor
{this script is used to update Ralofs and Hadvar's equipment once the stormcloak soldier in
the tower is killed by Alduin.}

Actor Property Hadvar Auto
Actor Property Ralof Auto

Outfit Property Outfit_Ralof Auto
Outfit Property Outfit_Hadvar Auto

Armor Property PrisonerClothes Auto
Armor Property PrisonerBoots Auto
Armor Property PlayerRobe Auto
Armor Property PlayerBoots Auto

Spell Property TemperingAbility Auto

Event OnDeath(Actor akKiller)
	(Hadvar as REQ_NPCData).TE_already_tempered = false
	Hadvar.RemoveSpell(TemperingAbility)
	Utility.Wait(1)
	Hadvar.AddSpell(TemperingAbility)
	Utility.Wait(30)
	Ralof.SetOutfit(Outfit_Ralof)
	(Ralof as REQ_NPCData).TE_already_tempered = false
	Ralof.RemoveSpell(TemperingAbility)
	Utility.Wait(1)
	Ralof.AddSpell(TemperingAbility)
EndEvent
