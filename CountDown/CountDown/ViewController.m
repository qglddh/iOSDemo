//
//  ViewController.m
//  CountDown
//
//  Created by lq on 15/11/15.
//  Copyright © 2015年 lq. All rights reserved.
//


//参考源码链接
//https://github.com/nijino/CircularProgressView

#import "ViewController.h"
#import "SubViewController.h"
#import "CircularProgressView.h"

#define TIME_OUT    30
static NSInteger count = 0;

@interface ViewController ()

@property (nonatomic,strong)dispatch_source_t queueTimer;
@property (nonatomic,strong)CircularProgressView *circularProgressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initQueueTimer];
    [self initCircle];
    self.showTime.text = @"";
    count = TIME_OUT;

    NSLog(@"current thread %@",[NSThread currentThread]);
}

- (void)initCircle
{
    UIColor *backColor = [UIColor colorWithRed:236.0/255.0
                                         green:236.0/255.0
                                          blue:236.0/255.0
                                         alpha:1.0];
    UIColor *progressColor = [UIColor colorWithRed:82.0/255.0
                                             green:135.0/255.0
                                              blue:237.0/255.0
                                             alpha:1.0];
    self.circularProgressView.lineWidth = 20;
    
    //alloc CircularProgressView instance
    self.circularProgressView = [[CircularProgressView alloc] initWithFrame:CGRectMake(41, 57, 238, 238)
                                                                  backColor:backColor
                                                              progressColor:progressColor
                                                                  lineWidth:10];
    [self.circularProgressView setProgress:1.0];
    [self.view addSubview:self.circularProgressView];
    
}
- (void)initQueueTimer
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    _queueTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_queueTimer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_queueTimer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            count--;
            NSString *str = [NSString stringWithFormat:@"%d",count];
            self.showTime.text = str;
            [self.circularProgressView setProgress:count/30.0];
            if (count <=0) {
                count = TIME_OUT;
            }
        });
    });
}

- (IBAction)resumeTimer:(id)sender {
    dispatch_resume(_queueTimer);
}

- (IBAction)cancelTimer:(id)sender {
//    dispatch_source_cancel(_queueTimer);
}

- (IBAction)stopTimer:(id)sender {
    count = 0;
    dispatch_suspend(_queueTimer);
}

- (IBAction)jump:(id)sender {
    SubViewController *subViewControler = [[SubViewController alloc]init];
    
    [self presentViewController:subViewControler animated:YES completion:^{
        
    }];
}

@end
