//
//  ViewController.m
//  Vibe
//
//  Created by Senglong on 6/7/18.
//  Copyright © 2018 Senglong. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+animatedGIF.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"background" withExtension:@"gif"];
    self.backgroundView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
