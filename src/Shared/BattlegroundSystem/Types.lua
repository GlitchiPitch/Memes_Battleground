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

export type BattleDataType = {
    Players: { Player },
    Mode: ModeType,
    Map: MapType,
}

return {}