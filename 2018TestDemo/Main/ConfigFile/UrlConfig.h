
#define getTimeOut 10.0f
#define postTimeOut 30.0f


#define  PUBLISH    1
/**
 * ****************************  测试环境  ****************************
*/
#if PUBLISH
#define HTTP_SERVER_IP   [NSString stringWithFormat:@"https://request.ceshi.cn/"]//内网测试地址
/**
 * ****************************  正式环境  ****************************
 */
#else
#define HTTP_SERVER_IP   [NSString stringWithFormat:@"http://hn2.api.okayapi.com/"]//外网地址
#endif


//01意见反馈
#define Feedback_URL [HTTP_SERVER_IP stringByAppendingString:@"s=App.Hello.World"]
