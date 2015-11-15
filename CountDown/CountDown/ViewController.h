//
//  ViewController.h
//  CountDown
//
//  Created by lq on 15/11/15.
//  Copyright © 2015年 lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic,strong)dispatch_source_t queueTimer;

- (IBAction)resumeTimer:(id)sender;

- (IBAction)cancelTimer:(id)sender;

- (IBAction)stopTimer:(id)sender;

- (IBAction)jump:(id)sender;
@end

