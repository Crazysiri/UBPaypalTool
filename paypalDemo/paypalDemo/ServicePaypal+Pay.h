//
//  ServicePaypal+Pay.h
//  paypalDemo
//
//  Created by qiuyoubo on 2018/4/23.
//  Copyright © 2018年 UB. All rights reserved.
//

#import "ServicePaypal.h"

@interface ServicePaypal (Pay)
+ (void)initializePaypal;
+ (PayPalConfiguration *)defaultConfig;
@end
