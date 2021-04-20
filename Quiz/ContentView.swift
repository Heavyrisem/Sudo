//
//  ContentView.swift
//  Quiz
//
//  Created by 표인수 on 2021/04/19.
//

import SwiftUI

struct ContentView: View {
    var Quiz: [String] = ["캐나다의 수도는?", "호주의 수도는?", "케냐의 수도는?", "스웨덴의 수도는?", "독일의 수도는?", "덕영고 코딩천재는?"]
    var Answer: [String] = ["오타와", "캔버라", "나이로비", "스톡홀롬", "베를린", "표인수"]
    @State var DisplayQuiz: String = ""
    @State var UserAnswer: String = ""
    @State var CurrentNumber: Int = 0; // 현재 문제 번호를 저장
    @State var Score = 0;
    @State var WrongAnswer = false;
    @State var GameEnd = false;
    
    var body: some View {
        NavigationView{
            Form{
                Section {
                    Text("\(Quiz[self.CurrentNumber])")
                    TextField("Answer", text: $UserAnswer).alert(isPresented: $GameEnd) {
                        Alert(title: Text("\(Score)개"), message: Text("맞췄습니다"), dismissButton: .default(Text("확인")))
                    }
                    Button("입력") {
                        self.CheckAnswer()
                    }.alert(isPresented: $WrongAnswer) {
                        Alert(title: Text("땡"), message: Text("틀렸습니다"), dismissButton: .default(Text("확인")))
                    }
                }
                Button("다음"){ // 문제 스킵
                    if (self.CurrentNumber+1 >= self.Quiz.count) {
                        self.GameEnd = true;
                        self.CurrentNumber = 0;
                    } else {
                        self.CurrentNumber+=1
                    }
                    self.UserAnswer = "";
                }
            }.navigationBarTitle("수도 맞추기 퀴즈")
        }
    }
    
    func CheckAnswer() { // 정답 확인
        if (self.UserAnswer == Answer[self.CurrentNumber]) {
            self.Score+=1
            if (self.CurrentNumber+1 >= self.Quiz.count) { // 현재 번호가 배열의 값과 같거나 클때, 게임 종료
                self.GameEnd = true;
                self.CurrentNumber = 0;
            } else {
                self.CurrentNumber+=1 // 다음 문제로 넘어가기
            }
        } else {
            self.WrongAnswer = true
        }
        self.UserAnswer = "";
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
