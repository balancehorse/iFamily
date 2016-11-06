//
//  ViewController.m
//  iFamily
//
//  Created by 马钧恒 on 2016/11/3.
//  Copyright © 2016年 balancehorse. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)addEventClick:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addEventClick:(id)sender {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    EKAuthorizationStatus authorizationStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                if (error) {
                    NSLog(@"出错了");
                }else if (!granted){
                    //被用户拒绝
                    NSLog(@"被拒绝");
                }else
                {
                    
                    //时间保存到日历
                    
                    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
                    
                    event.title = @"新增一个测试事件";
                    NSDateFormatter *tempFOrmatter = [[NSDateFormatter alloc] init];
                    event.startDate = [tempFOrmatter dateFromString:@"2016-11-07  17:00"];
                    event.endDate = [tempFOrmatter dateFromString:@"2016-11-07  18:00"];

                    
                    event.location = @"刻录机";
                    [tempFOrmatter setDateFormat:@"2016:11:07 17:00"];
                    
                    
                    
                                       
                    
                    
                    event.allDay = YES;
                    
//                    //添加提醒
////                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f*1 ]];
////
////                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f-15.0f]];
//                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:3600]];
//                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:3600]];
//                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
//                    
//                    NSError *err;
//                    
//                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    
                    
                    NSLog(@"保存成功");
                    
                }
                
            });
            
            
        }];
        
        
        NSArray *calendars = [eventStore calendarsForEntityType:EKEntityTypeReminder];//获取所有的提醒事件
        
        
        
        NSLog(@"提醒事件=======%@",calendars);
    }
    
    
    
}


@end
