/*********************************************
 * OPL 20.1.0.0 Model
 * Author: Caio Silas/ Julia Gonzaga
 * Creation Date: 2 de out de 2024 at 19:46:25
 *********************************************/
// Defini��o dos dados
int m = 5;  // N�mero de tipos de itens
int n = 6;  // N�mero de padr�es de corte

range Items = 1..m;  // Conjunto de itens
range Patterns = 1..n;  // Conjunto de padr�es de corte

// Demanda
int demand[Items] = [30, 20, 15, 25, 10]; 

// Matriz de padr�es de corte: 
int cuts[Patterns][Items] = [
    [6, 0, 0, 0, 0],  
    [0, 5, 0, 0, 0],  
    [3, 2, 0, 0, 0],  
    [0, 0, 4, 0, 0],  
    [2, 2, 1, 1, 0],  
    [0, 0, 0, 3, 5]   
];

// Vari�veis de decis�o
dvar int+ x[Patterns];  // Quantidade de vezes que o padr�o de corte j � utilizado

// Fun��o objetivo: Minimizar o n�mero total de rolos utilizados
minimize sum(j in Patterns) x[j];

// Restri��es: Atender � demanda de cada item
subject to {
    forall(i in Items) {
        sum(j in Patterns) cuts[j][i] * x[j] >= demand[i];  // A demanda deve ser atendida
    }
}

// Impress�o da solu��o
execute {
    writeln("N�mero total de rolos utilizados: ", cplex.getObjValue());
    for (var j in Patterns) {
        if (x[j].solutionValue >= 0) {  // Exibe apenas padr�es utilizados
            writeln("Padr�o ", j, ": utilizado ", x[j].solutionValue, " vezes.");
        }
    }
}
 