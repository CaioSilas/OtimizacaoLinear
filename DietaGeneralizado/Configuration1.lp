\ENCODING=ISO-8859-1
\Problem name: Configuration1

Minimize
 obj1: 35 x("Ingr1") + 30 x("Ingr2") + 60 x("Ingr3") + 50 x("Ingr4")
       + 27 x("Ingr5") + 22 x("Ingr6")
Subject To
 Req_Vitamina("A"): x("Ingr1") + 2 x("Ingr3") + 2 x("Ingr4") + x("Ingr5")
                    + 2 x("Ingr6") >= 9
 Req_Vitamina("C"): x("Ingr2") + 3 x("Ingr3") + x("Ingr4") + 3 x("Ingr5")
                    + 2 x("Ingr6") >= 19
End
