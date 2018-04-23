//
//  ServicePaypal+Pay.m
//  paypalDemo
//
//  Created by qiuyoubo on 2018/4/23.
//  Copyright © 2018年 UB. All rights reserved.
//

#import "ServicePaypal+Pay.h"

@implementation ServicePaypal (Pay)
+ (void)initializePaypal {
    [self initializePaypalWithSandboxKey:@"" productionKey:@"" production:YES];
}

+ (PayPalConfiguration *)defaultConfig {
    PayPalConfiguration *_payPalConfig = [[PayPalConfiguration alloc]init];
    _payPalConfig.acceptCreditCards = NO; //是否接受信用卡
    _payPalConfig.merchantName = @""; //商家名
    //商家隐私协议网址和用户授权网址(不知道干嘛用的)
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    
    /*
     //设置地址选项-在支付页面可选择账户地址信息
     typedef NS_ENUM(NSInteger, PayPalShippingAddressOption) {
     //不展示地址信息
     PayPalShippingAddressOptionNone = 0,
     //这个没试过，自行查阅
     PayPalShippingAddressOptionProvided = 1,
     //paypal账号下的地址信息
     PayPalShippingAddressOptionPayPal = 2,
     //全选
     PayPalShippingAddressOptionBoth = 3,
     };
     */
    
    //paypal账号下的地址信息
    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionNone; //调试过程中这个地方选择了PayPal,但是支付的时候会提示delivery address 不正确,查了原因大概是什么code不能是中国，此处先记录但没验证过
    
    //配置语言环境
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    return _payPalConfig;
}
@end
