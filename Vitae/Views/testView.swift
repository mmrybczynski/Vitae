import SwiftUI

// MARK: - Model


// MARK: - Komponent (osobny View)


// MARK: - Widok nadrzędny (dodawanie + zbieranie list)
struct EmploymentFormView: View {
    @State private var entries: [EmploymentEntry] = [EmploymentEntry()]

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    ForEach($entries) { $entry in
                        experienceAddView(entry: $entry)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                    }
                    .onDelete { indexSet in
                        entries.remove(atOffsets: indexSet)
                    }
                    .onMove { from, to in
                        entries.move(fromOffsets: from, toOffset: to)
                    }
                } header: {
                    Text("Experience")
                }
                


                Section("Aggregated lists (preview)") {
                    // Dla podglądu – w realnej aplikacji możesz to przekazać do VM / serwisu:
                    Text("employer: \(employers.joined(separator: ", "))")
                        .font(.footnote)
                    Text("position: \(positions.joined(separator: ", "))")
                        .font(.footnote)
                }
            }
            .navigationTitle("Employment")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        entries.append(EmploymentEntry())
                    } label: {
                        Label("Add", systemImage: "plus.circle.fill")
                    }
                    .accessibilityLabel("Add employment entry")
                }

                ToolbarItem(placement: .bottomBar) {
                    Button {
                        // Tu masz gotowe listy – użyj wedle potrzeb (np. wyślij do API):
                        print("Employers:", employers)
                        print("Positions:", positions)
                        print("StartDates:", startDates)
                        print("EndDates:", endDates as Any)
                        print("Descriptions:", jobDescriptions)
                    } label: {
                        Label("Collect lists", systemImage: "tray.and.arrow.up")
                    }
                }
            }
        }
    }

    // MARK: - Zbiór wymaganych list
    var employers: [String] { entries.map { $0.employer } }
    var positions: [String] { entries.map { $0.position } }
    var startDates: [Date] { entries.map { $0.startDate } }
    var endDates: [Date?] { entries.map { $0.isCurrent ? nil : $0.endDate } }
    var jobDescriptions: [String] { entries.map { $0.jobDescription } }
}

// MARK: - Podgląd
#Preview {
    EmploymentFormView()
}
