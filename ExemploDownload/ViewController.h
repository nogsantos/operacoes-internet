//
//  ViewController.h
//  ExemploDownload
//
//  Created by Fabricio Nogueira dos Santos on 9/10/15.
//  Copyright (c) 2015 Fabricio Nogueira. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *downloadField;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;
- (IBAction)startDownload:(id)sender;

@end

