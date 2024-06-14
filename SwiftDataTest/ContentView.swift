import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var assignments: [AssignmentModel]
    
    @State private var isPresentingAddAssignment = false
    @State private var isPresentingEditAssignment = false
    @State private var assignmentToEdit: AssignmentModel?
    
    var body: some View {
        VStack {
            List {
                ForEach(assignments) { assignment in
                    VStack(alignment: .leading) {
                        Text(assignment.name)
                            .font(.headline)
                        Text(assignment.subject)
                            .font(.subheadline)
                        Text("Data de Entrega: \(assignment.dateExpiration.formatted())")
                            .font(.caption)
                        Text("Nota: \(assignment.score)")
                            .font(.caption)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            deleteAssignment(assignment)
                        } label: {
                            Label("Deletar", systemImage: "trash")
                        }
                        Button {
                            assignmentToEdit = assignment
                            isPresentingEditAssignment = true
                        } label: {
                            Label("Editar", systemImage: "pencil")
                        }
                    }
                }
            }
            
            Button(action: {
                isPresentingAddAssignment = true
            }) {
                Text("Adicionar Atividade")
            }
            .padding()
        }
        .padding()
        .sheet(isPresented: $isPresentingAddAssignment) {
            AddAssignmentView(isPresenting: $isPresentingAddAssignment)
                .environment(\.modelContext, modelContext)
        }
    }
    
    func deleteAssignment(_ assignment: AssignmentModel) {
        withAnimation {
            modelContext.delete(assignment)
        }
    }
}

struct AddAssignmentView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresenting: Bool

    @State private var name: String = ""
    @State private var subject: String = ""
    @State private var dateExpiration: Date = Date()
    @State private var score: Int = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Detalhes da Atividade")) {
                    TextField("Nome", text: $name)
                    TextField("Materia", text: $subject)
                    DatePicker("Data de Entrega", selection: $dateExpiration, displayedComponents: .date)
                    Stepper("Nota: \(score)", value: $score, in: 0...100)
                }
            }
            .navigationBarTitle("Adicionar Atividade", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancelar") {
                    isPresenting = false
                },
                trailing: Button("Salvar") {
                    addAssignment()
                    isPresenting = false
                }
                .disabled(name.isEmpty || subject.isEmpty)
            )
        }
    }
    
    func addAssignment() {
        withAnimation {
            let newAssignment = AssignmentModel(
                name: name,
                subject: subject,
                dateExpiration: dateExpiration,
                score: score
            )
            
            modelContext.insert(newAssignment)
        }
    }
    
    func editAssignment(_ assignment: AssignmentModel) {
            withAnimation {
                assignment.name = name
                assignment.subject = subject
                assignment.dateExpiration = dateExpiration
                assignment.score = score
            }
        }
}

#Preview {
    ContentView()
        .modelContainer(for: [AssignmentModel.self])
}
