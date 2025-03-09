import SwiftUI

struct ContentView: View {
    @AppStorage("ToggleTheme") private var ToggleTheme: String = "black"
    @AppStorage("isVisibleForm") private var isVisibleForm: Bool = false
    @State var ArrayNote: [String] = []
    @AppStorage("noteText") var noteText: String = ""
    @State var blackOrWhiteBorder: Color = .white
    @AppStorage("isVisibleMore") private var isVisibleMore: Bool = false
    @AppStorage("isVisibleFormDelete") private var isVisibleFormDelete: Bool = false
    @State private var noteExpanded: [String: Bool] = [:]
    @State private var noteDeleteVisible: [String: Bool] = [:]
    
    @AppStorage("savedArray") private var savedArray: String = ""

    private func saveArray() {
        savedArray = ArrayNote.joined(separator: ",")
    }
    
    private func loadArray() {
        ArrayNote = savedArray.split(separator: ",").map(String.init)
    }
    
    var textColor: Color {
        switch ToggleTheme {
        case "light": return .black
        case "black": return .white
        case "gray": return .white
        case "pink": return Color(red: 0.53, green: 0.05, blue: 0.31)
        case "brown": return .white
        case "beige": return .black
        case "blue": return .white
        default: return .primary
        }
    }
    
    var backgroundColor: Color {
        switch ToggleTheme {
        case "light": return .white
        case "black": return .black
        case "gray": return .gray
        case "pink": return .pink
        case "brown": return .brown
        case "beige": return Color(red: 0.96, green: 0.96, blue: 0.86)
        case "blue": return .blue
        default: return .white
        }
    }
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
                .animation(.easeInOut, value: ToggleTheme)
            VStack {
                HStack {
                    Text("ToDo List")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Menu {
                        Button("Светлая") {
                            withAnimation {
                                ToggleTheme = "light"
                            }
                        }
                        Button("Темная") {
                            withAnimation {
                                ToggleTheme = "black"
                            }
                        }
                        Button("Серая") {
                            withAnimation {
                                ToggleTheme = "gray"
                            }
                        }
                        Button("Розовая") {
                            withAnimation {
                                ToggleTheme = "pink"
                            }
                        }
                        Button("Коричневая") {
                            withAnimation {
                                ToggleTheme = "brown"
                            }
                        }
                        Button("Бежевая") {
                            withAnimation {
                                ToggleTheme = "beige"
                            }
                        }
                        Button("Голубая") {
                            withAnimation {
                                ToggleTheme = "blue"
                            }
                        }
                        
                    } label: {
                        HStack {
                            Text("Тема")
                            
                            switch ToggleTheme {
                            case "light":
                                Image(systemName: "sun.max")
                            case "black":
                                Image(systemName: "moon.fill")
                            case "gray":
                                Image(systemName: "cloud.fill")
                            case "pink":
                                Image(systemName: "heart.fill")
                            case "brown":
                                Image(systemName: "leaf.fill")
                            case "beige":
                                Image(systemName: "circle.grid.3x3.fill")
                            case "blue":
                                Image(systemName: "drop.fill")
                            default:
                                Image(systemName: "paintpalette")
                            }
                        }
                        .font(.headline)
                        .frame(maxWidth: 100, alignment: .trailing)
                    }
                    
                }
                .padding(.bottom, 5)
                
                Button("Добавить заметку") {
                    isVisibleForm.toggle()
                }
                .padding(10)
                .font(.headline)
                .background(Color.clear)
                .overlay {
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(style: StrokeStyle(lineWidth: 2))
                }
                .padding(.bottom, 30)
                
                Text("Список заметок")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fontWeight(.bold)
                
                ScrollView {
                    if ArrayNote.isEmpty {
                        Text("Заметки отсутствуют")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 250)
                            .frame(
                                maxWidth: .infinity,
                                maxHeight: .infinity,
                                alignment: .center
                            )
                    } else {
                        ForEach(ArrayNote, id: \.self) { note in
                            VStack {
                                HStack {
                                    Text(note)
                                        .font(.headline)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .lineLimit(1)
                                    
                                    HStack {
                                        Button {
                                            withAnimation {
                                                noteExpanded[note] = !(noteExpanded[note] ?? false)
                                                noteDeleteVisible[note] = false
                                            }
                                        } label: {
                                            Image(systemName: (noteExpanded[note] ?? false) ? "eye.fill" : "eye")
                                        }
                                        Button {
                                            withAnimation {
                                                noteExpanded[note] = false
                                                noteDeleteVisible[note] = true
                                            }
                                        } label: {
                                            if noteDeleteVisible[note] != true {
                                                Image(systemName: "arrow.up.trash")
                                                    .foregroundColor(.red)
                                            }
                                        }
                                    }
                                }
                                
                                if noteExpanded[note] ?? false {
                                    ScrollView {
                                        Text("Описание: \(note)")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.top, 5)
                                    }
                                    .frame(maxHeight: 150)
                                }
                                
                                if noteDeleteVisible[note] ?? false {
                                    Text("Вы точно хотите удалить заметку?")
                                    HStack {
                                        Button("Нет") {
                                            withAnimation {
                                                noteDeleteVisible[note] = false
                                            }
                                        }
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .padding(15)
                                        .frame(minHeight: 30)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .background(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(textColor, lineWidth: 1)
                                        )
                                        Button("Да") {
                                            withAnimation {
                                                ArrayNote.removeAll { $0 == note }
                                                noteExpanded.removeValue(forKey: note)
                                                noteDeleteVisible.removeValue(forKey: note)
                                            }
                                        }
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .padding(15)
                                        .frame(minHeight: 30)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .background(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(textColor, lineWidth: 1)
                                        )
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(textColor, lineWidth: 1)
                                    .fill(textColor.opacity(0.5))
                            )
                            .padding(3)
                        }
                    }
                }
                .sheet(isPresented: $isVisibleForm) {
                    ModalWindow(isVisibleForm: $isVisibleForm, backgroundColor: backgroundColor, textColor: textColor, noteText: $noteText, arrayNote: $ArrayNote, blackOrWhiteBorder: $blackOrWhiteBorder)
                }
                .onAppear {
                    loadArray()
                }
                .onChange(of: ArrayNote) { _ in
                    saveArray()
                }
            }
            .padding(.horizontal)
            .foregroundColor(textColor)
        }
    }
}

#Preview {
    ContentView()
}
