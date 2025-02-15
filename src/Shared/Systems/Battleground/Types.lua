export type UnitType = {
    Model: Model,
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
    Waves: {
        { UnitType }
    }?,
}

export type ModeType = "Single" | "Party" | "Versus"
export type DifficultType = "Easy" | "Medium" | "Hard"

export type TeamType = {
    Players: { Player }?,
    Units: { Model },
}

export type BattleDataType = {
    Teams: {
        Red: TeamType,
        Blue: TeamType,
    },
    Mode: ModeType,
    Map: MapType,
}

return {}