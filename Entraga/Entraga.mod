/*********************************************
 * OPL 20.1.0.0 Model
 * Author: silas
 * Creation Date: 25 de jul de 2024 at 21:36:19
 *********************************************/
//////Problema da Dieta
////dados de entras
//{string} I =...;
//{string} V =...;
//float P[I] = ...;
//int Req[V] = ...;
//float Qtd[V][I] = ...;
//
////Definir variáveis de decisão
//
//	dvar float+ x[I];
//
////Definir a função Objetivo
//
//	minimize //maximize
//		sum(i in I) P[i]*x[i];
//
//
////Restrições
//subject to
//{
//   //Vitaminas
//   forall(v in V)
//     Req_Vitamina:
//     	sum(i in I) Qtd[v][i]* x[i] >= Req[v];
//   		
//  //Não-negatividade
//   forall( i in I)
//     	x[i] >= 0;
//}

/******************************************************************************************************************************/
//Problema da Cooperativa Agr�cola
//// Dados de entrada
//{string} F = ...; // Conjunto das fazendas
//{string} C = ...; // Conjunto das culturas
//
//float Areaf[F] = ...; // �rea dispon�vel em cada fazenda f
//float Aguaf[F] = ...; // Quantidade de �gua dispon�vel em cada fazenda f
//float AMaxc[C] = ...; // �rea m�xima que pode ser cultivada de cada cultura c
//float ConsAguac[C] = ...; // Consumo de �gua por acre para cada cultura c
//float Lucroc[C] = ...; // Lucro por acre plantado de cada cultura c
//
//// Definir vari�veis de decis�o
//dvar float+ x[F][C]; // �rea em acres da fazenda f destinada ao plantio da cultura c
//
//// Definir a fun��o objetivo
//maximize 
//  sum(f in F, c in C) Lucroc[c] * x[f][c];
//
//// Restri��es
//subject to {
//  // Restri��o de �rea dispon�vel na fazenda
//  forall(f in F)
//    sum(c in C) x[f][c] <= Areaf[f];
//  
//  // Restri��o de �gua dispon�vel na fazenda
//  forall(f in F)
//    sum(c in C) ConsAguac[c] * x[f][c] <= Aguaf[f];
//  
//  // Restri��o de �rea m�xima plantada por cultura
//  forall(c in C)
//    sum(f in F) x[f][c] <= AMaxc[c];
//  
//  // Restri��o de propor��o de �rea cultivada
//  forall(f in F, g in F: f != g)
//    sum(c in C) x[f][c] / Areaf[f] == sum(c in C) x[g][c] / Areaf[g];
//}

/******************************************************************************************************************************/
////Problema da planta��o sitio
//// Dados de entrada
//float Armmax = ...; // Capacidade m�xima de armazenamento do s�tio (em toneladas)
//float Areamax = ...; // �rea m�xima dispon�vel para cultivo no s�tio (em m�)
//{string} C = ...; // Conjunto das poss�veis culturas que podem ser plantadas no s�tio
//
//float Demc[C] = ...; // Demanda do pr�prio s�tio para a cultura c
//float Prodc[C] = ...; // Produtividade da cultura c em kg por m�
//float Lucroc[C] = ...; // Lucro por kg da cultura c
//
//// Definir vari�veis de decis�o
//dvar float+ x[C]; // �rea (em m�) plantada da cultura c
//
//// Definir a fun��o objetivo
//maximize 
//  sum(c in C) Prodc[c] * Lucroc[c] * (x[c] - Demc[c]);
//
//// Restri��es
//subject to {
//  // Demanda do s�tio
//  forall(c in C)
//    x[c] >= Demc[c];
//  
//  // �rea total cultivada
//  sum(c in C) x[c] <= Areamax;
//  
//  // Armazenamento
//  sum(c in C) Prodc[c] * x[c] <= Armmax * 1000; // Convertendo toneladas para kg
//}


/******************************************************************************************************************************/
//Problema Mistura de Petroleo
// Conjuntos
//{string} I = ...; // Tipos de gasolina
//{int} J = ...; // Tipos de petr�leo
//
//// Par�metros
//float p[I][J]; // Pre�o de venda por barril da gasolina i produzida a partir do petr�leo j
//float c[J]; // Custo por barril do tipo de petr�leo j
//float D[J]; // Quantidade m�xima dispon�vel do tipo de petr�leo j
//
//// Especifica��es da mistura
//float maxPercent[I][J]; // Percentual m�ximo do petr�leo j na gasolina i
//float minPercent[I][J]; // Percentual m�nimo do petr�leo j na gasolina i
//
//// Vari�veis de decis�o
//dvar float+ x[I][J]; // Quantidade de barris do tipo de petr�leo j destinados � produ��o da gasolina i
//
//// Fun��o objetivo
//maximize 
//  sum(i in I, j in J) p[i][j] * x[i][j] - sum(j in J) c[j] * sum(i in I) x[i][j];
//
//// Restri��es
//subject to {
//  // Disponibilidade de petr�leo
//  forall(j in J)
//    sum(i in I) x[i][j] <= D[j];
//    
//  // Especifica��es da mistura
//  forall(i in I, j in J) {
//    if (maxPercent[i][j] < 1.0)
//      x[i][j] <= maxPercent[i][j] * sum(k in J) x[i][k];
//    if (minPercent[i][j] > 0.0)
//      x[i][j] >= minPercent[i][j] * sum(k in J) x[i][k];
//  }
//  
//  // N�o-negatividade
//  forall(i in I, j in J)
//    x[i][j] >= 0;
//}

