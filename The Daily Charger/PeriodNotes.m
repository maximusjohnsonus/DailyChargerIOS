//
//  PeriodNotes.m
//  The Daily Charger
//


#import "PeriodNotes.h"
#import "CustomMethods.h"
#import "KeyDefinitions.h"

@interface PeriodNotes ()

@end

@implementation PeriodNotes
- (id)initWithIndex:(NSIndexPath *)index host:(DayView *)host notes:(NSString *)notes{
    self = [super init];
    if(self){
        self.host = host; //dayView to refresh when done
        self.index = index; //dayIndex
        self.notes = notes;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSString *text = [[CustomMethods getNotesForDay:self.index.section] valueForKey:[NSString stringWithFormat:@"%d",self.index.row]];
    if(!self.notes){
        self.notesEdit.text = placeHolderText;
        self.notesEdit.textColor = [UIColor lightGrayColor];
    } else {
        self.notesEdit.text = self.notes;
        self.notesEdit.textColor = [UIColor blackColor];

    }
}

- (IBAction)doneTapped:(UIButton *)sender{
    NSString *note = self.notesEdit.text;
    if([note isEqualToString:placeHolderText])
        note=nil;
    [CustomMethods updateNoteTo:note forPath:self.index];
    [self.host refreshIndex:[NSIndexPath indexPathForRow:self.index.row inSection:0] withNewNote:note];
    [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}


//Placeholder text
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:placeHolderText]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}
- (void)textViewDidEndEditing:(UITextView *)textView {

    if ([textView.text isEqualToString:@""]) {
        textView.text = placeHolderText;
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
