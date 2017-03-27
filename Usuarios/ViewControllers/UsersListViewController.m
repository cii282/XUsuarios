//
//  UsersListViewController.m
//  Usuarios
//
//  Created by Patricia Carvalho on 27/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//

#import "UsersListViewController.h"
#import "APIClient.h"
#import "UserCellTableViewCell.h"
#import <SVPullToRefresh_Bell/SVPullToRefresh.h>

int const limit = 20;

@interface UsersListViewController (){
    NSMutableArray<User> *users;
    IBOutlet UITableView *tableViewUsers;
    int page;

}

@end

@implementation UsersListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Usuários";
    
    [self configTableView];
    [self listUsers];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configTableView {
     //tableViewFeed.tableFooterView = [UIView new];
    tableViewUsers.estimatedRowHeight = 85;
    tableViewUsers.rowHeight = UITableViewAutomaticDimension;
  
    [tableViewUsers addInfiniteScrollingWithActionHandler:^{
        page += 1;
        [self listUsers];
        [tableViewUsers.infiniteScrollingView stopAnimating];
            
        }];
    
}

-(void)listUsers{
    [[APIClient sharedManager] listUsers:page*limit andLimit:limit completion:^(UsersResponse *response, NSString *errorMessage){
        [tableViewUsers.pullToRefreshView stopAnimating];
        // [UIHelper hideProgress];
        if(errorMessage)
        {
            NSLog(@"Erro");
            
        }
        else  {
            
            if(page == 0)
                users = response.results;
            else
                [users addObjectsFromArray:response.results];
        }
        
        if(response.results.count == 0)
            tableViewUsers.showsInfiniteScrolling = NO;
        else tableViewUsers.showsInfiniteScrolling = YES;
        
     [tableViewUsers reloadData];
     
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return users.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    User *user = users[(NSUInteger) indexPath.row];
    UserCellTableViewCell *cell = [[UserCellTableViewCell alloc] initWithUser:user];
    return cell;
}


@end
