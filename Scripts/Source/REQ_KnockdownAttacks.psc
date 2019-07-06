Scriptname REQ_KnockdownAttacks extends ActiveMagicEffect
{Trigger script for all kinds of knockdowns, both infantry and cavalry. Normal knockdowns cannot
trip the attacker when failed, but charging knockdowns on the other hand have the higher success 
change. Horse trample attacks always count as charging knockdowns.}

Keyword Property HeavyArmor Auto
{the keyword that disables the Acrobatics perk due to wearing heavy armor for the defender}
Perk Property Evasion Auto
{the Acrobatics perk that can artificially raise the defender's mass}
Spell Property Impact Auto
{any extra effect to apply due to the impact, e.g. a damage script with physical resistance}
Float Property MassOffset = 0.0 Auto
{any circumstance mass modifier for the attacker that should be applied}
Perk Property UnstoppableCharge = None Auto
{if the player has the unstoppable charge perk, don't interrupt their charge}
GlobalVariable Property ShieldChargeCooldown Auto
{0 = ready, 1 = started charging, -1 = cooldown, controlled through the RMA_ShieldCharge_Stamina_Cost_and_Cooldown [MGEF:00017331]}
GlobalVariable Property ShieldCharging Auto
{1 = we're hitting someone, 0 = we're not, used to apply RMA_ShieldCharge_Stamina_Cost_and_Cooldown}

Event OnEffectStart(actor Target, actor Caster)
	Float charging = ((Caster.IsSprinting() || Caster.IsOnMount()) as Float)
	Float TargetMass = Target.GetAV("Mass")
	Float AttackerMass = Caster.GetAV("Mass") + MassOffset
	Float Chance = 0.25
	Float Force = 2.5
	
	charging = charging * AttackerMass* Math.sqrt(AttackerMass) + 1
	TargetMass += 0.5* (Target.HasPerk(Evasion) && !Target.WornHasKeyword(HeavyArmor)) as Float
	If Caster == Game.GetPlayer()
		If !UnstoppableCharge \
		   || !Caster.HasPerk(UnstoppableCharge) \
		   || !Caster.GetAnimationVariableBool("Isblocking") \
		   || ShieldChargeCooldown && ShieldChargeCooldown.Value == 1
			Input.ReleaseKey(Input.GetMappedKey("Sprint"))
		ElseIf ShieldCharging
			ShieldCharging.SetValue(1)
		EndIf
	EndIf
	If Impact != None
		Impact.Cast(Caster, Target)
	EndIf
	chance *= AttackerMass / ((TargetMass + 0.5) * Math.sqrt((TargetMass + 0.5)))
	If Utility.RandomFloat() <= chance * charging
		Force *= AttackerMass / TargetMass
		If Caster == Game.GetPlayer() && Force >= 5.0
			Force = 5.0
		EndIf
		Caster.PushActorAway(Target, Force)
	ElseIf Charging == 2
		Chance = 0.25 * TargetMass / ((AttackerMass + 0.5) * Math.sqrt((AttackerMass + 0.5)))
		If Utility.RandomFloat() <= Chance
			Target.PushActorAway(Caster, 2.5 )
		EndIf
	EndIf
	
	If ShieldCharging && ShieldCharging.Value == 1
		Utility.Wait(1.0) ; give some time for the condition in RMA_ShieldCharge_StaminaCost_and_NPC_Cloak [SPEL:0010CAAF] to kick in
		ShieldCharging.SetValue(0)
	EndIf
EndEvent