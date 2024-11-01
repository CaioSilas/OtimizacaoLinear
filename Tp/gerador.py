import random

# Função para gerar linhas com padrões de corte complexos
def generate_pattern(num_items):
    return [random.randint(0, 5) for _ in range(num_items)]

# Definições de parâmetros
num_patterns = 1500  # Número de padrões a serem gerados
num_items = 1000    # Número de itens por padrão

# Geração de 150 linhas com 100 itens cada
cuts = [generate_pattern(num_items) for _ in range(num_patterns)]

# Geração da demanda (números aleatórios entre 10 e 500)
demand = [random.randint(10, 1500) for _ in range(num_items)]

# Escrever a matriz de cortes e a demanda no arquivo .txt, formatado conforme solicitado
with open("exemplos.txt", "w") as file:
    # Escreve a demanda
    file.write("demand = [" + ", ".join(map(str, demand)) + "];\n\n")
    
    # Escreve os padrões de corte
    file.write("cuts = [\n")
    for pattern in cuts:
        file.write("    [" + ", ".join(map(str, pattern)) + "],\n")
    file.write("];\n")

# Exibir a mensagem de sucesso
print("Arquivo 'exemplos.txt' gerado com sucesso e formatado.")

