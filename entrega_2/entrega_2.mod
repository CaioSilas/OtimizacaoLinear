/*********************************************
 * OPL 20.1.0.0 Model
 * Author: silas
 * Creation Date: 4 de ago de 2024 at 11:52:40
 *********************************************/
//// Declarando meus conjuntos
//{string} Pilhas=...;
//{string} Parametros=...;
//// Declarando os dados de entrada dependentes dos conjuntos
//float t[Pilhas][Parametros]=...;
//float tl[Parametros]=...;
//float tu[Parametros]=...;
//
//float Qu[Pilhas]=...;
//
//float c[Pilhas]=...;
//
//float p=...;
//
//// DeclaraÃ§Ã£o de variÃ¡veis
//
//dvar float+ x[Pilhas];
//
//// DeclaraÃ§Ã£o da funÃ§Ã£o objetivo
//minimize
//  	sum(i in Pilhas)
//  	  	c[i]*x[i];
//  	  	
//// RestriÃ§Ãµes
//subject to
//{
//	//limite max permitido para cada parametro
//		forall(j in Parametros)
//		  LimMax:
//			  sum(i in Pilhas)
//			    (t[i][j]-tu[j])*x[i] <= 0;
//	//limite min permitido para cada parametro
//  		forall(j in Parametros)
//		  	LimMin:
//	  		  	sum(i in Pilhas)
//	  		  	  (t[i][j] - tl[j])*x[i] >= 0;
//	  		  	  
//  	// Quantidade disponÃ­vel nas pilhas
//  	forall(i in Pilhas)
//  	  DispPilhas:
//  		  x[i] <= Qu[i];
//  		 
//  	PesoTotal:
//  		sum(i in Pilhas)
//  		  x[i] == p; 	 	
//  	
//}  

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//// Conjuntos
//{string} Pilhas = ...;
//{string} Parametros = ...;
//
//// Parâmetros
//float tij[Pilhas][Parametros]; // % do parâmetro de controle j em uma tonelada da pilha i
//float tlj[Parametros];         // % mínimo admissível para o parâmetro j
//float tuj[Parametros];         // % máximo admissível para o parâmetro j
//float Qui[Pilhas];             // Quantidade máxima de minério na pilha i
//float p;                       // Quantidade em toneladas da mistura a ser formada
//float wnej[Parametros];        // Peso para o desvio negativo de especificação do parâmetro j
//float wpej[Parametros];        // Peso para o desvio positivo de especificação do parâmetro j
//
//// Variáveis de decisão
//dvar float+ xi[Pilhas];        // Quantidade de minério a ser retirado da pilha i
//dvar float+ dnej[Parametros];  // Desvio negativo de especificação do parâmetro j
//dvar float+ dpej[Parametros];  // Desvio positivo de especificação do parâmetro j
//
//// Função objetivo
//minimize 
//  sum(j in Parametros) (wpej[j] * dpej[j] + wnej[j] * dnej[j]);
//
//// Restrições
//subject to {
//  // Quantidade do parâmetro j na mistura não pode superar a quantidade máxima permitida em dpej toneladas
//  forall(j in Parametros)
//    sum(i in Pilhas) (tij[i][j] - tuj[j]) * xi[i] - dpej[j] <= 0;
//
//  // Quantidade do parâmetro j na mistura não pode ser inferior à quantidade mínima permitida em dnej toneladas
//  forall(j in Parametros)
//    sum(i in Pilhas) (tij[i][j] - tlj[j]) * xi[i] + dnej[j] >= 0;
//
//  // Quantidade a ser retirada de cada pilha i está limitada a Qui
//  forall(i in Pilhas)
//    xi[i] <= Qui[i];
//
//  // A mistura deve ter peso total p
//  sum(i in Pilhas) xi[i] == p;
//
//  // Não negatividade
//  forall(i in Pilhas)
//    xi[i] >= 0;
//  
//  forall(j in Parametros)
//    dnej[j] >= 0;
//  
//  forall(j in Parametros)
//    dpej[j] >= 0;
//}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Conjuntos
{string} Pilhas = ...;
{string} Parametros = ...;

// Parâmetros
float tij[Pilhas][Parametros]; // % do parâmetro de controle j em uma tonelada da pilha i
float tlj[Parametros];         // % mínimo admissível para o parâmetro j
float trj[Parametros];         // % recomendável para o parâmetro j
float tuj[Parametros];         // % máximo admissível para o parâmetro j
float Qui[Pilhas];             // Quantidade máxima de minério na pilha i
float p;                       // Quantidade em toneladas da mistura a ser formada
float wnmj[Parametros];        // Peso para o desvio negativo da meta (recomendável) do parâmetro j
float wpmj[Parametros];        // Peso para o desvio positivo da meta (recomendável) do parâmetro j
float wnej[Parametros];        // Peso para o desvio negativo de especificação do parâmetro j
float wpej[Parametros];        // Peso para o desvio positivo de especificação do parâmetro j

// Variáveis de decisão
dvar float+ xi[Pilhas];        // Quantidade de minério a ser retirada da pilha i
dvar float+ dnmj[Parametros];  // Desvio negativo da meta (recomendável) do parâmetro j
dvar float+ dpmj[Parametros];  // Desvio positivo da meta (recomendável) do parâmetro j
dvar float+ dnej[Parametros];  // Desvio negativo de especificação do parâmetro j
dvar float+ dpej[Parametros];  // Desvio positivo de especificação do parâmetro j

// Função objetivo: minimizar os desvios
minimize 
  sum(j in Parametros) (wpej[j] * dpej[j] + wnej[j] * dnej[j]) +
  sum(j in Parametros) (wpmj[j] * dpmj[j] + wnmj[j] * dnmj[j]);

// Restrições
subject to {
  // Restrições relaxadas para atendimento às metas de qualidade
  forall(j in Parametros)
    sum(i in Pilhas) (tij[i][j] - trj[j]) * xi[i] + dnmj[j] - dpmj[j] == 0;

  // Quantidade do parâmetro j na mistura não pode superar a quantidade máxima permitida em dpej toneladas
  forall(j in Parametros)
    sum(i in Pilhas) (tij[i][j] - tuj[j]) * xi[i] - dpej[j] <= 0;

  // Quantidade do parâmetro j na mistura não pode ser inferior à quantidade mínima permitida em dnej toneladas
  forall(j in Parametros)
    sum(i in Pilhas) (tij[i][j] - tlj[j]) * xi[i] + dnej[j] >= 0;

  // Quantidade a ser retirada de cada pilha i está limitada a Qui
  forall(i in Pilhas)
    xi[i] <= Qui[i];

  // A mistura deve ter peso total p
  sum(i in Pilhas) xi[i] == p;

  // Não negatividade
  forall(i in Pilhas)
    xi[i] >= 0;
  
  forall(j in Parametros)
    dnmj[j] >= 0;
  
  forall(j in Parametros)
    dpmj[j] >= 0;
  
  forall(j in Parametros)
    dnej[j] >= 0;
  
  forall(j in Parametros)
    dpej[j] >= 0;
}

