//
//  SettingsViewController.m
//  Vibe
//
//  Created by kimlong on 6/8/18.
//  Copyright © 2018 Senglong. All rights reserved.
//

#import "SettingsViewController.h"
#import "RetroThemeViewController.h"
#import "UIImage+animatedGIF.h"


@interface SettingsViewController (){

NSDictionary *citiesList;
//primary api url string. All parameters are appended to it.
NSMutableString *apiURLString;
NSArray *rowsValuesHolder;
id vari;
NSArray *applyWeather;

}
@property (weak, nonatomic) IBOutlet UIPickerView *chooseLocation;

@property (weak, nonatomic) IBOutlet UITextField *weatherCode;

//Update Note: Label named temp is used for Weathe




- (void)setCitiesList;
- (void)setApiUrl: (NSNumber*)cityId;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayBG];
  
    [self setCitiesList];
    self.chooseLocation.dataSource = self;
    self.chooseLocation.delegate = self;
    
    applyWeather = [NSArray alloc];
   

    
}

-(void)displayBG{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"colors" withExtension:@"gif"];
    self.settingsBG.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//setting data in array for picker view

- (void)setCitiesList {
    citiesList = @{
                  
                   @"Seattle" : [NSNumber numberWithInt:5809844],
                   @"Los Angeles" : [NSNumber numberWithInt:5368381],
                   @"Houston" : [NSNumber numberWithInt:4391354],
                   @"Cambodia" : [NSNumber numberWithInt:1831722]};
    
}


//setting the number of components in picker view
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//setting the number of rows in picker view's component(s)
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [citiesList count];
}


//setting the rows for the picker
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    rowsValuesHolder = [citiesList allKeys];
    return rowsValuesHolder[row];
}

//identifying the row selected using picker delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //NSLog(@"Selected row is %@", citiesList[row]);
    rowsValuesHolder = [citiesList allValues];
    [self setApiUrl: rowsValuesHolder[row]];
}


//setting api url string
-(void)setApiUrl: (NSNumber*)cityId {
    apiURLString = [NSMutableString stringWithString:@"https://api.openweathermap.org/data/2.5/weather?id="];
    [apiURLString appendFormat:@"%@", cityId];
    //[apiURLString appendString:cityName];
    //appending app id
    [apiURLString appendString:@"&appid=68dd7bbbeb2304a7f928af8ece12043e"];
    [apiURLString appendString:@"&type=accurate&units=imperial"];
    NSLog(@"not just the url %@", apiURLString);
    [self makeApiCall:apiURLString];
}

//calling  the weather api @openweather.org
-(void)makeApiCall: (NSMutableString *)apiURLStringPar{
  
    NSURL *urlContainingApiCall = [NSURL URLWithString:apiURLStringPar];
    //prepare url session
    NSURLSession *mySession = [NSURLSession sharedSession];
    //when a method asks for completion handler, it asks for a block of code that is executed once method operation is completed
    //delete the completion handler and put braces for the block i.e. {} and remove the return type
    [[mySession dataTaskWithURL:urlContainingApiCall completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Network error encountered %@",error);
            return;
        }
        
        NSHTTPURLResponse *pointerToDetStatusCode = (NSHTTPURLResponse *) response; //type casting ?
        if (pointerToDetStatusCode.statusCode < 200 || pointerToDetStatusCode.statusCode >= 300) {
            NSLog(@"HTTP error status code %ld", (long)pointerToDetStatusCode.statusCode);
            return;
        }
        NSError *parseError;
        self->vari = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        if (!self->vari) {
            NSLog(@"Parse error %@", parseError);
        }
       
        NSLog(@"\nJSON response is: %@",self->vari);
        
        

        dispatch_async(dispatch_get_main_queue(), ^{
            

            
            //temp label now displays weather description
            self.weatherCode.text = [NSString stringWithFormat:@"%@",self->vari[@"weather"][0][@"id"]];
      
        });
        
        
        
        
    }]resume];
    
    
}
- (IBAction)retroTheme:(id)sender {
    UIStoryboard *refToStoryBoardA = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    
    
    RetroThemeViewController *pointerToRetro = [refToStoryBoardA instantiateViewControllerWithIdentifier:@"retro"];
    pointerToRetro.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:pointerToRetro animated:YES completion:nil];
    
    
    pointerToRetro.retroLabel.text = [NSString stringWithFormat:@"%@",vari[@"weather"][0][@"description"]];
    
    /*****************CHECKWEATHER************************/
    
    //Cloud
    if( [self.weatherCode.text  isEqual: @"801"]||[self.weatherCode.text  isEqual: @"802"]||[self.weatherCode.text  isEqual: @"803"]||[self.weatherCode.text  isEqual: @"804"]){
        pointerToRetro.retroBGColor.backgroundColor = [UIColor brownColor];
        
       
        
    
        //Rain
    } else if ( [self.weatherCode.text  isEqual: @"500"]||[self.weatherCode.text  isEqual: @"501"]||[self.weatherCode.text  isEqual: @"502"]||[self.weatherCode.text  isEqual: @"803"]){
        pointerToRetro.retroBGColor.backgroundColor = [UIColor blackColor];
        
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"rain2" withExtension:@"gif"];
        pointerToRetro.retroRain.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
        
    }
    
}

//
//- (IBAction)sceneB:(id)sender {
//    UIStoryboard *refToStoryBoardB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//
//
//
//    SceneBViewController *pointerToSceneB = [refToStoryBoardB instantiateViewControllerWithIdentifier:@"SceneB"];
//    pointerToSceneB.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:pointerToSceneB animated:YES completion:nil];
//
//    /*****************CHECK WEATHER************************/
//
//    //Cloud
//    if( [self.weatherCode.text  isEqual: @"801"]||[self.weatherCode.text  isEqual: @"802"]||[self.weatherCode.text  isEqual: @"803"]||[self.weatherCode.text  isEqual: @"804"]){
//        pointerToSceneB.weatherColorB1.backgroundColor = [UIColor redColor];
//
//        NSURL *url = [[NSBundle mainBundle] URLForResource:@"background" withExtension:@"gif"];
//        pointerToSceneB.weatherImageB1.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
//
//        //        pointerToSceneA.weatherImage.image = [UIImage imageNamed:@"01.png"];
//
//        //Rain
//    } else if ( [self.weatherCode.text  isEqual: @"500"]||[self.weatherCode.text  isEqual: @"501"]||[self.weatherCode.text  isEqual: @"502"]||[self.weatherCode.text  isEqual: @"803"]){
//        pointerToSceneB.weatherColorB1.backgroundColor = [UIColor colorWithRed:24.0/255.0 green:150.0/255.0 blue:205.0/255.0 alpha:10.0];
//
//        NSURL *url = [[NSBundle mainBundle] URLForResource:@"sun" withExtension:@"gif"];
//        pointerToSceneB.weatherImageB1.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
//
//    }

    











@end

