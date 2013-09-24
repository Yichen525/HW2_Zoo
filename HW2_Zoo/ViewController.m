//
//  ViewController.m
//  HW2_Zoo
//
//  Created by Yu Yichen on 9/23/13.
//  Copyright (c) 2013 Yu Yichen. All rights reserved.
//

#import "ViewController.h"
#import "Animal.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize mainView;
@synthesize scroll;
@synthesize animalName;
@synthesize note;
@synthesize animals;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"in loadView");
    mainView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    mainView.backgroundColor=[UIColor whiteColor];
    self.view=mainView;
    
    double width=(double)[[UIScreen mainScreen] bounds].size.width;
    NSLog(@"%f",width);
    double height=(double)[[UIScreen mainScreen] bounds].size.height;
    NSLog(@"%f",height);
    
    
    scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height*0.7)];
    scroll.backgroundColor=[UIColor redColor];
    scroll.pagingEnabled=YES;
    scroll.contentSize=CGSizeMake(width*3.0, height*0.7);
    [mainView addSubview:scroll];
    
    animalName=[[UILabel alloc] initWithFrame:CGRectMake(0, height*0.7, width, height*0.16)];
    animalName.backgroundColor=[UIColor yellowColor];
    [animalName setText:@"Animal's name shown here!"];
    [animalName setTextAlignment:NSTextAlignmentCenter];
    [animalName setTextColor:[UIColor blueColor]];
    [mainView addSubview:animalName];
    
    note=[[UILabel alloc] initWithFrame:CGRectMake(0, height*0.86, width, height*0.14)];
    note.backgroundColor=[UIColor whiteColor];
    [note setText:@"Tap \"TAP me!\" to show the image from the Internet."];
    [note setTextAlignment:NSTextAlignmentRight];
    [note setTextColor:[UIColor blackColor]];
    note.font=[UIFont systemFontOfSize:9];
    [mainView addSubview:note];
    
    
    
    
    Animal *tiger=[[Animal alloc]init];
    Animal *panda=[[Animal alloc]init];
    Animal *elephant=[[Animal alloc]init];
    
    tiger.name=@"Tiger";
    panda.name=@"Panda";
    elephant.name=@"Elephant";
    
    UIImage *tigerImage=[UIImage imageNamed:@"tiger.png"];
    UIImage *pandaImage=[UIImage imageNamed:@"panda.png"];
    UIImage *elephantImage=[UIImage imageNamed:@"elephant.png"];
    tiger.image=tigerImage;
    panda.image=pandaImage;
    elephant.image=elephantImage;
    
    animals=[[NSMutableArray alloc]init];
    
    [animals insertObject: tiger atIndex:0];
    [animals insertObject: panda atIndex:1];
    [animals insertObject: elephant atIndex:2];
    
    
    UIButton *button;
    
    for (int i=0; i<3; i++) {
        button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTag:i];
        [button setFrame:CGRectMake(30+width*i, height*0.009, 260,height*0.123)];
        
        
        [button setTitle:[NSString stringWithFormat:@"%@",((Animal*)[animals objectAtIndex:i]).name] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchDown];
        [scroll addSubview:button];
    };
    
    
    UIButton *buttonChange;
    
    for (int i=0; i<3; i++) {
        buttonChange=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonChange setTag:i];
        [buttonChange setFrame:CGRectMake(110+width*i,height*0.634, 100,height*0.062)];
        
        
        [buttonChange setTitle:[NSString stringWithFormat:@"%s","Tap me!"] forState:UIControlStateNormal];
        
        [buttonChange addTarget:self action:@selector(buttonToChange:) forControlEvents:UIControlEventTouchDown];
        [scroll addSubview:buttonChange];
    };
    
    
    
    
    
    UIImageView *imageView;
    for (int i=0; i<3; i++){
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(30+width*i,height*0.157, width*0.813, height*0.457)];
        imageView.image=((Animal*)[animals objectAtIndex:i]).image;
        [scroll addSubview:imageView];
        
    }
   
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
           
        NSURL *tigerURL=[NSURL URLWithString:@"http://1.bp.blogspot.com/-e_yASjMmkLQ/T70A2i01bBI/AAAAAAAAAwc/3Mo40TpXtB0/s320/tiger.jpeg"];
         NSURL *pandaURL=[NSURL URLWithString:@"http://www.jaunted.com/files/3873/panda.jpg"];
       NSURL *elephantURL=[NSURL URLWithString:@"http://3.bp.blogspot.com/-MB9v4wgnP00/UCo_6w5AvRI/AAAAAAAAL2c/brSMYYbNgw4/s1600/asian-elephant.jpg"];
    
        
        NSData *tigerData=[[NSData alloc]initWithContentsOfURL:tigerURL];
        NSData *pandaData=[[NSData alloc]initWithContentsOfURL:pandaURL];
        NSData *elephantData=[[NSData alloc]initWithContentsOfURL:elephantURL];
    
        UIImage *tigerImageNew=[[UIImage alloc]initWithData:tigerData];
        UIImage *pandaImageNew=[[UIImage alloc]initWithData:pandaData];
        UIImage *elephantImageNew=[[UIImage alloc]initWithData:elephantData];
        NSLog(@"The images have been downloaded.");
    
        tiger.imageNew=tigerImageNew;
        panda.imageNew=pandaImageNew;
        elephant.imageNew=elephantImageNew;
           
       });
    
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buttonTapped:(id)sender
{
    UIButton *buttonTapped=(UIButton*)sender;
    [animalName setText: ((Animal*)[animals objectAtIndex:buttonTapped.tag]).name];
    
    
}
-(void)buttonToChange:(id)sender
{
    double width=[[UIScreen mainScreen] bounds].size.width;
    double height=[[UIScreen mainScreen] bounds].size.height;
    
    UIButton *buttonToChange=(UIButton*)sender;
    UIImageView *imageView;
    imageView=[[UIImageView alloc] initWithFrame:CGRectMake(30+width*(buttonToChange.tag),height*0.157,  width*0.813, height*0.457)];
    
      imageView.image=((Animal*)[animals objectAtIndex:buttonToChange.tag]).imageNew;
      [scroll addSubview:imageView];
    
    if (((Animal*)[animals objectAtIndex:buttonToChange.tag]).imageNew==NULL)
        
    { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please wait for a second"
                                                        message:@"I am still downloading the image..." delegate:self cancelButtonTitle: @"OK" otherButtonTitles:nil, nil];
    
        [alert show];}
    
}


@end
