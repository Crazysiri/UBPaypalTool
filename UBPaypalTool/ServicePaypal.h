//
//  ServicePaypal.h
//  Dandanjia
//
//  Created by qiuyoubo on 17/3/10.
//  Copyright © 2017年 xiandanjia.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PayPalMobile.h>

@interface ServicePaypal : NSObject

@property (readonly,strong, nonatomic) PayPalConfiguration *config;

//初始化 一般放在delegate didFinishLaunchingWithOptions 方法中
+ (void)initializePaypalWithSandboxKey:(NSString *)sandbox productionKey:(NSString *)production production:(BOOL)isProduction;

//有默认的PayPalConfiguration
+ (id)paypal;

/**
 @param payment
 
 (简单用,只需看 1 即可）
 
 关于payment生成：
 1.正常使用填写基本参数即可:(amount,currencyCode（RMB是没用的）,shorDescription)

 2.其它参数：items:(<PayPalItem *>:Quantity,Price,Currency,Sku)，
           paymentDetails:(<PayPalPaymentDetails *>:Shipping,Tax),
           shippingAddress:(<PayPalShippingAddress *>),
 
 详细用法伪代码:
        PayPalItem *item1;
        PayPalItem *item2;
        PayPalItem *item2;
        NSArray *items = @[item1, item2, item3];
        NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
        
        NSDecimalNumber *shipping;
        NSDecimalNumber *tax;
 
        PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal
        withShipping:shipping
        withTax:tax];
 
        NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];

        PayPalPayment *payment;
        payment.amount = total;
        payment.currencyCode = @"USD";
        payment.shortDescription = @"Hipster clothing";
        payment.items = items;
        payment.paymentDetails = paymentDetails;
 
 
 @param info

 //回调的 PayPalPayment 的 confirmation 属性包含此次订单的状态信息包括校验码，服务器可已通过该校验码验证交易真实性。
 //返回数据 - id所对应的就是校验码。
 {
 client =     {
 environment = sandbox;
 "paypal_sdk_version" = "2.14.2";
 platform = iOS;
 "product_name" = "PayPal iOS SDK";
 };
 response =     {
 "create_time" = "2016-05-12T03:25:49Z";
 id = "PAY-6BG56850AF923584SK4Z7PNQ";
 intent = sale;
 state = approved;
 };
 "response_type" = payment;
 }

 */
- (void)payWithPayment:(PayPalPayment *)payment completion:(void(^)(BOOL success,NSDictionary *info,NSString *msg))completion;
//封装了上面的payment,实际也是调用上面的方法
- (void)payWithAmount:(NSString *)amount currency:(NSString *)currency description:(NSString *)discription custom:(NSString *)custom completion:(void(^)(BOOL success,NSDictionary *info,NSString *msg))completion;
- (void)payTest;
@end
