import Cocoa

public class CPCalculator {
    
    public init() {}
    
    // create database and include some Pokemon with base values
    let pokemonDataBase: [String:(baseAtk: Double, baseDef: Double, baseSta: Double)] = [
        "Groudon":(270,251,182),
        "Raikou":(241,210,180),
        "Lugia":(193,323,212),
        "Feebas":(29,102,40),
        "Metagross":(257,247,160),
        "Salamence":(277,168,190),
        "Aggron":(198,314,140),
        "Armaldo":(222,183,150),
        "Flygon":(205,168,160),
        "Rayquaza":(284,170,191),
        "Latios":(268,228,160),
        "Latias":(228,268,160),
        "Regice":(179,356,160),
        "Regirock":(179,356,160),
        "Registeel":(143,285,160)
    ]
    
    let cpMultiplier = [
        0.09400000, 0.16639787, 0.21573247, 0.25572005, 0.29024988,
        0.32108760, 0.34921268, 0.37523559, 0.39956728, 0.42250001,
        0.44310755, 0.46279839, 0.48168495, 0.49985844, 0.51739395,
        0.53435433, 0.55079269, 0.56675452, 0.58227891, 0.59740001,
        0.61215729, 0.62656713, 0.64065295, 0.65443563, 0.66793400,
        0.68116492, 0.69414365, 0.70688421, 0.71939909, 0.73170000,
        0.73776948, 0.74378943, 0.74976104, 0.75568551, 0.76156384,
        0.76739717, 0.77318650, 0.77893275, 0.78463697, 0.79030001
    ]
    
    // just a helper function to calculate a digit sum
    func digitSum(_ n : Int) -> Int {
        return sequence(state: n) { (n: inout Int) -> Int? in
            defer { n /= 10 }
            return n > 0 ? n % 10 : nil
            }.reduce(0, +)
    }
    
    func fetchBaseValuesOf(_ pokemon: String) -> (baseAtk: Double, baseDef: Double, baseSta: Double)? {
        guard let baseValues = pokemonDataBase[pokemon] else {
            print("Pokemon with name '\(pokemon)' not found!")
            print("You can add missing Pokemon by adding them to 'pokemonDataBase' in line 4.")
            return nil
        }
        return (baseValues.baseAtk, baseValues.baseDef, baseValues.baseSta)
    }
    
    func fetchCPMultiplierForLevel(_ level: Int) -> Double {
        if level < 1 || level > 40 {
            print("Invalid Pokemon level. Choose a level between 0 and 40.")
            return cpMultiplier[0]
        }
        return cpMultiplier[level-1]
    }
    
    // single value calculation for certain level and ivs
    func calculateCPOf(_ pokemon: String, atLvl level: Int, withIVs IVs: (ivA: Double, ivD: Double, ivS: Double)) -> Int? {
        guard let baseValues = fetchBaseValuesOf(pokemon) else {
            return nil
        }
        
        let totalCPMultplier = fetchCPMultiplierForLevel(level)
        
        let attack  = (baseValues.baseAtk+IVs.ivA)*totalCPMultplier
        let defense = (baseValues.baseDef+IVs.ivD)*totalCPMultplier
        let stamina = (baseValues.baseSta+IVs.ivS)*totalCPMultplier
        
        let cp = max(10, floor(sqrt(stamina)*attack*sqrt(defense)/10))
        
        return Int(cp)
    }
    
    // calculate cps in range 10/10/10 to 15/15/15, check possible returns (by cp, by perfection)
    func calculateCPRangeOf(_ pokemon: String, atLvl level: Int) -> [(key: String, value: Int)]? {
        guard let baseValues = fetchBaseValuesOf(pokemon) else {
            return nil
        }
        let totalCPMultplier = fetchCPMultiplierForLevel(level)
        
        var cpRange: [String : Int] = [:]
        
        for ivA in 10...15 {
            for ivD in 10...15 {
                for ivS in 10...15 {
                    let attack = (baseValues.baseAtk+Double(ivA))*totalCPMultplier
                    let defense = (baseValues.baseDef+Double(ivD))*totalCPMultplier
                    let stamina = (baseValues.baseSta+Double(ivS))*totalCPMultplier
                    
                    let cp = Int(max(10, floor(sqrt(stamina)*attack*sqrt(defense)/10)))
                    cpRange["\(ivA-10)\(ivD-10)\(ivS-10)"] = cp
                }
            }
        }
        return cpRange.sorted(by: { $0.1 == $1.1 ? digitSum(Int($0.0)!) > digitSum(Int($1.0)!) : $0.1 > $1.1 }) // sorted by CP
        //return cpRange.sorted(by: { digitSum(Int($0.0)!) == digitSum(Int($1.0)!) ? $0.1 > $1.1 : digitSum(Int($0.0)!) > digitSum(Int($1.0)!) }) //sorted by IV%
    }
    
    // most important function: printing all cp values between 66.6% and 100% perfection
    // example: printCPRangeOf("Feebas", atLvl: 20)
    public func printCPRangeOf(_ pokemon: String, atLvl level: Int) {
        guard let list = calculateCPRangeOf(pokemon, atLvl: level) else {
            return
        }
        var ivString: String
        var ivAStr: String
        var ivDStr: String
        var ivSStr: String
        var perfection: Double
        
        print("– \(pokemon) Lv.\(level) –")
        
        for (iv,cp) in list {
            ivString = iv
            ivAStr = String(ivString.prefix(1))
            ivSStr = String(ivString.suffix(1))
            ivString.removeFirst()
            ivString.removeLast()
            ivDStr = ivString
            perfection = Double(round(10*(Double(digitSum(Int(ivAStr+ivDStr+ivSStr)!)+30)*100/45))/10)
            print("CP: \(cp) | IV: A1\(ivAStr), D1\(ivDStr), S1\(ivSStr) | \(perfection)%")
        }
    }
}
