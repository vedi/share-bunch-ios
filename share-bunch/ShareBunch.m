//
// Created by Shubin Fedor on 13/10/14.
//

#import "ShareBunch.h"

#import <UIKit/UIKit.h>
#import "ProcessorEngine.h"

@implementation ShareBunch {
}

+ (id)sharedInstance {
    static ShareBunch *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self alloc];
    });
    return sharedInstance;
}

+ (void)initialize {
    [super initialize];
    [self initGlue];
}

+ (void)registerProcessorForKey:(NSString *)key withBlock:(void (^)(NSDictionary *parameters, NSMutableDictionary *retParameters))callHandler {
    [[ProcessorEngine sharedInstance] registerProcessorForBunch:@"ShareBunch" andKey:key withBlock:callHandler];
}

+ (void)initGlue {
    
    [self registerProcessorForKey:@"shareText" withBlock:^(NSDictionary *parameters, NSMutableDictionary *retParameters) {
        NSString *text = parameters[@"text"];
        [[ShareBunch sharedInstance] shareText:text];
    }];
}

- (void)shareText:(NSString *)text {
    
    NSArray *postItems = @[text];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                            initWithActivityItems:postItems
                                            applicationActivities:nil];
    
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:activityVC animated:YES completion:nil];
}


@end