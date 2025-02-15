export type ConfigurationType =
	"Damage"
	| "Evade"
	| "Knockback"
	| "StealHealth"
	| "Freeze"
	| "BloodFlood"
	| "EvadeChance"
	| "FreezeChance"
	| "KnockbackChance"
	| "StealHealthChance"
	| "BloodFloodChance"
	| "AttackDistance"
    | "CurrentTarget"

export type EffectType = "Freezed" | "BloodFlooded"
export type ModeType = "Single" | "Party" | "Versus"
export type DifficultType = "Easy" | "Medium" | "Hard"

export type UnitType = {
	Model: Model,
	Name: string,

	Stats: {
		XP: number,
		Level: number,
		HP: number,
	},

	Animations: { [string]: number | { AnimationTrack } } & {
		attack: number | { AnimationTrack },
	},

	Configuration: { [ConfigurationType]: number | UnitType },
	Effects: { [EffectType]: number },

	FindTarget: (enemies: { UnitType }) -> nil,
	CanBattle: () -> boolean,
    CanAttack: () -> boolean,
	Initialize: () -> nil,
	Attack: () -> nil,
	Died: () -> nil,
	Move: () -> nil,
	Act: () -> nil,
}

export type MapType = Folder & {
	SpawnAreas: Folder & {
		Red: Part,
		Blue: Part,
	},
	Units: Folder & {
		Red: Folder,
		Blue: Folder,
	},
	Waves: { { UnitType } }?,
}

export type TeamType = {
	Players: { Player }?,
	Units: { UnitType },
}

export type BattleDataType = {
	Teams: {
		Red: TeamType,
		Blue: TeamType,
	},
	Mode: ModeType,
	Map: MapType,
}

local ConfigurationKeys = {
	Damage = "Damage",
	Evade = "Evade",
	Knockback = "Knockback",
	StealHealth = "StealHealth",
	Freeze = "Freeze",
	BloodFlood = "BloodFlood",
	EvadeChance = "EvadeChance",
	FreezeChance = "FreezeChance",
	KnockbackChance = "KnockbackChance",
	StealHealthChance = "StealHealthChance",
	BloodFloodChance = "BloodFloodChance",
    AttackDistance = "AttackDistance",
    CurrentTarget = "CurrentTarget",
}

local EffectKeys = {
	Freezed = "Freezed",
	BloodFlooded = "BloodFlooded",
}

return {
	ConfigurationKeys = ConfigurationKeys,
	EffectKeys = EffectKeys,
}
