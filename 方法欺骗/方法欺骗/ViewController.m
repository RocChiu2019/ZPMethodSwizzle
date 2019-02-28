//
//  ViewController.m
//  方法欺骗
//
//  Created by 赵鹏 on 2018/12/14.
//  Copyright © 2018 赵鹏. All rights reserved.
//

/**
 Runtime（运行时）机制也叫做消息发送机制，在OC中所有的方法调用都可以看做是消息发送；
 在Runtime中有两个重要的概念"SEL"和"IMP"，"SEL"是方法编号，"IMP"是方法实现的地址（函数指针）。"SEL"和"IMP"之间的关系，就好像一本书的目录，"SEL"是目录中左侧的标题，"IMP"是目录中右侧的页码，它们是一一对应的关系；
 想要调用Runtime里面的函数就应该先在本类中引用它所依赖的库"<objc/message.h>"，然后在"TARGETS"中的"Build Settings"中搜索"msg"，在搜索结果中把"Enable Strict Checking of objc_msgSend Calls"由"Yes"改为"No"，否则无法调用相关的函数。
 */
#import "ViewController.h"
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     下面的代码可以看做是给"NSURL"这个类发送一个"URLWithString:"的消息。在下面的代码中可以把"URLWithString:"方法看做是"SEL"，当系统调用"URLWithString:"方法的时候，系统会根据这个"SEL"去找寻它所对应的"IMP"，也就是存储方法实现的地址，然后根据这个地址的指向，找到这个方法的实现，并且调用它。
     */
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/新闻"];
    
    /**
     上面的代码可以利用Runtime机制改写成下面的样式。下面代码的意思是给"NSURL"这个类发送一个"URLWithString:"的消息，参数为"https://www.baidu.com"。
     */
//    NSURL *url = objc_msgSend([NSURL class], @selector(URLWithString:), @"https://www.baidu.com");
//    NSLog(@"url = %@", url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"%@", request);
}

@end
