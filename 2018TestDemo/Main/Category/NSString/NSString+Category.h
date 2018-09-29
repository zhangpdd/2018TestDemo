//
//  PK-ios
//
//  Created by peikua on 15/9/15.
//  Copyright (c) 2015年 peikua. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#pragma mark - 格式变化
@interface NSString (Category)


//电话号码中间4位****显示
+ (NSString *)getSecrectStringWithPhoneNumber:(NSString*)phoneNum;

//银行卡号中间8位显示
+ (NSString *)getSecrectStringWithAccountNo:(NSString*)accountNo;

/**抹除运费小数末尾的0*/
- (NSString *)removeUnwantedZero;

//去掉前后空格
- (NSString *)trimmedString;

//转换成价格形式
- (NSString *)convertToMoney;

//json转换成字典或数组
- (id)toArrayOrNSDictionary;

//json转换成字符串
+ (NSString *)jsonToString:(id)data;

//MD5加密
- (NSString *)MD5WithString;

//计算文字高度，可以处理计算带行间距的
- (CGFloat)sizeWithFont:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing maxSize:(CGSize)maxSize;

//计算文字高宽度，单行
- (CGFloat)singleLineWidthWithFont:(UIFont *)font;

//Data类型转换为Base64
+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length;
@end



#pragma mark - 判断格式是否正确
@interface NSString (Predicate)

//有效的密码
- (BOOL)isValidPasswordNumber;

//有效的电话号码
- (BOOL)isValidMobileNumber;

//有效的真实姓名
- (BOOL)isValidRealName;

//是否只有中文
- (BOOL)isOnlyChinese;

//有效的验证码(根据自家的验证码位数进行修改)
- (BOOL)isValidVerifyCode;

//有效的银行卡号
- (BOOL)isValidBankCardNumber;

//有效的邮箱
- (BOOL)isValidEmail;

//有效的字母数字密码
- (BOOL)isValidAlphaNumberPassword;

//检测有效身份证
//15位
- (BOOL)isValidIdentifyFifteen;

//18位
- (BOOL)isValidIdentifyEighteen;

//限制只能输入数字
- (BOOL)isOnlyNumber;

//获取uuid
+(NSString*) uuid ;

//判断文件是否已经在沙盒中已经存在？
-(BOOL) isFileExist:(NSString *)fileName;
@end
