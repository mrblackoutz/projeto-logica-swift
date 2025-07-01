// https://github.com/mrblackoutz/projeto-logica-swift

import Foundation

struct Tarefa {
    let descricao: String
    let prioridade: Int
    
    var descricaoCompleta: String {
        return "\(obterEmojiPrioridade(prioridade)) \(descricao)"
    }
}

let artAscii = """
 __         __     ______     ______   ______        _____     ______   
/\\ \\       /\\ \\   /\\  ___\\   /\\__  _\\ /\\  __ \\      /\\  __-.  /\\  ___\\  
\\ \\ \\____  \\ \\ \\  \\ \\___  \\  \\/_/\\ \\/ \\ \\  __ \\     \\ \\ \\/\\ \\ \\ \\  __\\  
 \\ \\_____\\  \\ \\_\\  \\/\\_____\\    \\ \\_\\  \\ \\_\\ \\_\\     \\ \\____-  \\ \\_____\\
  \\/_____/   \\/_/   \\/_____/     \\/_/   \\/_/\\/_/      \\/____/   \\/_____/
                                                                        
 ______   ______     ______     ______     ______   ______     ______   
/\\__  _\\ /\\  __ \\   /\\  == \\   /\\  ___\\   /\\  ___\\ /\\  __ \\   /\\  ___\\  
\\/_/\\ \\/ \\ \\  __ \\  \\ \\  __<   \\ \\  __\\   \\ \\  __\\ \\ \\  __ \\  \\ \\___  \\ 
   \\ \\_\\  \\ \\_\\ \\_\\  \\ \\_\\ \\_\\  \\ \\_____\\  \\ \\_\\    \\ \\_\\ \\_\\  \\/\\_____\\
    \\/_/   \\/_/\\/_/   \\/_/ /_/   \\/_____/   \\/_/     \\/_/\\/_/   \\/_____/
"""

func lerEntrada() -> String? {
    guard let entrada = readLine() else {
        print("\n⚠️  Entrada interrompida. Encerrando programa...")
        exit(0)
    }
    return entrada.trimmingCharacters(in: .whitespacesAndNewlines)
}

func lerOpcao() -> Int? {
    guard let entrada = lerEntrada(), !entrada.isEmpty else {
        return nil
    }
    return Int(entrada)
}

func lerTexto(mensagem: String) -> String? {
    print(mensagem, terminator: " ")
    guard let texto = lerEntrada(), !texto.isEmpty else {
        return nil
    }
    return texto
}

func pausar() {
    print("\nPressione Enter para continuar...")
    _ = lerEntrada()
}

func exibirMenu() {
    print("\n" + "==============================")
    print(artAscii)
    print("==============================")
    print("1 - Listar tarefas")
    print("2 - Adicionar tarefa")
    print("3 - Remover tarefa")
    print("4 - Editar tarefa")
    print("0 - Sair")
    print("==============================")
    print("Escolha uma opção:", terminator: " ")
}

func obterDescricaoPrioridade(_ prioridade: Int) -> String {
    switch prioridade {
    case 1:
        return "🟢 Baixa"
    case 2:
        return "🟡 Média"
    case 3:
        return "🔴 Alta"
    default:
        return "❓ Indefinida"
    }
}

func obterEmojiPrioridade(_ prioridade: Int) -> String {
    switch prioridade {
    case 1:
        return "🟢"
    case 2:
        return "🟡"
    case 3:
        return "🔴"
    default:
        return "❓"
    }
}

func lerPrioridade() -> Int? {
    print("\nEscolha a prioridade:")
    print("1 - \(obterDescricaoPrioridade(1))")
    print("2 - \(obterDescricaoPrioridade(2))")
    print("3 - \(obterDescricaoPrioridade(3))")
    print("Prioridade (1-3):", terminator: " ")
    
    guard let opcao = lerOpcao(), opcao >= 1 && opcao <= 3 else {
        print("❌ Prioridade inválida! Escolha entre 1 e 3.")
        return nil
    }
    
    return opcao
}

func listarTarefas(_ tarefas: inout [Tarefa]) {
    guard !tarefas.isEmpty else {
        print("📝 Nenhuma tarefa encontrada!")
        print("💡 Use a opção 2 para adicionar uma nova tarefa.")
        pausar()
        return
    }
    
    print("\n" + "===================================")
    print("           📋 SUAS TAREFAS")
    print("===================================")
    
    // Ordenar por prioridade (alta -> baixa)
    let tarefasOrdenadas = tarefas.sorted { $0.prioridade > $1.prioridade }
    
    for (indice, tarefa) in tarefasOrdenadas.enumerated() {
        print("[\(indice + 1)] \(tarefa.descricaoCompleta)")
    }
    
    print("===================================")
    print("Total: \(tarefas.count) tarefa\(tarefas.count == 1 ? "" : "s")")
    pausar()
}

