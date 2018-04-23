//
//  ServicePaypal.m
//  Dandanjia
//
//  Created by qiuyoubo on 17/3/10.
//  Copyright © 2017年 xiandanjia.com. All rights reserved.
//

#import "ServicePaypal.h"
typedef void(^PayPalPayCompletionBlock)(BOOL success,NSDictionary *info,NSString *msg);
@interface ServicePaypal () <PayPalPaymentDelegate>
{
    PayPalConfiguration *_config;
}
@property (strong, nonatomic) PayPalPayCompletionBlock completion;
@end

@implementation ServicePaypal
+ (void)initializePaypalWithSandboxKey:(NSString *)sandbox productionKey:(NSString *)production production:(BOOL)isProduction {
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : production,
                                                           PayPalEnvironmentSandbox :
                                                               sandbox}];
    [self setEnvironment:isProduction];
}

+ (void)setEnvironment:(BOOL)isProduction {
    if (isProduction) {
        [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentProduction];
    } else {
        [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentSandbox];
    }
}

- (void)dealloc {
    self.completion = nil;
}


//有默认的PayPalConfiguration
+ (id)paypal {
    ServicePaypal *pay = [[ServicePaypal alloc]init];
    return pay;
}


- (void)payWithPayment:(PayPalPayment *)payment completion:(void(^)(BOOL success,NSDictionary *info,NSString *msg))completion {
    self.completion = completion;
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.config
                                                                                                     delegate:self];

    UIViewController *root = [UIApplication sharedApplication].delegate.window.rootViewController;
    [root presentViewController:paymentViewController animated:YES completion:nil];
}


- (void)payWithAmount:(NSString *)amount currency:(NSString *)currency description:(NSString *)discription custom:(NSString *)custom completion:(void(^)(BOOL success,NSDictionary *info,NSString *msg))completion {
    PayPalPayment *payment = [[PayPalPayment alloc]init];
    payment.amount = [NSDecimalNumber decimalNumberWithString:amount];
    payment.currencyCode = currency;
    payment.shortDescription = discription;
    payment.custom = custom;
    /// - the amount is non-positive,
    /// - the currency is invalid,
    /// - the amount includes more decimal fraction digits than the currency allows,
    /// - there's no description, or
    /// - the payment has already been processed.
    if (!payment.processable) {
        completion(NO,nil, @"币种不支持");
        return;
    }
    [self payWithPayment:payment completion:completion];
}

- (void)payTest {
    PayPalPayment *payment = [[PayPalPayment alloc]init];
    payment.amount = [NSDecimalNumber decimalNumberWithString:@"0.01"];
    payment.currencyCode = @"HKD";
    payment.shortDescription = @"Hipster clothing";
    [self payWithPayment:payment completion:^(BOOL success, NSDictionary *info,NSString *msg) {
        
    }];
}

#pragma mark - getter

- (PayPalConfiguration *)config {
    if (!_config) {
        _config = [[PayPalConfiguration alloc]init];
    }
    return _config;
}

#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    if (self.completion) {
        self.completion(YES,completedPayment.confirmation,@"充值成功");
    }
    NSLog(@"PayPal Payment Success!");
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    if (self.completion) {
        self.completion(NO,nil,@"取消充值");
    }
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"PayPal Payment Canceled");

}

@end
