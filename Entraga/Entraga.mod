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
////Definir variÃ¡veis de decisÃ£o
//
//	dvar float+ x[I];
//
////Definir a funÃ§Ã£o Objetivo
//
//	minimize //maximize
//		sum(i in I) P[i]*x[i];
//
//
////RestriÃ§Ãµes
//subject to
//{
//   //Vitaminas
//   forall(v in V)
//     Req_Vitamina:
//     	sum(i in I) Qtd[v][i]* x[i] >= Req[v];
//   		
//  //NÃ£o-negatividade
//   forall( i in I)
//     	x[i] >= 0;
//}

/******************************************************************************************************************************/
//Problema da Cooperativa Agrícola
//// Dados de entrada
//{string} F = ...; // Conjunto das fazendas
//{string} C = ...; // Conjunto das culturas
//
//float Areaf[F] = ...; // Área disponível em cada fazenda f
//float Aguaf[F] = ...; // Quantidade de água disponível em cada fazenda f
//float AMaxc[C] = ...; // Área máxima que pode ser cultivada de cada cultura c
//float ConsAguac[C] = ...; // Consumo de água por acre para cada cultura c
//float Lucroc[C] = ...; // Lucro por acre plantado de cada cultura c
//
//// Definir variáveis de decisão
//dvar float+ x[F][C]; // Área em acres da fazenda f destinada ao plantio da cultura c
//
//// Definir a função objetivo
//maximize 
//  sum(f in F, c in C) Lucroc[c] * x[f][c];
//
//// Restrições
//subject to {
//  // Restrição de área disponível na fazenda
//  forall(f in F)
//    sum(c in C) x[f][c] <= Areaf[f];
//  
//  // Restrição de água disponível na fazenda
//  forall(f in F)
//    sum(c in C) ConsAguac[c] * x[f][c] <= Aguaf[f];
//  
//  // Restrição de área máxima plantada por cultura
//  forall(c in C)
//    sum(f in F) x[f][c] <= AMaxc[c];
//  
//  // Restrição de proporção de área cultivada
//  forall(f in F, g in F: f != g)
//    sum(c in C) x[f][c] / Areaf[f] == sum(c in C) x[g][c] / Areaf[g];
//}

/******************************************************************************************************************************/
////Problema da plantação sitio
//// Dados de entrada
//float Armmax = ...; // Capacidade máxima de armazenamento do sítio (em toneladas)
//float Areamax = ...; // Área máxima disponível para cultivo no sítio (em m²)
//{string} C = ...; // Conjunto das possíveis culturas que podem ser plantadas no sítio
//
//float Demc[C] = ...; // Demanda do próprio sítio para a cultura c
//float Prodc[C] = ...; // Produtividade da cultura c em kg por m²
//float Lucroc[C] = ...; // Lucro por kg da cultura c
//
//// Definir variáveis de decisão
//dvar float+ x[C]; // Área (em m²) plantada da cultura c
//
//// Definir a função objetivo
//maximize 
//  sum(c in C) Prodc[c] * Lucroc[c] * (x[c] - Demc[c]);
//
//// Restrições
//subject to {
//  // Demanda do sítio
//  forall(c in C)
//    x[c] >= Demc[c];
//  
//  // Área total cultivada
//  sum(c in C) x[c] <= Areamax;
//  
//  // Armazenamento
//  sum(c in C) Prodc[c] * x[c] <= Armmax * 1000; // Convertendo toneladas para kg
//}


/******************************************************************************************************************************/
//Problema Mistura de Petroleo
// Conjuntos
//{string} I = ...; // Tipos de gasolina
//{int} J = ...; // Tipos de petróleo
//
//// Parâmetros
//float p[I][J]; // Preço de venda por barril da gasolina i produzida a partir do petróleo j
//float c[J]; // Custo por barril do tipo de petróleo j
//float D[J]; // Quantidade máxima disponível do tipo de petróleo j
//
//// Especificações da mistura
//float maxPercent[I][J]; // Percentual máximo do petróleo j na gasolina i
//float minPercent[I][J]; // Percentual mínimo do petróleo j na gasolina i
//
//// Variáveis de decisão
//dvar float+ x[I][J]; // Quantidade de barris do tipo de petróleo j destinados à produção da gasolina i
//
//// Função objetivo
//maximize 
//  sum(i in I, j in J) p[i][j] * x[i][j] - sum(j in J) c[j] * sum(i in I) x[i][j];
//
//// Restrições
//subject to {
//  // Disponibilidade de petróleo
//  forall(j in J)
//    sum(i in I) x[i][j] <= D[j];
//    
//  // Especificações da mistura
//  forall(i in I, j in J) {
//    if (maxPercent[i][j] < 1.0)
//      x[i][j] <= maxPercent[i][j] * sum(k in J) x[i][k];
//    if (minPercent[i][j] > 0.0)
//      x[i][j] >= minPercent[i][j] * sum(k in J) x[i][k];
//  }
//  
//  // Não-negatividade
//  forall(i in I, j in J)
//    x[i][j] >= 0;
//}

