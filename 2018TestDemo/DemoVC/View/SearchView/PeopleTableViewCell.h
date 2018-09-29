//
//  PeopleTableViewCell.h
//  WeChat1
//
//  Created by Topsky on 2018/5/2.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PeopleItem;

@interface PeopleTableViewCell : UITableViewCell

- (void)setPeopleContent:(PeopleItem *)peopleVO;

@end
