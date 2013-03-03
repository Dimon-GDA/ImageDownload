//
//  ViewController.m
//  ImageDownload
//
//  Created by admin on 2/28/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated
{
[super viewWillAppear:animated];
    
    NSLog(@"before download");
   
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0) ,^{
        NSData* data=[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.tumencev.pp.ua/uploads/2011/12/8_neon-dragon-87070.jpg"]];
        sleep(2);
        UIImage* myimage=[UIImage imageWithData:data];

        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image.image=myimage;
        });
        
        
        
        
    });
    
    
    NSLog(@"after download");
     
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(UIButton *)sender {
    
    NSLog(@"start saving");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0) ,^{    
    
    UIImage* myImage=self.image.image;
    NSData* data=UIImagePNGRepresentation(myImage);
 
    NSString* fileName=@"myImage.png";
    NSArray* paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* path=[NSString stringWithFormat:@"%@/%@",[paths objectAtIndex:0],fileName ];
    [data writeToFile:path atomically:YES];
        
    });
    NSLog(@"end saving");
}
@end