func adicionarTarefa(_ tarefas: inout [Tarefa]) {
    print("➕ ADICIONAR NOVA TAREFA\n")
    
    guard let novaDescricao = lerTexto(mensagem: "Digite a descrição da tarefa:") else {
        print("❌ Descrição inválida! A tarefa deve ter pelo menos 1 caractere.")
        pausar()
        return
    }
    
    guard novaDescricao.count <= 200 else {
        print("❌ Descrição muito longa! Máximo de 200 caracteres.")
        pausar()
        return
    }
    
    guard let prioridade = lerPrioridade() else {
        pausar()
        return
    }
    
    let novaTarefa = Tarefa(descricao: novaDescricao, prioridade: prioridade)
    tarefas.append(novaTarefa)
    print("✅ Tarefa '\(novaTarefa.descricaoCompleta)' adicionada com sucesso!")
    print("📊 Total de tarefas: \(tarefas.count)")
    pausar()
}

func removerTarefa(_ tarefas: inout [Tarefa]) {
    guard !tarefas.isEmpty else {
        print("❌ Não há tarefas para remover!")
        pausar()
        return
    }
    
    print("🗑️  REMOVER TAREFA\n")
    
    print("Tarefas disponíveis:")
    for (indice, tarefa) in tarefas.enumerated() {
        print("[\(indice + 1)] \(tarefa.descricaoCompleta)")
    }
    
    print("\nDigite o número da tarefa para remover (1-\(tarefas.count)):", terminator: " ")
    
    guard let opcao = lerOpcao() else {
        print("❌ Entrada inválida! Digite apenas números.")
        pausar()
        return
    }
    
    guard opcao >= 1 && opcao <= tarefas.count else {
        print("❌ Número inválido! Escolha entre 1 e \(tarefas.count).")
        pausar()
        return
    }
    
    let tarefaRemovida = tarefas.remove(at: opcao - 1)
    print("✅ Tarefa '\(tarefaRemovida.descricaoCompleta)' removida com sucesso!")
    print("📊 Total de tarefas: \(tarefas.count)")
    pausar()
}

func editarTarefa(_ tarefas: inout [Tarefa]) {
    guard !tarefas.isEmpty else {
        print("❌ Não há tarefas para editar!")
        pausar()
        return
    }
    
    print("✏️  EDITAR TAREFA\n")
    
    print("Tarefas disponíveis:")
    for (indice, tarefa) in tarefas.enumerated() {
        print("[\(indice + 1)] \(tarefa.descricaoCompleta)")
    }
    
    print("\nDigite o número da tarefa para editar (1-\(tarefas.count)):", terminator: " ")
    
    guard let opcao = lerOpcao() else {
        print("❌ Entrada inválida! Digite apenas números.")
        pausar()
        return
    }
    
    guard opcao >= 1 && opcao <= tarefas.count else {
        print("❌ Número inválido! Escolha entre 1 e \(tarefas.count).")
        pausar()
        return
    }
    
    let indice = opcao - 1
    let tarefaAtual = tarefas[indice]
    print("\nTarefa atual: '\(tarefaAtual.descricaoCompleta)'")
    
    guard let novaDescricao = lerTexto(mensagem: "Digite a nova descrição:") else {
        print("❌ Descrição inválida! A tarefa deve ter pelo menos 1 caractere.")
        pausar()
        return
    }
    
    guard novaDescricao.count <= 200 else {
        print("❌ Descrição muito longa! Máximo de 200 caracteres.")
        pausar()
        return
    }
    
    guard let novaPrioridade = lerPrioridade() else {
        pausar()
        return
    }
    
    let novaTarefa = Tarefa(descricao: novaDescricao, prioridade: novaPrioridade)
    tarefas[indice] = novaTarefa
    
    print("✅ Tarefa editada com sucesso!")
    print("📝 Antes: '\(tarefaAtual.descricaoCompleta)'")
    print("📝 Depois: '\(novaTarefa.descricaoCompleta)'")
    pausar()
}

func encerrarPrograma() {
    print("👋 Obrigado por usar o Sistema de Lista de Tarefas!")
    print("Até a próxima!")
    exit(0)
}

func executarSistema() {
    var tarefas: [Tarefa] = []
    
    print("🎉 Bem-vindo ao Sistema de Lista de Tarefas!")
    print("💡 Dica: Use Ctrl+C ou Ctrl+D para sair a qualquer momento.")
    
    while true {
        exibirMenu()
        
        guard let opcao = lerOpcao() else {
            print("❌ Opção inválida! Digite apenas números de 0 a 4.")
            pausar()
            continue
        }
        
        switch opcao {
        case 1:
            listarTarefas(&tarefas)
        case 2:
            adicionarTarefa(&tarefas)
        case 3:
            removerTarefa(&tarefas)
        case 4:
            editarTarefa(&tarefas)
        case 0:
            encerrarPrograma()
        default:
            print("❌ Opção inválida! Escolha uma opção de 0 a 4.")
            pausar()
        }
    }
}

@main
struct SistemaListaTarefas {
    static func main() {
        executarSistema()
    }
}