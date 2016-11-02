//
//  LFImageCodeView.h
//  LFCirlStatisView
//
//  Created by FFFF on 2016/11/2.
//  Copyright © 2016年 FFFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFGraphicCodeView : UIView
- (instancetype)initWithFrame:(CGRect)frame idCodeStr:(NSString *)codeStr;
@property (nonatomic,copy) void (^changeCodeStrDidClick)();
@property (nonatomic,copy) NSString *idCodeStr;
@end
