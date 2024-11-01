/*********************************************
 * OPL 20.1.0.0 Model
 * Author: Caio Silas/ Julia Gonzaga
 * Creation Date: 2 de out de 2024 at 19:46:25
 *********************************************/
// Definição dos dados
int m = 5;  // Número de tipos de itens
int n = 6;  // Número de padrões de corte

range Items = 1..m;  // Conjunto de itens
range Patterns = 1..n;  // Conjunto de padrões de corte

// Demanda
int demand[Items] = [30, 20, 15, 25, 10]; 

// Matriz de padrões de corte: 
int cuts[Patterns][Items] = [
    [6, 0, 0, 0, 0],  
    [0, 5, 0, 0, 0],  
    [3, 2, 0, 0, 0],  
    [0, 0, 4, 0, 0],  
    [2, 2, 1, 1, 0],  
    [0, 0, 0, 3, 5]   
];

// Variáveis de decisão
dvar int+ x[Patterns];  // Quantidade de vezes que o padrão de corte j é utilizado

// Função objetivo: Minimizar o número total de rolos utilizados
minimize sum(j in Patterns) x[j];

// Restrições: Atender à demanda de cada item
subject to {
    forall(i in Items) {
        sum(j in Patterns) cuts[j][i] * x[j] >= demand[i];  // A demanda deve ser atendida
    }
}

// Impressão da solução
execute {
    writeln("Número total de rolos utilizados: ", cplex.getObjValue());
    for (var j in Patterns) {
        if (x[j].solutionValue >= 0) {  // Exibe apenas padrões utilizados
            writeln("Padrão ", j, ": utilizado ", x[j].solutionValue, " vezes.");
        }
    }
}
 