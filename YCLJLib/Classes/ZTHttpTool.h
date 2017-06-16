
#import <Foundation/Foundation.h>
@class UploadParamModel;

@interface ZTHttpTool : NSObject

+ (void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(void (^)(id json))success
    failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(void (^)(id json))success
     failure:(void (^)(NSError *error))failure;

+ (void)upload:(NSString *)URLString
    parameters:(id)parameters
   uploadParam:(UploadParamModel *)uploadParam
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure;

@end
