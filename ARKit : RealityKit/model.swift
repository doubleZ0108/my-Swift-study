//
//  model.swift
//  my-ARKit-study
//
//  Created by doubleZ on 2023/1/31.
//

import UIKit
import RealityKit
import Combine

// 异步加载模型
class Model {
    var modelName: String
    var image: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        self.image = UIImage(named: modelName)!
        
        let filename = modelName + ".usdz"
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                // handle error
                print("DEBUG: unable to load modelEntity for \(self.modelName)")
            }, receiveValue: { modelEntity in
                self.modelEntity = modelEntity
                print("DEBUG: success to load modelEntity for \(self.modelName)")
            })
    }
}
