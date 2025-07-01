import XCTest
@testable import ProjetoLogicaSwift

final class ProjetoLogicaSwiftTests: XCTestCase {
    
    
    func testTarefaCriacaoComPrioridadeBaixa() {
        // Given
        let descricao = "Estudar Swift"
        let prioridade = 1
        
        // When
        let tarefa = Tarefa(descricao: descricao, prioridade: prioridade)
        
        // Then
        XCTAssertEqual(tarefa.descricao, "Estudar Swift")
        XCTAssertEqual(tarefa.prioridade, 1)
        XCTAssertEqual(tarefa.descricaoCompleta, "🟢 Estudar Swift")
    }
    
    func testTarefaCriacaoComPrioridadeMedia() {
        // Given
        let descricao = "Fazer exercícios"
        let prioridade = 2
        
        // When
        let tarefa = Tarefa(descricao: descricao, prioridade: prioridade)
        
        // Then
        XCTAssertEqual(tarefa.descricao, "Fazer exercícios")
        XCTAssertEqual(tarefa.prioridade, 2)
        XCTAssertEqual(tarefa.descricaoCompleta, "🟡 Fazer exercícios")
    }
    
    func testTarefaCriacaoComPrioridadeAlta() {
        // Given
        let descricao = "Entregar projeto"
        let prioridade = 3
        
        // When
        let tarefa = Tarefa(descricao: descricao, prioridade: prioridade)
        
        // Then
        XCTAssertEqual(tarefa.descricao, "Entregar projeto")
        XCTAssertEqual(tarefa.prioridade, 3)
        XCTAssertEqual(tarefa.descricaoCompleta, "🔴 Entregar projeto")
    }
    
    func testTarefaCriacaoComPrioridadeInvalida() {
        // Given
        let descricao = "Tarefa inválida"
        let prioridade = 5
        
        // When
        let tarefa = Tarefa(descricao: descricao, prioridade: prioridade)
        
        // Then
        XCTAssertEqual(tarefa.descricao, "Tarefa inválida")
        XCTAssertEqual(tarefa.prioridade, 5)
        XCTAssertEqual(tarefa.descricaoCompleta, "❓ Tarefa inválida")
    }
    
    // MARK: - Testes da função obterDescricaoPrioridade
    
    func testObterDescricaoPrioridadeBaixa() {
        // When
        let resultado = obterDescricaoPrioridade(1)
        
        // Then
        XCTAssertEqual(resultado, "🟢 Baixa")
    }
    
    func testObterDescricaoPrioridadeMedia() {
        // When
        let resultado = obterDescricaoPrioridade(2)
        
        // Then
        XCTAssertEqual(resultado, "🟡 Média")
    }
    
    func testObterDescricaoPrioridadeAlta() {
        // When
        let resultado = obterDescricaoPrioridade(3)
        
        // Then
        XCTAssertEqual(resultado, "🔴 Alta")
    }
    
    func testObterDescricaoPrioridadeInvalida() {
        // When
        let resultado1 = obterDescricaoPrioridade(0)
        let resultado2 = obterDescricaoPrioridade(4)
        let resultado3 = obterDescricaoPrioridade(-1)
        
        // Then
        XCTAssertEqual(resultado1, "❓ Indefinida")
        XCTAssertEqual(resultado2, "❓ Indefinida")
        XCTAssertEqual(resultado3, "❓ Indefinida")
    }
    
    // MARK: - Testes da função obterEmojiPrioridade
    
    func testObterEmojiPrioridadeBaixa() {
        // When
        let resultado = obterEmojiPrioridade(1)
        
        // Then
        XCTAssertEqual(resultado, "🟢")
    }
    
    func testObterEmojiPrioridadeMedia() {
        // When
        let resultado = obterEmojiPrioridade(2)
        
        // Then
        XCTAssertEqual(resultado, "🟡")
    }
    
    func testObterEmojiPrioridadeAlta() {
        // When
        let resultado = obterEmojiPrioridade(3)
        
        // Then
        XCTAssertEqual(resultado, "🔴")
    }
    
    func testObterEmojiPrioridadeInvalida() {
        // When
        let resultado1 = obterEmojiPrioridade(0)
        let resultado2 = obterEmojiPrioridade(4)
        let resultado3 = obterEmojiPrioridade(-1)
        
        // Then
        XCTAssertEqual(resultado1, "❓")
        XCTAssertEqual(resultado2, "❓")
        XCTAssertEqual(resultado3, "❓")
    }
    
    // MARK: - Testes de integração com arrays de tarefas
    
