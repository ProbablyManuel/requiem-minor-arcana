Scriptname RMA_EquipAbility extends ObjectReference  

Spell Property SpellAbility Auto

Event OnEquipped(Actor akActor)
	akActor.AddSpell(SpellAbility,false)
EndEvent

Event OnUnEquipped(Actor akActor)
	akActor.RemoveSpell(SpellAbility)
EndEvent