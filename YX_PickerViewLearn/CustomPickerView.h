//
//  CustomPickerView.h
//  YX_PickerViewLearn
//
//  Created by yang on 16/8/29.
//  Copyright © 2016年 poplary. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomPickerViewDelegate <NSObject>

- (void)selectShow:(NSString *)title WithRow:(NSInteger)row WithCom:(NSInteger)com;

@end
@interface CustomPickerView : UIView

//数据数组
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, weak)id<CustomPickerViewDelegate>delegate;
@property (nonatomic, assign) NSInteger numOfCom;
@end
