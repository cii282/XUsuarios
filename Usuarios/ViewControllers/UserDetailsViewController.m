//
//  UserDetailsViewController.m
//  Usuarios
//
//  Created by Patricia Carvalho on 27/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//

#import "UserDetailsViewController.h"
#import "APIClient.h"
#import "UIHelper.h"
#import "UIImageView+WebCache.h"
#import "UploadImageRequest.h"

@interface UserDetailsViewController (){
    
    IBOutlet NSLayoutConstraint *heightLbBio;
    User *detail;
    IBOutlet UIImageView *ivUser;
    IBOutlet UIImageView *ivProfile;
    IBOutlet UILabel *lbName;
    IBOutlet UILabel *lbBio;
    IBOutlet UILabel *lbEmail;
    IBOutlet UILabel *lbLocation;
}

@end

@implementation UserDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self getDetailsUser];
    // Do any additional setup after loading the view.
}

-(void)getDetailsUser{
    [UIHelper showProgress];
    [[APIClient sharedManager] userDetail:@600 completion:^(User *response, NSString *errorMessage){
        
        [UIHelper hideProgress];
        
        if(errorMessage)
        {
            NSLog(@"Erro");
            
        }
        else  {
            
            detail = response;
            [self fillDetails:detail];
        }
        
    }];
    
    
}
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fillDetails:(User *)userDetails{
    
    [ivUser sd_setImageWithURL:[NSURL URLWithString:userDetails.picture.thumbnail]
     placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    ivUser.layer.cornerRadius = ivUser.frame.size.width / 2;
    ivUser.layer.borderWidth = 2;
    ivUser.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    ivUser.layer.masksToBounds = YES;
    
    [ivProfile sd_setImageWithURL:[NSURL URLWithString:userDetails.profile.background_image]
     placeholderImage:[UIImage imageNamed:@"placeholder"]];

    lbName.text = [NSString stringWithFormat:@"%@ %@", userDetails.name.first, userDetails.name.last];
    lbBio.text = [userDetails.bio.full isEqualToString:@""] ? userDetails.bio.mini : userDetails.bio.full;
    heightLbBio.constant = [[UIHelper sharedInstance]sizeText:lbBio];
    lbEmail.text = userDetails.email;
    lbLocation.text = userDetails.location.state;
    
    
}

- (IBAction)sendImage:(id)sender {
    UIActionSheet *actionSheet;
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Tirar Foto",@"Abrir Galeria", nil];
    
    [actionSheet showInView:self.view];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self chooseImage:UIImagePickerControllerSourceTypeCamera];
            break;
        case 1:
            [self chooseImage:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        default:
            [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
            break;
    }
}

#pragma mark - Avatar Related

- (void) chooseImage:(UIImagePickerControllerSourceType) source{ 
    //Tira a foto
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        NSLog(@"Camera not Available");
//        return;
//    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setSourceType:source];
    [imagePicker setMediaTypes:@[(NSString*) kUTTypeImage]];
    [imagePicker setAllowsEditing:YES];
    [imagePicker setDelegate:self];
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerController Delegate Methods

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *originalImage, *editedImage, *imageToSave;
    
    originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    
    if (editedImage) {
        imageToSave = editedImage;
    }
    else {
        imageToSave = originalImage;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(128, 128));
    [imageToSave drawInRect:CGRectMake(0, 0, 128, 128)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self uploadImage:resizedImage];
    }];
}
#pragma mark - Photo Upload/Download

-(void)uploadImage:(UIImage*) image{
    [UIHelper showProgress];
    UploadImageRequest *request = [[UploadImageRequest alloc] init];
    request.image = [UIHelper imageToNSString:image];
    
    
    [[APIClient sharedManager] sendImage:request completion:^(NSString *errMessage) {
        [UIHelper hideProgress];
        if (errMessage){
           // [[UIHelper sharedInstance] mostrarAlerta:errMessage];
        }
        else{
//            if(![response.message isEqualToString:@""])
//                [[UIHelper sharedInstance] mostrarAlerta:response.message];
//            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}


@end
