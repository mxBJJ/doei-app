//
//  PostViewModel.swift
//  doei-app
//
//  Created by Max Mendes on 13/04/21.
//

import Foundation

class PostViewModel {
    
    var dataSource:[Post] = []
    
    func getPosts() {
        
        var post1 = Post()
        post1._id = "1"
        post1.title = "Super Nintendo"
        post1.state = "Regular"
        post1.giverAdress = "Rua Teste 500 - Bairro Teste"
        post1.imgUrl = "https://http2.mlstatic.com/D_NQ_NP_924498-MLA32736049530_112019-O.jpg"
        
        var post2 = Post()
        post2._id = "2"
        post2.title = "Colchão Solteiro"
        post2.state = "Regular"
        post2.giverAdress = "Rua Teste 500 - Bairro Teste"
        post2.imgUrl = "https://americanflex.vteximg.com.br/arquivos/ids/159619-1000-1000/AX-Olive-Espuma_Colchao-Solteiro.jpg?v=636868945129800000"
        
        self.dataSource.append(post1)
        self.dataSource.append(post2)
        self.dataSource.append(post1)
        self.dataSource.append(post2)
        self.dataSource.append(post2)
        self.dataSource.append(post2)
    }
    
    func dataSourceSize() -> Int {
        return dataSource.count
    }
}
