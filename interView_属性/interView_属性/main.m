//
//  main.m
//  interView_属性
//
//  Created by admin on 2020/12/21.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface Persion : NSObject
@property (copy,nonatomic) NSString *name;
@end

@implementation Persion
@synthesize name;

- (NSArray *)propertiesList {

    unsigned int count = 0;
    /**
     参数
     1. 类
     2. 成员变量的计数
     返回的是 C 语言的数组
    */
    Ivar *ivarsList = class_copyIvarList([self class],&count);
    //创建成员变量数组
    NSMutableArray *ivars = [NSMutableArray array];
    //遍历数组
    for (int i = 0; i < count; i++) {
        // 1. 根据下标获取成员变量
       Ivar ivar = ivarsList[i];
        // 2. 获取成员变量的名称
       const char*cName = ivar_getName(ivar);
        // 3. 转换成 NSString
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        NSLog(@"%@",name);
       [ivars addObject:name];
    }

    //释放对象 free

    free(ivarsList);//-->用到coppy,creat,retain记得free/realease

   return ivars.copy;

}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        Persion *persion = [[Persion alloc] init];
        
        NSArray *ivarList = [persion propertiesList];
//        NSLog(ivarList);
        
        
    }
    return 0;
}
