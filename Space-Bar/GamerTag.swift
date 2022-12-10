//
//  GamerTag.swift
//  Space-Bar
//
//  Created by Todd Bruss on 12/10/22.
//

import GameKit

// MARK: 3.375 million gamer tag combinations
func checker() {
    let n = Int.random(in: 0..<randomNames.count)
    let r = Int.random(in: 1000...9999)

    if settings.player == nil {
        settings.player = "\(randomNames[n]) \(r)"
    } else if let player = settings.player, player.isEmpty {
        settings.player = "\(randomNames[n]) \(r)"
    } else if let c = settings.player?.count, c < 3 {
        settings.player = "\(randomNames[n]) \(r)"
    }
}

var randomNames = ["AbstractSpace", "Adhara", "AgathaKing", "Alex", "AlienInvader", "Alpha", "Altair", "Alula", "Alya", "Amalthea", "Amanda", "Amberjack", "Amos", "Anderson", "Ando", "Andromeda", "Ant-Man", "Antares", "Anubis", "Anubis", "Apollo", "Aqua", "AquaMarine", "Aquaman", "Arcadia", "Arcturus", "Ariel", "Aries", "Armonian", "Armstrong", "Artemis", "Asteriod", "Asterix", "Astra", "Astro", "Astrophel", "Atari", "Atlantis", "Atlas", "Atom", "AtomSmasher", "Augusto", "Aurora", "Automic", "Avenger", "Azure", "AzureDragon", "Badar", "Batgirl", "Batman", "BattleCruiser", "BattleStar", "Batwoman", "Becka", "Bellatrix", "Betelgeuse", "Bizarro", "BlackAdam", "BlackBelt", "BlackCanary", "BlackHole", "BlackPanther", "BlackWidow", "Blaster", "BlueBox", "BlueCrystal", "BobaFett", "Bolt", "BorgQueen", "BossMan", "Boston", "Bradbury", "Breakout", "BrickBreaker", "Bumblebee", "Buster", "Buzz", "Calypso", "Camina", "Capella", "CaptAmerica", "CaptCrunch", "CaptMarvel", "CargoShip", "Cassiopeia", "Castor", "Catwoman", "Celestial", "Challenger", "Chandler", "Chandra", "Charon", "ChessPiece", "Chewbacca", "Chrisjen", "Cielo", "Clarissa", "CmdrData", "CocoaPuff", "Colony", "Columbia", "Comet", "Cordelia", "Corona", "Corvette", "CosmicVermin", "CotyarGhazi", "Cressida", "Cyclone", "Cyclone", "Cyclonis", "Danica", "Daredevil", "DarkAtom", "DarkCrytal", "DarkMatter", "DarkStar", "DarkTrooper", "DarthMaul", "DarthVader", "DarthVader", "DavidBowie", "DeathStar", "DeathStar", "Defender", "Despina", "Diogo", "Dione", "Discovery", "DocOck", "DocSavage", "DoctorFate", "Donati", "DonkeyKong", "Donnager", "DrDoom", "DrStrange", "Draco", "Dragon", "Einstein", "Elara", "Electra", "Electric", "Elektra", "Elio", "EmptySpace", "Endeavour", "Enterprise", "Eris", "Expanse", "Falcon", "Fender", "FighterPilot", "FilipInaros", "Finlay", "Flora", "Freakazoid", "Fred", "Frigate", "Galactus", "Galaxy", "Galieo", "GameMaker", "Gamer", "GamerTag", "Gattaca", "GhostMan", "GobblerGalaxy", "Goldenage", "Gravatron", "Green Arrow", "GreenGoblin", "GreenLantern", "Grievous", "GroundControl", "Gunther", "HackerMan", "Halley", "Hamal", "HanSolo", "Hawkeye", "Hawkgirl", "Hawkman", "Hawkwoman", "Heavy", "Hero", "Hesperos", "Hoku", "Hulk", "HumanTorch", "HyperSpace", "Imagineer", "Inquisitor", "Intrepid", "Iris", "IronEagle", "IronFist", "IronMan", "Izar", "JamesHolden", "Janice", "Janus", "JeffersonMays", "Jobs", "Joey", "JohnConnor", "JohnMcClane", "JohnnyFive", "Joker", "Jules-Pierre", "Juliette", "Jupiter", "Kenobi", "Kepler", "KillSwitch", "Klaes", "Kuiper", "KungFu", "KyleReese", "LaserBeak", "LaserEagle", "Leo", "LightYear", "LinearAlgegra", "Locutus", "Loki", "Luke", "LuminousThief", "Magneto", "MajorTom", "Maniac", "Marco", "Marvel", "Mechanica", "MegaMind", "Megatron", "Menace", "Meteor", "Michio", "MilkyWay", "Miller", "Minion", "Mirage", "Monica", "MoonRaker", "Myst", "MythicQuest", "Namid", "Naomi", "Neptune", "NinjaTurtle", "Oberon", "ObiWan", "Omega", "Optimus", "Orion", "Oscar", "PaulStanley", "PaulStevens", "Pete Becker", "Phoebe", "Phoenix", "PlanetX", "Pluto", "Pollux", "Preacher", "Prime", "Quantum", "Rachel", "RadioWave", "Rasalas", "Razorback", "RedTesla", "Regulus", "Relativity", "Richard", "Rigel", "Rigel", "RingPlanet", "RoarinThunder", "Robin", "Rocinante", "RocketMan", "Rocketeer", "Rosenfeld", "Ross", "Roy", "Sabik", "Salute", "SamuelL", "SandMan", "SarahConnor", "Saturn", "SerrioMal", "SevenOfNine", "Shadow", "ShedGarvey", "SilverSurfer", "Sirius", "SkyWalker", "Smallville", "SpaceCadet", "SpaceInvader", "SpaceMan", "SpaceOddity", "SpaceProbe", "SpaceRanger", "SpaceRock", "SpaceShip", "SpaceShuttle", "SpaceStation", "SpaceX", "SpiderMan", "Spirit", "StarBlast", "StarGirl", "StarLord", "StarMan", "StarPlayer", "StarPlayer", "Starship", "Steve", "StormTropper", "Stratocaster", "SunLord", "Superboy", "Supergirl", "Superman", "Supreme", "Taurus", "Taurus", "Tempest", "Terminator", "Thanos", "TheFlash", "TheMystic", "Thing", "Thinker", "Thor", "Thunder", "ThunderBolt", "TieFighter", "Titan", "ToxicAvenger", "TransAm", "Trickster", "Truman", "TychoSation", "UFOEmoji", "Ultron", "UncleBob", "Ursula", "Vega", "Venom", "Ventress", "Ventura", "Voltage", "WarMachine", "WarMoon", "Wasp", "Watcher", "WhatIf", "WhiteStar", "WildFyre", "WolfMan", "Wolverine", "Wolverine", "WonderWoman", "Woz", "WreckItRalph", "XWing", "Xerxes", "Zenith", "Zeus", "ZombieGalaxy"]


func setGamerTag() {
    checker()
    
    let localPlayer = GKLocalPlayer.local
    localPlayer.authenticateHandler = {(_, error) -> Void in
        settings.player = localPlayer.displayName
        checker()
    }
}
