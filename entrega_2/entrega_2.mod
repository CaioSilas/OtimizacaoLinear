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
//// Declaração de variáveis
//
//dvar float+ x[Pilhas];
//
//// Declaração da função objetivo
//minimize
//  	sum(i in Pilhas)
//  	  	c[i]*x[i];
//  	  	
//// Restrições
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
//  	// Quantidade disponível nas pilhas
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
//// Par�metros
//float tij[Pilhas][Parametros]; // % do par�metro de controle j em uma tonelada da pilha i
//float tlj[Parametros];         // % m�nimo admiss�vel para o par�metro j
//float tuj[Parametros];         // % m�ximo admiss�vel para o par�metro j
//float Qui[Pilhas];             // Quantidade m�xima de min�rio na pilha i
//float p;                       // Quantidade em toneladas da mistura a ser formada
//float wnej[Parametros];        // Peso para o desvio negativo de especifica��o do par�metro j
//float wpej[Parametros];        // Peso para o desvio positivo de especifica��o do par�metro j
//
//// Vari�veis de decis�o
//dvar float+ xi[Pilhas];        // Quantidade de min�rio a ser retirado da pilha i
//dvar float+ dnej[Parametros];  // Desvio negativo de especifica��o do par�metro j
//dvar float+ dpej[Parametros];  // Desvio positivo de especifica��o do par�metro j
//
//// Fun��o objetivo
//minimize 
//  sum(j in Parametros) (wpej[j] * dpej[j] + wnej[j] * dnej[j]);
//
//// Restri��es
//subject to {
//  // Quantidade do par�metro j na mistura n�o pode superar a quantidade m�xima permitida em dpej toneladas
//  forall(j in Parametros)
//    sum(i in Pilhas) (tij[i][j] - tuj[j]) * xi[i] - dpej[j] <= 0;
//
//  // Quantidade do par�metro j na mistura n�o pode ser inferior � quantidade m�nima permitida em dnej toneladas
//  forall(j in Parametros)
//    sum(i in Pilhas) (tij[i][j] - tlj[j]) * xi[i] + dnej[j] >= 0;
//
//  // Quantidade a ser retirada de cada pilha i est� limitada a Qui
//  forall(i in Pilhas)
//    xi[i] <= Qui[i];
//
//  // A mistura deve ter peso total p
//  sum(i in Pilhas) xi[i] == p;
//
//  // N�o negatividade
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

// Par�metros
float tij[Pilhas][Parametros]; // % do par�metro de controle j em uma tonelada da pilha i
float tlj[Parametros];         // % m�nimo admiss�vel para o par�metro j
float trj[Parametros];         // % recomend�vel para o par�metro j
float tuj[Parametros];         // % m�ximo admiss�vel para o par�metro j
float Qui[Pilhas];             // Quantidade m�xima de min�rio na pilha i
float p;                       // Quantidade em toneladas da mistura a ser formada
float wnmj[Parametros];        // Peso para o desvio negativo da meta (recomend�vel) do par�metro j
float wpmj[Parametros];        // Peso para o desvio positivo da meta (recomend�vel) do par�metro j
float wnej[Parametros];        // Peso para o desvio negativo de especifica��o do par�metro j
float wpej[Parametros];        // Peso para o desvio positivo de especifica��o do par�metro j

// Vari�veis de decis�o
dvar float+ xi[Pilhas];        // Quantidade de min�rio a ser retirada da pilha i
dvar float+ dnmj[Parametros];  // Desvio negativo da meta (recomend�vel) do par�metro j
dvar float+ dpmj[Parametros];  // Desvio positivo da meta (recomend�vel) do par�metro j
dvar float+ dnej[Parametros];  // Desvio negativo de especifica��o do par�metro j
dvar float+ dpej[Parametros];  // Desvio positivo de especifica��o do par�metro j

// Fun��o objetivo: minimizar os desvios
minimize 
  sum(j in Parametros) (wpej[j] * dpej[j] + wnej[j] * dnej[j]) +
  sum(j in Parametros) (wpmj[j] * dpmj[j] + wnmj[j] * dnmj[j]);

// Restri��es
subject to {
  // Restri��es relaxadas para atendimento �s metas de qualidade
  forall(j in Parametros)
    sum(i in Pilhas) (tij[i][j] - trj[j]) * xi[i] + dnmj[j] - dpmj[j] == 0;

  // Quantidade do par�metro j na mistura n�o pode superar a quantidade m�xima permitida em dpej toneladas
  forall(j in Parametros)
    sum(i in Pilhas) (tij[i][j] - tuj[j]) * xi[i] - dpej[j] <= 0;

  // Quantidade do par�metro j na mistura n�o pode ser inferior � quantidade m�nima permitida em dnej toneladas
  forall(j in Parametros)
    sum(i in Pilhas) (tij[i][j] - tlj[j]) * xi[i] + dnej[j] >= 0;

  // Quantidade a ser retirada de cada pilha i est� limitada a Qui
  forall(i in Pilhas)
    xi[i] <= Qui[i];

  // A mistura deve ter peso total p
  sum(i in Pilhas) xi[i] == p;

  // N�o negatividade
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

