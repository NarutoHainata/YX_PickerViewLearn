//
//  CustomPickerView.m
//  YX_PickerViewLearn
//
//  Created by yang on 16/8/29.
//  Copyright © 2016年 poplary. All rights reserved.
//

#import "CustomPickerView.h"

@interface CustomPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>{
    
    NSString *str1;
    NSString *str2;
    NSString *str3;
}

@property (nonatomic, strong) UIPickerView *myPickerView;
@end

@implementation CustomPickerView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
    
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}
- (void)setNumOfCom:(NSInteger)numOfCom{
    
    _numOfCom = numOfCom;
    NSLog(@"%ld",(long)_numOfCom);
    [self.myPickerView reloadAllComponents];
    [self addSubview:self.myPickerView];
}
- (void)setDataArr:(NSArray *)dataArr{
    
    _dataArr = dataArr;
    str1 = @"1949";
    str2 = @"1";
    str3 = @"1";
    
}
- (UIPickerView *)myPickerView{
    
    if (!_myPickerView) {
        _myPickerView = [[UIPickerView alloc] initWithFrame:self.bounds];
        _myPickerView.delegate = self;
        _myPickerView.dataSource = self;
    }
    return _myPickerView;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.numOfCom == 3) {
        if (component == 0) {
            return [[self.dataArr objectAtIndex:0] count];
        }
        else if (component == 1){
            return [[self.dataArr objectAtIndex:1] count];
        }
        else{
            return [[self.dataArr objectAtIndex:2] count];
        }
    }else{
    
        return self.dataArr.count;
        
    }
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
//    NSInteger nums;
//    if ([self.delegate respondsToSelector:@selector(numberOfComponents)]) {
//       nums = [self.delegate numberOfComponents];
//    }
    
    return self.numOfCom;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (self.numOfCom == 1) {
        return [NSString stringWithFormat:@"%@",[self.dataArr objectAtIndex:row]];
    }
    //这里已知是个三维数字  3个component
    else{
        
     return [NSString stringWithFormat:@"%@",[[self.dataArr objectAtIndex:component] objectAtIndex:row]];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.numOfCom == 1) {
        if ([self.delegate respondsToSelector:@selector(selectShow:WithRow:WithCom:)]) {
            [self.delegate selectShow:[NSString stringWithFormat:@"%@",[self.dataArr objectAtIndex:row]] WithRow:row WithCom:component];
        }
    }
    else{
        if ([self.delegate respondsToSelector:@selector(selectShow:WithRow:WithCom:)]) {
            
            NSLog(@"%ld--%ld",(long)component,(long)row);
            if (component == 0) {
                
                str1 = [[self.dataArr objectAtIndex:0] objectAtIndex:row];
            }
            else if (component == 1){
                str2 = [[self.dataArr objectAtIndex:1] objectAtIndex:row];
            }else{
                str3 = [[self.dataArr objectAtIndex:2] objectAtIndex:row];
            }
            
            [self.delegate selectShow:[NSString stringWithFormat:@"%@--%@--%@",str1,str2,str3] WithRow:row WithCom:component];
            NSLog(@"%@--%@--%@",str1,str2,str3);
        }
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
