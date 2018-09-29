//
//  dyTableViewCell.h
//  2018TestDemo
//
//  Created by zp on 2018/6/29.
//  Copyright © 2018年 zp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class dyModel;
@interface dyTableViewCell : UITableViewCell

@property (strong ,nonatomic) dyModel *model;

- (void)setUP;

@end
