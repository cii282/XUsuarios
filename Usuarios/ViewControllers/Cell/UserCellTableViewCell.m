//
//  UserCellTableViewCell.m
//  Usuarios
//
//  Created by Patricia Carvalho on 27/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//

#import "UserCellTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation UserCellTableViewCell
{
    UserCellTableViewCell *cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithUser:(User *)user{
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserCellTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];

        
        [cell.ivPhoto sd_setImageWithURL:[NSURL URLWithString:user.picture.thumbnail]];
    
        cell.ivPhoto.layer.cornerRadius = cell.ivPhoto.frame.size.width / 2;
        cell.ivPhoto.layer.borderWidth = 2;
        cell.ivPhoto.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        cell.ivPhoto.layer.masksToBounds = YES;
        cell.lbName.text = [NSString stringWithFormat:@"%@ %@",user.name.first,user.name.last];
        cell.lbBio.text = user.bio.mini;
      
    }
    return cell;
}

@end
