//
//  ViewController.m
//  LFGraphicCodeView
//
//  Created by FFFF on 2016/11/2.
//  Copyright © 2016年 FFFF. All rights reserved.
//

#import "ViewController.h"
#import "LFGraphicCodeView.h"
@interface ViewController ()
@property (nonatomic,strong) LFGraphicCodeView *codeView;
@property (nonatomic,copy) NSString *codeStr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatImageCode];
}


// 创建图片验证码
- (void)creatImageCode{
    
    self.codeStr = [self getRandomString];
    
    NSLog(@"++++++++++%@",self.codeStr);
    self.codeView = [[LFGraphicCodeView alloc] initWithFrame:CGRectMake(100, 50, 80, 35) idCodeStr:self.codeStr isRandom:YES];
    [self.view addSubview:self.codeView];
    
    
    // 自己传输
    __weak ViewController *weakSelf = self;
    self.codeView.changeCodeStrDidClick = ^{
        weakSelf.codeStr = [weakSelf getRandomString];
        weakSelf.codeView.idCodeStr = weakSelf.codeStr;
        [weakSelf.codeView setNeedsDisplay];
        NSLog(@"=======%@",weakSelf.codeStr);
        
    };
    
    self.codeView.changeCodeRandom = ^(NSString *codeStr){
        weakSelf.codeStr = codeStr;
       NSLog(@"random =======%@",weakSelf.codeStr);
    };
    
    
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
