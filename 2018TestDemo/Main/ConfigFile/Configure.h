
#import <objc/runtime.h>

//头文件导入
/****第三方******/
#import <Masonry.h>
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
/****类目******/
#import "UIView+BGFrame.h"
#import "UIImage+Category.h"
#import "UIColor+BGHexColor.h"
#import "UIButton+Creat.h"
#import "UIButton+Category.h"
#import "UIViewController+Json.h"
#import "NSString+Category.h"
#import "UILabel+Creat.h"
#import "UIViewController+HUD.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Toast.h"
#import "AlertTool.h"

#define FirstLaunch @"firstLaunch"

#define networkFailed @"网络连接失败，请稍候再试"
//主题
#define ZTTThome @"ZTTThome"


/** 屏幕的宽度*/
#define FrameW [UIScreen mainScreen].bounds.size.width
/** 屏幕的高度 */
#define FrameH [UIScreen mainScreen].bounds.size.height

//是否是空对象
#define IsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//弱引用/强引用
//可配对引用在外面用weakself(self)，block用StrongSelf(self)
//也可以单独引用在外面用weakSelf(self) block里面用weakself
#define weakSelf(type)  __weak typeof(type) weak##type = type
#define strongSelf(type)  __strong typeof(type) strong##type = weak##type;

/** 比例（对照设计图) */
#define ScaleWidth [[UIScreen mainScreen] bounds].size.width/750
#define ScaleHeight [[UIScreen mainScreen] bounds].size.height/1334
#define scaleValue(x) ScaleWidth * x

/** 字体适配*/
#define Scale ([[NSString stringWithFormat:@"%.1f",[UIScreen mainScreen].bounds.size.width / 375.0] doubleValue])
#define ScaleSize  (Scale==1.0 ? 1.0 : Scale)

/** 字体*/
#define Font(x)          [UIFont systemFontOfSize:x]
#define Font_bold(x)     [UIFont boldSystemFontOfSize:x]
#define CustomFont_(x)   [UIFont fontWithName:@"Heiti SC" size:x]

/** 状态栏的高度 */
#define statusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

/** 导航栏的高度 */
#define NavBarHeight 44

/** 导航栏加状态栏的高度 */
#define NavTopHeight ([[UIApplication sharedApplication] statusBarFrame].size.height + 44)

/** iPhoneX底栏安全区域的高度 */
#define SafeBottomHeight [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom

/** 适配iPhone x 底栏高度*/
#define TabbarHeight   (statusBarHeight>20?83:49)

/** 颜色转换 */
#define UIColorHex(colorValue)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#colorValue))]

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/** RGB颜色赋值*/
#define RGBColor(r , g , b , a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

/** 随机色颜色*/
#define randomColor RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1.0)




#define saveUserForKey(value,x) [[NSUserDefaults standardUserDefaults] setObject:value forKey:x];

//[[NSUserDefaults standardUserDefaults] synchronize];

#define userForKey(x) [[NSUserDefaults standardUserDefaults] objectForKey:x]
