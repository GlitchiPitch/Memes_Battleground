export type MapType = Folder & {
    SpawnAreas: Folder & {
        Red: Part,
        Blue: Part,
    },
    Units: Folder & {
        Red: Folder,
        Blue: Folder,
    },
}

export type ModeType = "Single" | "Party" | "Versus"
export type DifficultType = "Easy" | "Medium" | "Hard"

export type BattleDataType = {
    Teams: {
        Red: { Player },
        Blue: { Player },
    },
    Mode: ModeType,
    Map: MapType,
}

return {}