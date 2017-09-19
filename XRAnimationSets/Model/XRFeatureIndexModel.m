//
//  XRFeatureIndexModel.m
//  XRAnimationSets
//
//  Created by brave on 2017/9/19.
//  Copyright © 2017年 brave. All rights reserved.
//

#import "XRFeatureIndexModel.h"

@implementation XRFeatureIndexModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.featureName = dict[@"featureName"];
        self.featureClass = dict[@"featureClass"];
    }
    return self;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    XRFeatureIndexModel *model = [[XRFeatureIndexModel alloc] initWithDict:dict];
    return model;
}


@end
