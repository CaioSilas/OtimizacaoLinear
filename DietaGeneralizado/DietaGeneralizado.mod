// Ler os valores da entrada

{string} I =...;
{string} V =...;

float P[I] = ...;
int Req[V] = ...;
float Qtd[V][I] = ...;

//Definir variáveis de decisão

	dvar float+ x[I];

//Definir a função Objetivo

	minimize //maximize
		sum(i in I) P[i]*x[i];


//Restrições
subject to
{
   // NOME_REST: escrevo a restrição
   /*VitaminaA: 
   		//1*x[1] + 0*x[2]+ 2*x[3] + 2*x[4] + 1*x[5] + 2*x[6] >= 9;
   		sum(i in I) Qtd["A"][i]*x[i] >= Req["A"];
   		
   VitaminaC:
   		//0*x[1] + 1* x[2] + 3*x[3] + 1*x[4] + 3*x[5] + 2*x[6] >= 19;
   		sum(i in I) Qtd["C"][i] * x[i] >= Req["C"];
   */
   //Vitaminas
   forall(v in V)
     Req_Vitamina:
     	sum(i in I) Qtd[v][i]* x[i] >= Req[v];
   		
/*   //Não-negatividade
   forall( i in I)
     	x[i] >= 0;
  */ 
  
}