/******************************************************************************************************************************/
////problema ligas metalicas
//// Conjuntos
//{string} Ligas = ...; // Tipos de ligas
//
//// Par�metros
//float preco[Ligas]; // Pre�o por tonelada de cada liga
//float disponCobre; // Disponibilidade de cobre (toneladas)
//float disponZinco; // Disponibilidade de zinco (toneladas)
//float disponChumbo; // Disponibilidade de chumbo (toneladas)
//
//// Consumos por tonelada de cada liga
//float consumoCobre[Ligas]; // Consumo de cobre por tonelada de cada liga
//float consumoZinco[Ligas]; // Consumo de zinco por tonelada de cada liga
//float consumoChumbo[Ligas]; // Consumo de chumbo por tonelada de cada liga
//
//// Vari�veis de decis�o
//dvar float+ x[Ligas]; // Quantidade produzida de cada liga (toneladas)
//
//// Fun��o objetivo
//maximize 
//  sum(i in Ligas) preco[i] * x[i];
//
//// Restri��es
//subject to {
//  // Disponibilidade de cobre
//  sum(i in Ligas) consumoCobre[i] * x[i] <= disponCobre;
//  
//  // Disponibilidade de zinco
//  sum(i in Ligas) consumoZinco[i] * x[i] <= disponZinco;
//  
//  // Disponibilidade de chumbo
//  sum(i in Ligas) consumoChumbo[i] * x[i] <= disponChumbo;
//}
/******************************************************************************************************************************/
////Problema atleta indeciso
//// Conjunto de atividades
//{string} Atividades = ...; 
//
//// Par�metros
//float custo[Atividades];       // Custo por se��o de cada atividade
//float calorias[Atividades];    // Calorias por se��o de cada atividade
//float tempo[Atividades];       // Tempo por se��o de cada atividade
//
//float orcamento;               // Or�amento dispon�vel
//float caloriasMax;             // Limite de calorias dispon�veis
//float tempoMax;                // Tempo dispon�vel
//
//// Vari�veis de decis�o
//dvar int+ x[Atividades];       // N�mero de se��es de cada atividade
//
//// Fun��o objetivo
//maximize 
//  sum(a in Atividades) x[a];
//
//// Restri��es
//subject to {
//  // Restri��o de Or�amento
//  sum(a in Atividades) custo[a] * x[a] <= orcamento;
//
//  // Restri��o de Calorias
//  sum(a in Atividades) calorias[a] * x[a] <= caloriasMax;
//
//  // Restri��o de Tempo
//  sum(a in Atividades) tempo[a] * x[a] <= tempoMax;
//}

/******************************************************************************************************************************/
////Padrao de Produ��o
//// Conjunto de matrizes e produtos
//{string} Matrizes; // Tipos de matrizes dispon�veis
//{string} Produtos; // Tipos de produtos finais
//
//// Par�metros
//float custo[Matrizes];      // Custo por chapa da matriz i
//float demanda[Produtos];   // Demanda m�nima para cada produto j
//float a[Matrizes][Produtos]; // Quantidade de chapas da matriz i que contribui para o produto j
//
//// Vari�veis de decis�o
//dvar int+ x[Matrizes]; // Quantidade de chapas cortadas da matriz i
//
//// Fun��o objetivo
//minimize 
//  sum(i in Matrizes) custo[i] * x[i];
//
//// Restri��es
//subject to {
//  // Demanda de produtos
//  forall(j in Produtos)
//    sum(i in Matrizes) a[i][j] * x[i] >= demanda[j];
//}
/******************************************************************************************************************************/
////Problema da ra��o
//// Conjunto de tipos de ra��o
//{string} Racoes = {"AMS", "RE"};
//
//// Par�metros
//float preco[Racoes];        // Pre�o de venda por unidade da ra��o i
//float custo[Racoes];        // Custo por unidade da ra��o i
//float cereais[Racoes];      // Quantidade de cereais (kg) necess�ria por unidade da ra��o i
//float carne[Racoes];        // Quantidade de carne (kg) necess�ria por unidade da ra��o i
//
//float disponibilidadeCarne; // Quantidade total de carne dispon�vel
//float disponibilidadeCereais; // Quantidade total de cereais dispon�vel
//
//// Vari�veis de decis�o
//dvar float+ x[Racoes];     // Quantidade produzida de cada tipo de ra��o
//
//// Fun��o objetivo
//maximize 
//  sum(r in Racoes) (preco[r] - custo[r]) * x[r];
//
//// Restri��es
//subject to {
//  // Restri��o de disponibilidade de carne
//  sum(r in Racoes) carne[r] * x[r] <= disponibilidadeCarne;
//
//  // Restri��o de disponibilidade de cereais
//  sum(r in Racoes) cereais[r] * x[r] <= disponibilidadeCereais;
//}

