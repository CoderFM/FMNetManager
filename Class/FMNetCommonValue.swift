//
//  FMNetDownload.swift
//  SwiftSQLite
//
//  Created by 周发明 on 17/6/17.
//  Copyright © 2017年 周发明. All rights reserved.
//

import UIKit
// 网络请求完成的回调闭包

typealias FMNetCompleteHandle = (FMNetCompleteValue) -> ()

// 下载的监听
typealias FMNetDownloadProgressBlock = (Float) -> ()

struct FMNetDownload {
    public let downloadTask: URLSessionDownloadTask
    public let filePath : String
    public let identify: String
    public let progressBlock: FMNetDownloadProgressBlock
    public let completeHandle: FMNetCompleteHandle
}

// 上传的监听
typealias FMNetUploadProgressBlock = (Float) -> ()


struct FMNetUpload {
    public var uploadTask: URLSessionUploadTask?
    public let progressBlock: FMNetUploadProgressBlock
    public let completeHandle: FMNetCompleteHandle
}

struct FMNetUploadPara {
    public let paraName: String
    public let fileName: String
    public let data: Data
    public let fileType: String
}

// 回调完成的错误
enum FMNetError {
    case systemError(Error)
    case customError(String)
}
// 回调的结果
enum FMNetCompleteValue {
    /*
     1. 正常的请求
     any 是请求返回的数据
     string 为nil
     2. 下载
     any 是下载的成功的路径
     string 是下载的唯一标识  就是url路劲
     
     */
    case success(Any,String?)
    case failure(FMNetError,String?)
    
    public func successValue() -> Any? {
        switch self {
        case let .success(any):
            return any
        default:
            return nil
        }
    }
    
    public func errorDoman() -> String {
        switch self {
        case .success(_, _):
            return ""
        case .failure(let error, _):
            switch error {
            case .systemError(let serror):
                return serror.localizedDescription
            case .customError(let cerror):
                return cerror
            }
        }
    }
    
}
