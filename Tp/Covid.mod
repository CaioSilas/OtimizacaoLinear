# Definição dos conjuntos
set E := 1..23;  # Conjunto de Funcionários
set A := 1..4;  # Conjunto de Setores
set S := 1..3;  # Conjunto de Turnos
set W := 1..2; # Conjunto de Semanas
# Parâmetros
# Número máximo de horas de trabalho semanal por turno em cada setor
param lambda{s in S,a in A};

# Número mínimo de horas de trabalho semanal por turno em casa setor
param tau{s in S,a in A};

param hemax{E} default 30.00; #Número de horas contratadas

param cea{E, A} binary default 1;  # Parâmetro binário indicando se o funcionário pode ou não trabalhar em um setor


# Variáveis de decisão
var xsewa{E, A, S, W} binary;  # Variável binária de escalonamento
var ysewa{E, A, S, W} >= 0.00;   # Variável de horas trabalhadas
var delta_plus{E, W} >= 0.00;    # Excesso de horas trabalhadas
var delta_minus{E, W} >= 0.00;   # Sobra de horas trabalhadas

# Variáveis adicionais
var pos_diff{E, W} >= 0.00;  # Diferença positiva
var neg_diff{E, W} >= 0.00;  # Diferença negativa

minimize objective:
    sum {e in E, w in W} (pos_diff[e, w] + neg_diff[e, w]);

# Restrição relacionada às diferenças
subject to diff_constraint{e in E, w in W}:
    pos_diff[e, w] - neg_diff[e, w] = delta_plus[e, w] - delta_minus[e, w];



# Restrições adicionadas

# Um funcionário deve ser atribuído a apenas um turno e um setor na semana.
subject to selecao_horario_R4{e in E, w in W}:
    sum{a in A, s in {1,2}} xsewa[e, a, s, w] = 1;

subject to restricao_5 {a in A, s in {1,2}}:
    sum{e in {1,2}} xsewa[e, a, s, 1] = sum{e in {1,2}} xsewa[e, a, s, 2];

subject to restricao_6 {e in E, s in {1,2}}:
    sum{a in A, w in W} xsewa[e, a, s, w] = 1;

subject to restricao_7 {e in E}:
    xsewa[e, 1, 3, 1] <= xsewa[e, 1, 1, 1];

subject to restricao_8 {e in E, w in W, a in {2, 3, 4}}:
    xsewa[e, a, 3, w] = 0;

# Adicionando restrição para garantir que ysewa seja menor do que o máximo de horas permitido por funcionário (xsewa = 1)
subject to restricao_9 {e in E, w in W, a in A, s in S}:
    ysewa[e, a, s, w] <= lambda[s, a] * xsewa[e, a, s, w];

subject to restricao_10 {w in W, a in A, s in S}:
    sum{e in E} ysewa[e, a, s, w] >= tau[s, a];
    
subject to restricao_101 {w in W, a in A, s in S}:
    sum{e in E} ysewa[e, a, s, w] <= lambda[s, a];

subject to restricao_11 {e in E, w in W}:
    sum{a in A, s in S} ysewa[e, a, s, w] + delta_minus[e, w] - delta_plus[e, w] = hemax[e];

# Garantindo a compatibilidade de designar um funcionário para trabalhar em um setor
subject to restricao_12 {w in W, e in E, a in A, s in S}:
    xsewa[e, a, s, w] <= cea[e, a];
solve;

# Imprima o valor da função objetivo
printf "\nValor da Função Objetivo: %.2f\n", objective;

printf "\nValores das variáveis de decisão xsewa:\n";
for {e in E, a in A, s in S, w in W} {
    printf "xsewa[%d, %d, %d, %d] = %.2f\n", e, a, s, w, xsewa[e, a, s, w];
}

printf "\nValores das variáveis de decisão ysewa:\n";
for {e in E, a in A, s in S, w in W} {
    printf "ysewa[%d, %d, %d, %d] = %.2f\n", e, a, s, w, ysewa[e, a, s, w];
}

# Imprimir o número de funcionários em cada setor e turno
printf "\nNúmero de Funcionários em Cada Setor e Turno:\n";
for {a in A, s in S, w in W} {
    printf "Setor %d, Turno %d, Semana %d: %d funcionários\n", a, s, w, sum{e in E} xsewa[e, a, s, w];
}

# Imprimir o número de horas trabalhadas em cada setor e turno
printf "\nNúmero de Horas Trabalhadas em Cada Setor e Turno:\n";
for {a in A, s in S, w in W} {
    printf "Setor %d, Turno %d, Semana %d: %.2f horas\n", a, s, w, sum{e in E} ysewa[e, a, s, w];
}


end;
