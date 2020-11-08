Scriptname RMA_ShieldChargeCooldown extends ActiveMagicEffect

GlobalVariable Property ShieldChargeCooldown Auto

Event OnEffectStart(actor Target, actor Caster)
	If Caster == Game.GetPlayer() && ShieldChargeCooldown.Value != -1
		;Debug.notification("CHARGING!")
		ShieldChargeCooldown.SetValue(-1)
		Utility.Wait(7)
		
		;Debug.notification("Cooling...")
		ShieldChargeCooldown.SetValue(1)
		Utility.Wait(120)
		Utility.WaitGameTime(0.2)
		Utility.Wait(Utility.RandomFloat(0, 120))
		Utility.WaitGameTime(Utility.RandomFloat(0, 0.2))
		
		;Debug.notification("Ready!")
		ShieldChargeCooldown.SetValue(0)
	EndIf
EndEvent