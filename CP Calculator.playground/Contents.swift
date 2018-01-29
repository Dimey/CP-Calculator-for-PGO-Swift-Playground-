import Cocoa

// JUST CALCULATION AND PRINTING
// 1. Create a CPCalculator-Object
let calculator = CPCalculator()

// 2. Use the non-latex function, insert your pokemon and its level
calculator.printCPRangeOf("Lunatone", atLvl: 34)

// 3. Look at your concole and enjoy the profit!

// LATEX PART
/*
 Some nice color shades by allyasdf (color-hex.com):
 pastel blue: (206/360,27/100,100/100)
 pastel green: (133/360,27/100,100/100)
 pastel yellow: (60/360,27/100,100/100)
 pastel orange: (32/360,27/100,100/100)
 pastel red: (354/360,30/100,100/100)
 */

// 1. Create transitions
let trans1 = HSBColorTransition(color1: (354/360,30/100,100/100), color2: (353/360, 7/100, 100/100))
let trans2 = HSBColorTransition(color1: (206/360,27/100,100/100), color2: (203/360, 7/100, 100/100))
let trans3 = HSBColorTransition(color1: (133/360,27/100,100/100), color2: (130/360, 7/100, 100/100))

let trans4 = HSBColorTransition(color1: (200/360,13/100,80/100), color2: (196/360,5/100,92/100))

// 2. Use the createLatex-Functions to print latex-formatted tables (single, double, triple)
//calculator.createLatexSingleCPTableFor("Groudon", atLvl: 20, withColorTransition: trans1)
//calculator.createLatexTripleCPTableFor(pokemon1: "Groudon", withTransition1: trans1,
//                                    pokemon2: "Kyogre", withTransition2: trans2,
//                                    pokemon3: "Rayquaza", withTransition3: trans3,
//                                    atLvl: 20)
//calculator.createLatexSingleCPTableFor("Aggron", atLvl: 20, withColorTransition: trans4)
