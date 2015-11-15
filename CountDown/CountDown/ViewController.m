//
//  ViewController.m
//  CountDown
//
//  Created by lq on 15/11/15.
//  Copyright © 2015年 lq. All rights reserved.
//

#import "ViewController.h"
#import "SubViewController.h"

#define TIME_OUT    30

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initQueueTimer];
    
    NSLog(@"current thread %@",[NSThread currentThread]);
}

- (void)initQueueTimer
{
    static int count = 0;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    _queueTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_queueTimer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_queueTimer, ^{
        count++;
        NSLog(@"current thread %@-----%d-----",[NSThread currentThread],count);
    });
}

- (IBAction)resumeTimer:(id)sender {
    dispatch_resume(_queueTimer);
}

- (IBAction)cancelTimer:(id)sender {
    dispatch_source_cancel(_queueTimer);
}

- (IBAction)stopTimer:(id)sender {
    dispatch_suspend(_queueTimer);
}

- (IBAction)jump:(id)sender {
    SubViewController *subViewControler = [[SubViewController alloc]init];
    
    [self presentViewController:subViewControler animated:YES completion:^{
        
    }];
}

@end
