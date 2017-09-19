//
//  XRFeatureIndexModel.h
//  XRAnimationSets
//
//  Created by brave on 2017/9/19.
//  Copyright © 2017年 brave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XRFeatureIndexModel : NSObject

@property (nonatomic, copy) NSString *featureName;
@property (nonatomic, copy) NSString *featureClass;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