    func testOrdenacaoTarefasPorPrioridade() {
        // Given
        let tarefas = [
            Tarefa(descricao: "Tarefa baixa", prioridade: 1),
            Tarefa(descricao: "Tarefa alta", prioridade: 3),
            Tarefa(descricao: "Tarefa média", prioridade: 2)
        ]
        
        // When
        let tarefasOrdenadas = tarefas.sorted { $0.prioridade > $1.prioridade }
        
        // Then
        XCTAssertEqual(tarefasOrdenadas[0].prioridade, 3)
        XCTAssertEqual(tarefasOrdenadas[0].descricao, "Tarefa alta")
        XCTAssertEqual(tarefasOrdenadas[1].prioridade, 2)
        XCTAssertEqual(tarefasOrdenadas[1].descricao, "Tarefa média")
        XCTAssertEqual(tarefasOrdenadas[2].prioridade, 1)
        XCTAssertEqual(tarefasOrdenadas[2].descricao, "Tarefa baixa")
    }
    
    func testArrayTarefasVazio() {
        // Given
        let tarefas: [Tarefa] = []
        
        // When & Then
        XCTAssertTrue(tarefas.isEmpty)
        XCTAssertEqual(tarefas.count, 0)
    }
    
    func testAdicionarTarefaEmArray() {
        // Given
        var tarefas: [Tarefa] = []
        let novaTarefa = Tarefa(descricao: "Nova tarefa", prioridade: 2)
        
        // When
        tarefas.append(novaTarefa)
        
        // Then
        XCTAssertEqual(tarefas.count, 1)
        XCTAssertEqual(tarefas[0].descricao, "Nova tarefa")
        XCTAssertEqual(tarefas[0].prioridade, 2)
    }
    
    func testRemoverTarefaDeArray() {
        // Given
        var tarefas = [
            Tarefa(descricao: "Tarefa 1", prioridade: 1),
            Tarefa(descricao: "Tarefa 2", prioridade: 2)
        ]
        
        // When
        let tarefaRemovida = tarefas.remove(at: 0)
        
        // Then
        XCTAssertEqual(tarefas.count, 1)
        XCTAssertEqual(tarefaRemovida.descricao, "Tarefa 1")
        XCTAssertEqual(tarefas[0].descricao, "Tarefa 2")
    }
    
    func testEditarTarefaEmArray() {
        // Given
        var tarefas = [
            Tarefa(descricao: "Tarefa original", prioridade: 1)
        ]
        
        // When
        let novaTarefa = Tarefa(descricao: "Tarefa editada", prioridade: 3)
        tarefas[0] = novaTarefa
        
        // Then
        XCTAssertEqual(tarefas.count, 1)
        XCTAssertEqual(tarefas[0].descricao, "Tarefa editada")
        XCTAssertEqual(tarefas[0].prioridade, 3)
        XCTAssertEqual(tarefas[0].descricaoCompleta, "🔴 Tarefa editada")
    }
    
    // MARK: - Testes de validação
    
    func testValidacaoDescricaoTarefa() {
        // Given
        let descricaoVazia = ""
        let descricaoValida = "Tarefa válida"
        let descricaoMuitoLonga = String(repeating: "a", count: 201)
        
        // When & Then
        XCTAssertTrue(descricaoVazia.isEmpty)
        XCTAssertFalse(descricaoValida.isEmpty)
        XCTAssertTrue(descricaoValida.count <= 200)
        XCTAssertTrue(descricaoMuitoLonga.count > 200)
    }
    
    func testValidacaoPrioridade() {
        // Given
        let prioridadesValidas = [1, 2, 3]
        let prioridadesInvalidas = [0, 4, -1, 100]
        
        // When & Then
        for prioridade in prioridadesValidas {
            XCTAssertTrue(prioridade >= 1 && prioridade <= 3, "Prioridade \(prioridade) deveria ser válida")
        }
        
        for prioridade in prioridadesInvalidas {
            XCTAssertFalse(prioridade >= 1 && prioridade <= 3, "Prioridade \(prioridade) deveria ser inválida")
        }
    }
    
    // MARK: - Testes de performance
    
    func testPerformanceOrdenacaoTarefas() {
        // Given
        var tarefas: [Tarefa] = []
        for i in 1...1000 {
            let prioridade = (i % 3) + 1
            tarefas.append(Tarefa(descricao: "Tarefa \(i)", prioridade: prioridade))
        }
        
        // When & Then
        measure {
            let _ = tarefas.sorted { $0.prioridade > $1.prioridade }
        }
    }
}
