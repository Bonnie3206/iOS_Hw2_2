//
//  ContentView2.swift
//  iOS_Hw2_2
//
//  Created by CK on 2021/3/23.
//

import SwiftUI


//建立牌
//???????????
var users : [[Int]] = [[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]]
//%13餘數為rank 整除0 黑桃 1梅花 2 紅心 3菱形 /55 = back /5253

var card:[Int] = [0,1,2,3,4,5,6,7,8,9,10,11,12
                  ,13,14,15,16,17,18,19,20,21,22,23,24,25
                  ,26,27,28,29,30,31,32,33,34,35,36,37,38
                  ,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53]


//發牌
func licensing(){
    
    var index = 0
    for i in 0...2{
        for j in 0...17{
            users[i][j] = card[index]
            index += 1
        }
    }
}
//成對丟出
func clean(){
    var j = 0
    for i in 0...2{
        for j in 0...17{
            var k = 1
            while j+k < users[i].count {
                
                if users[i][j]%13 == users[i][j+k]%13{
                    
                    //print(users[i][j]%13)
                    //print(users[i][j+k]%13)
                    users[i].remove(at:j)
                    users[i].remove(at:j+k-1)
                    k = 1
                }
                else{
                    k+=1
                }
            }
        }
        
    }
    
}

struct ContentView2: View {
    @State var turns = 0
    @State var fights_0 = 01
    @State var fights_1 = 12
    @State var fights_2 = 20
    @State var winTheGame = false
    @State var loseTheGame = false
    @State var showFirstPage = false
    @State var money = 1500
    
    var body: some View {
        ZStack{
            Image("hw2背景")
                .opacity(0.6)
            VStack{
                VStack{
                    Image("錢")
                        .resizable()
                        .background(Color.white)
                        .frame(width: 70, height:70)
                        .scaledToFit()
                        .border(Color.black, width: 1)
                        .offset(x: -20, y: 0)
                        .padding(.trailing, -40)
                    Text("籌碼"+String(money))
                        
                }
                HStack{
                    
                    ForEach(0..<users[2].count, id: \.self)//myCard
                    {
                        index in
                        
                            Image("back")
                            .resizable()
                            .background(Color.white)
                            .frame(width: 70, height:70)
                            .scaledToFit()
                            .border(Color.black, width: 1)
                            .offset(x: index > 0 ? -20 : 0, y: 0)
                            .padding(.trailing, index > 0 ? -40 : 0)
                
                        
                    }
                }
                HStack{
                    
                    ForEach(0..<users[1].count, id: \.self)//myCard
                    {
                        index in
                        
                        Button(action:
                        {
                            if turns == 0{
                                
                                users[0].append(users[1][index])
                                users[1].remove(at:index)
                                
                                if  String(users[1].count) == "0" {
                                    loseTheGame = true
                                    money -= 2000
                                }else{
                                    clean()
                                }
                                if users[0].isEmpty{
                                    winTheGame = true
                                    money += 2000
                                }else{
                                    clean()
                                }
                                turns = 1
                                
                            }
                            if turns == 1{
                                var number = Int.random(in: 0...(users[2].count-1))
                                
                                users[1].append(users[2][number])
                                users[2].remove(at:number)
                                
                                if String(users[2].count) == "0" {
                                    loseTheGame = true
                                    money -= 2000
                                }else{
                                    clean()
                                }
                                if String(users[1].count) == "0" {
                                    loseTheGame = true
                                    money -= 2000
                                }
                                turns = 2
                                
                            }
                            if turns == 2{
                                var number = Int.random(in: 0...users[0].count-1)
            
                                users[2].append(users[0][number])
                                users[0].remove(at:number)
                                
                                if users[0].isEmpty{
                                    winTheGame = true
                                    money += 2000
                                }else{
                                    clean()
                                }
                                if  String(users[2].count) == "0" {
                                    loseTheGame = true
                                    money -= 2000
                                }
                                turns = 0
                            }
                            
                        }, label:
                        {
                            Image("back")
                            .resizable()
                            .background(Color.white)
                            .frame(width: 70, height:70)
                            .scaledToFit()
                            .border(Color.black, width: 1)
                            .offset(x: index > 0 ? -20 : 0, y: 0)
                            .padding(.trailing, index > 0 ? -40 : 0)
                        })
                        
                    }
                }
                HStack{
                    
                    ForEach(0..<users[0].count, id: \.self)//myCard
                    {
                        index in
                        Button(action:
                        {
                            
                            
                            
                        }, label:
                        {
                            Image(String(users[0][index]))
                            .resizable()
                            .background(Color.white)
                            .frame(width: 70, height:70)
                            .scaledToFit()
                            .border(Color.black, width: 1)
                            .offset(x: index > 0 ? -20 : 0, y: 0)
                            .padding(.trailing, index > 0 ? -40 : 0)
                        })
                        
                    }
                Button(action:
                {
                    if turns == 2{
                        turns = 0
                    }else{
                        turns += 1
                    }
                    if turns == 1{
                        var number = Int.random(in: 0...users[2].count-1)
                        users[1].append(users[2][number])
                        users[2].remove(at:number)
                        clean()
                    }
                    if turns == 2{
                        var number = Int.random(in: 0...users[0].count-1)
                        users[2].append(users[0][number])
                        users[0].remove(at:number)
                        clean()
                    }
                    
                }, label:
                {
                    Text("目前輪"+String(turns)+"換下一個")
                })
                }
                Button(action: {showFirstPage = true
                
                },label: {Text("回到首頁").font(.largeTitle)
                    
                })
                .sheet(isPresented: $showFirstPage, content:{
                    SwiftUIView()
                })
            }.onAppear(perform: {})
//???????EmptyView()
            EmptyView().sheet(isPresented: $winTheGame, content:{winGameView(winTheGame:$winTheGame)})
            EmptyView().sheet(isPresented: $loseTheGame, content:{loseGameView(loseTheGame:$loseTheGame)})
        }
        
        
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
