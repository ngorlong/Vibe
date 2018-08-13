//
//  RetroThemeViewController.h
//  Vibe
//
//  Created by kimlong on 6/8/18.
//  Copyright © 2018 Senglong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface RetroThemeViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *retroBGColor;
@property (weak, nonatomic) IBOutlet UIImageView *retroBG;
@property (weak, nonatomic) IBOutlet UIImageView *retroRain;
@property (weak, nonatomic) IBOutlet UILabel *retroLabel;
@property (weak, nonatomic) IBOutlet UIImageView *retroMoon;
@property (weak, nonatomic) IBOutlet UIImageView *retroStars;

@end
