//
//  XRAnnularPieView.h
//  XRAnnularPieView
//
//  Created by brave on 2017/9/9.
//  Copyright © 2017年 brave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRAnnularPieView : UIView


@property (nonatomic, strong) NSMutableArray *valueArray;
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) NSMutableArray *colorArray;

- (void)strokePath;

@end
