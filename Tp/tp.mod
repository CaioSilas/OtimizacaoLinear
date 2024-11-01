// Defini��o dos dados
int m = ...;  // N�mero de tipos de itens
int n = ...;  // N�mero de padr�es de corte

range Items = 1..m;  // Conjunto de itens
range Patterns = 1..n;  // Conjunto de padr�es de corte

// Demandas para cada item
int demand[Items] =...;

// Matriz de padr�es de corte
int cuts[Patterns][Items]=...;

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
        if (x[j].solutionValue > 0) {  // Exibe apenas padr�es utilizados
            writeln("Padr�o ", j, ": utilizado ", x[j].solutionValue, " vezes.");
        }
    }
}


/*********************************************
 * OPL 20.1.0.0 Model
 * Author: Caio Silas/ Julia Gonzaga
 * Creation Date: 2 de out de 2024 at 19:32:51
 *********************************************/
