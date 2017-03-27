//
//  UserCellTableViewCell.h
//  Usuarios
//
//  Created by Patricia Carvalho on 27/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@protocol User;

@interface UserCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ivPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbBio;

-(id)initWithUser:(User *)user;
@end
