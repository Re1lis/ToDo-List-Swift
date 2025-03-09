import SwiftUI

struct ModalWindow: View {
    @Binding var isVisibleForm: Bool
    var backgroundColor: Color
    var textColor: Color
    @Binding var noteText: String
    @Binding var arrayNote: [String]
    @State private var maxCount: Int = 255
    @Binding var blackOrWhiteBorder: Color
    
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()

            VStack() {
                HStack {
                    Text("Заполните форму")
                        .font(.largeTitle)
                        .padding(.vertical, 10)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Button {
                        isVisibleForm.toggle()
                    } label : {
                        Image(systemName: "multiply")
                            .frame(maxWidth: 10, alignment: .trailing)
                    }
                }
                                .frame(maxWidth: .infinity)
                
                if noteText.count == 0 {
                    Text("Опишите свою заметку")
                        .font(.title2)
                        .padding(.top, 20)
                } else {
                    HStack{
                        Text("Ввели символов: \(noteText.count)")
                            .font(.title3)
                            .padding(.top, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Button {
                            noteText=""
                        } label : {
                            Image(systemName: "multiply")
                                .frame(maxWidth: 10, alignment: .trailing)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                
                TextEditor(text: $noteText)
                    .frame(maxWidth: .infinity, maxHeight: 400)
                    .padding(8)
                    .scrollContentBackground(.hidden)
                    .overlay{
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(textColor), lineWidth: 1)
                    }
                    .foregroundColor(textColor)
                Text("Первые несколько слов будут использоваться как название для вашей заметки")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(textColor)
                    .padding(.bottom, 20)

                Spacer()
                    
                
                if !noteText.isEmpty {
                    Button("Добавить заметку"){
                        isVisibleForm.toggle()
                        arrayNote.append(noteText)
                        noteText = ""
                    }
                    .font(.custom("text", size: 20))
                    .padding(7)
                    .disabled(false)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(style: StrokeStyle(lineWidth: 2))
                    }
                    .padding(.bottom, 50)
                } else if noteText.isEmpty {
                    Button("Добавить заметку"){
                        
                    }
                    .font(.custom("text", size: 20))
                    .padding(7)
                    .disabled(true)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(style: StrokeStyle(lineWidth: 2))
                    }
                    .opacity(0.7)
                    .padding(.bottom, 50)
                }
                
                    
                
                
            }
            
            .padding(.horizontal, 20)
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity)
            
        }
        .ignoresSafeArea()
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        

    }
}
