//
//  RetroThemeViewController.m
//  Vibe
//
//  Created by kimlong on 6/8/18.
//  Copyright © 2018 Senglong. All rights reserved.
//

#import "RetroThemeViewController.h"
#import "UIImage+animatedGIF.h"

@interface RetroThemeViewController ()
@property (strong, nonatomic) AVAudioPlayer *retroBGAudio;


@end

@implementation RetroThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayRetroScene];
    [self checkTime];
    [self setAudio];
  
}
- (IBAction)backButton:(id)sender {
    [self.retroBGAudio stop];
}

-(void)setAudio{
    NSString *pathBackground = [[NSBundle mainBundle] pathForResource:@"backgroundA" ofType:@"mp3"];
    NSURL *soundUrlBackground = [NSURL fileURLWithPath:pathBackground];
    self.retroBGAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrlBackground error:nil];
    self.retroBGAudio.volume = 20.0;
    [self.retroBGAudio play];
}


//show the gif background
-(void)displayRetroScene{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"sun" withExtension:@"gif"];
    self.retroBG.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    
    NSURL *urlM = [[NSBundle mainBundle] URLForResource:@"moon" withExtension:@"gif"];
    self.retroMoon.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:urlM]];
}

//Get to see if it is night or day
-(void)checkTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm:ss a"];
    NSString *currentTime = [dateFormatter stringFromDate:[NSDate date]];
    
    if ([currentTime floatValue] >= 18.00 || [currentTime floatValue]  <= 6.00){
        
        NSLog(@"Night");
        self.retroMoon.hidden = FALSE;
        self.retroBGColor.backgroundColor = [UIColor blackColor];
//        self.retroBG.hidden=TRUE;
//
        NSURL *urlW = [[NSBundle mainBundle] URLForResource:@"stars" withExtension:@"gif"];
         self.retroStars.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:urlW]];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"night" withExtension:@"gif"];
        self.retroBG.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        

        
        
       
//        self.retroBG.image = [UIImage imageNamed: @"MoonWaves.jpg"];
    }else{
        
        NSLog(@"Day");
        self.retroMoon.hidden =TRUE;
         self.retroBGColor.backgroundColor = [UIColor whiteColor];
        
    }
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