/******************************************************************************************************************************/
////problema ligas metalicas
//// Conjuntos
//{string} Ligas = ...; // Tipos de ligas
//
//// Parâmetros
//float preco[Ligas]; // Preço por tonelada de cada liga
//float disponCobre; // Disponibilidade de cobre (toneladas)
//float disponZinco; // Disponibilidade de zinco (toneladas)
//float disponChumbo; // Disponibilidade de chumbo (toneladas)
//
//// Consumos por tonelada de cada liga
//float consumoCobre[Ligas]; // Consumo de cobre por tonelada de cada liga
//float consumoZinco[Ligas]; // Consumo de zinco por tonelada de cada liga
//float consumoChumbo[Ligas]; // Consumo de chumbo por tonelada de cada liga
//
//// Variáveis de decisão
//dvar float+ x[Ligas]; // Quantidade produzida de cada liga (toneladas)
//
//// Função objetivo
//maximize 
//  sum(i in Ligas) preco[i] * x[i];
//
//// Restrições
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
//// Parâmetros
//float custo[Atividades];       // Custo por seção de cada atividade
//float calorias[Atividades];    // Calorias por seção de cada atividade
//float tempo[Atividades];       // Tempo por seção de cada atividade
//
//float orcamento;               // Orçamento disponível
//float caloriasMax;             // Limite de calorias disponíveis
//float tempoMax;                // Tempo disponível
//
//// Variáveis de decisão
//dvar int+ x[Atividades];       // Número de seções de cada atividade
//
//// Função objetivo
//maximize 
//  sum(a in Atividades) x[a];
//
//// Restrições
//subject to {
//  // Restrição de Orçamento
//  sum(a in Atividades) custo[a] * x[a] <= orcamento;
//
//  // Restrição de Calorias
//  sum(a in Atividades) calorias[a] * x[a] <= caloriasMax;
//
//  // Restrição de Tempo
//  sum(a in Atividades) tempo[a] * x[a] <= tempoMax;
//}

/******************************************************************************************************************************/
////Padrao de Produção
//// Conjunto de matrizes e produtos
//{string} Matrizes; // Tipos de matrizes disponíveis
//{string} Produtos; // Tipos de produtos finais
//
//// Parâmetros
//float custo[Matrizes];      // Custo por chapa da matriz i
//float demanda[Produtos];   // Demanda mínima para cada produto j
//float a[Matrizes][Produtos]; // Quantidade de chapas da matriz i que contribui para o produto j
//
//// Variáveis de decisão
//dvar int+ x[Matrizes]; // Quantidade de chapas cortadas da matriz i
//
//// Função objetivo
//minimize 
//  sum(i in Matrizes) custo[i] * x[i];
//
//// Restrições
//subject to {
//  // Demanda de produtos
//  forall(j in Produtos)
//    sum(i in Matrizes) a[i][j] * x[i] >= demanda[j];
//}
/******************************************************************************************************************************/
////Problema da ração
//// Conjunto de tipos de ração
//{string} Racoes = {"AMS", "RE"};
//
//// Parâmetros
//float preco[Racoes];        // Preço de venda por unidade da ração i
//float custo[Racoes];        // Custo por unidade da ração i
//float cereais[Racoes];      // Quantidade de cereais (kg) necessária por unidade da ração i
//float carne[Racoes];        // Quantidade de carne (kg) necessária por unidade da ração i
//
//float disponibilidadeCarne; // Quantidade total de carne disponível
//float disponibilidadeCereais; // Quantidade total de cereais disponível
//
//// Variáveis de decisão
//dvar float+ x[Racoes];     // Quantidade produzida de cada tipo de ração
//
//// Função objetivo
//maximize 
//  sum(r in Racoes) (preco[r] - custo[r]) * x[r];
//
//// Restrições
//subject to {
//  // Restrição de disponibilidade de carne
//  sum(r in Racoes) carne[r] * x[r] <= disponibilidadeCarne;
//
//  // Restrição de disponibilidade de cereais
//  sum(r in Racoes) cereais[r] * x[r] <= disponibilidadeCereais;
//}

