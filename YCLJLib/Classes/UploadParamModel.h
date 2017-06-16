//
//  UploadParamModel.h
//  Pod
//
//  Created by Adam on 16/5/3.
//  Copyright © 2016年 fule. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadParamModel : NSObject

/**
 *  上传文件的二进制数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  上传的参数名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  上传到服务器的文件名称
 *  @"image.jpg";
 *  @"image.png";
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  上传文件的类型
 *  @"image/jpeg";
 *  @"image/png";
 */
@property (nonatomic, copy) NSString *mimeType;

@end
