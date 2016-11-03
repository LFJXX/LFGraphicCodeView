//
//  LFImageCodeView.m
//  LFCirlStatisView
//
//  Created by FFFF on 2016/11/2.
//  Copyright © 2016年 FFFF. All rights reserved.
//

#import "LFGraphicCodeView.h"

@interface LFGraphicCodeView ()

@property (nonatomic,assign) BOOL isRandom;

@end

@implementation LFGraphicCodeView

- (instancetype)initWithFrame:(CGRect)frame idCodeStr:(NSString *)codeStr isRandom:(BOOL)isRandom{
    if (self = [super initWithFrame:frame]) {
        self.isRandom = isRandom;
        if (isRandom) {
            
            self.idCodeStr = [self getRandomString];
        }else{
            self.idCodeStr = codeStr;
        
        }
        self.backgroundColor = [self getRandomColorWithAlpha:0.5];
      
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeCodeStr)];
        [self addGestureRecognizer:tap];

    }
    return self;
}

- (void)changeCodeStr{

    if (self.isRandom) {
        
        self.idCodeStr = [self getRandomString];
        [self  setNeedsDisplay];
        
        if (self.changeCodeRandom) {
            self.changeCodeRandom(self.idCodeStr);
        }
    }else{
    
        if (self.changeCodeStrDidClick) {
            self.changeCodeStrDidClick();
        }
    }
}



- (void)drawRect:(CGRect)rect {

    self.backgroundColor = [self getRandomColorWithAlpha:0.5];
    
    NSString *codeStr = [NSString stringWithFormat:@"%@",self.idCodeStr];
    CGSize size = [@"W" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    int width = rect.size.width / codeStr.length - size.width;  // 每个字符宽度间隔最大值
    int height = rect.size.height - size.height; // 没个字符高间隔的最大值
    
    CGPoint point;
    
    float X, Y;
    
    for (int i = 0; i < codeStr.length; i++)
    {
        X = arc4random() % width + rect.size.width / codeStr.length * i; // 随机x
        Y = arc4random() % height; // 随机y
        point = CGPointMake(X, Y);
        unichar code = [codeStr characterAtIndex:i];
        NSString *codeStr_i = [NSString stringWithFormat:@"%C", code]; // 取出第i个字符
        [codeStr_i drawAtPoint:point withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    }
    
    CGContextRef cx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cx, 1.0);
    
    
    // 随机添加斜杠
    for(int cout = 0; cout < 10; cout++)
    {
        UIColor *color = [self getRandomColorWithAlpha:0.5];
        CGContextSetStrokeColorWithColor(cx, [color CGColor]);
        X = arc4random() % (int)rect.size.width;
        Y = arc4random() % (int)rect.size.height;
        CGContextMoveToPoint(cx, X, Y);
        X = arc4random() % (int)rect.size.width;
        Y = arc4random() % (int)rect.size.height;
        CGContextAddLineToPoint(cx, X, Y);
        CGContextStrokePath(cx);
    }


    
}


// 获取随机颜色
- (UIColor *)getRandomColorWithAlpha:(CGFloat)alpha{

    float red = arc4random() % 100 /100.0;
    float green = arc4random() % 100 /100.0;
    float blue = arc4random() % 100 /100.0;
    
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return color;
}


// 获取随机四位数
- (NSString *)getRandomString{
    NSArray *array = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
    
    NSMutableString *getStr = [[NSMutableString alloc] initWithCapacity:5];
    
    NSMutableString *codeStr = [[NSMutableString alloc] initWithCapacity:6];
    for(NSInteger i = 0; i < 4; i++)
    {
        NSInteger index = arc4random() % (array.count - 1);
        getStr = [array objectAtIndex:index];
        codeStr = (NSMutableString *)[codeStr stringByAppendingString:getStr];
    }
    
    return [codeStr copy];
    
}


@end
