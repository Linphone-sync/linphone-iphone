//
//  Settings.m
//  linphone
//
//  Created by Guillaume BIENKOWSKI on 11/07/2014.
//
//

#import <Subliminal/Subliminal.h>
#import "BaseTestsUtils.h"

@interface Settings : BaseTestsUtils

@end

@implementation Settings

// keep the '\n' at the end, they ensure the keyboard is dismissed
static NSString* const test_username = @"testios\n";
static NSString* const test_password = @"testtest\n";
static NSString* const test_server   = @"sip.linphone.org\n";
static NSString* const test_route    = @"sip.linphone.org\n";

- (void)setUpTest {
}

- (void)tearDownTest {
}

- (void)clearUsingWizard {
    //go to wizard and back to clear all config
    [self addWizardPopupHandler];
    
    [self goToSettings];
    
    SLElement* wizardButton = [SLElement elementWithAccessibilityLabel:@"Run assistant"];
    [wizardButton tap];
    [self wait:3];
    [self exitWizardIfNecessary];
    [self wait:1];
    
}

-(void)RegistrationThroughSettings:(NSString*)transportType {
    [self exitWizardIfNecessary];
    
    [self clearUsingWizard];
    
    [self goToSettings];
    
    {
        
        SLElement* username  = [SLElement elementWithAccessibilityLabel:@"User name"];
        SLElement* password  = [SLElement elementWithAccessibilityLabel:@"Password"];
        SLElement* domain    = [SLElement elementWithAccessibilityLabel:@"Domain"];
        SLElement* proxy     = [SLElement elementWithAccessibilityLabel:@"Proxy"];
        SLElement* transport = [SLElement elementMatching:^BOOL(NSObject *obj) {
            if([[obj accessibilityLabel] hasPrefix:@"Transport"]) return TRUE;
            else return FALSE;
        }
                                          withDescription:@"Transport"];
        
        [username tap];
        [[SLKeyboard keyboard] typeString:test_username];
        
        [password tap];
        [[SLKeyboard keyboard] typeString:test_password];
        
        [domain tap];
        [[SLKeyboard keyboard] typeString:test_server];
        
        [proxy tap];
        [[SLKeyboard keyboard] typeString:test_route];
        
        // select transport and come back
        [transport tap];
        SLElement* type = [SLElement elementWithAccessibilityLabel:transportType];
        [type tap];
        
        SLElement* backToSettings = [SLElement elementMatching:^BOOL(NSObject *obj) {
            if( [obj.accessibilityLabel isEqualToString:@"Settings"] &&
               (obj.accessibilityTraits & UIAccessibilityTraitSelected) == 0 ){
                return TRUE;
            } else return FALSE;
        } withDescription:@"Back to settings"];
        [backToSettings tap];
        
    }
    
    // back to dialer
    SLElement* dialerButton = [SLElement elementWithAccessibilityLabel:@"Dialer"];
    [dialerButton tap];
    [self checkIsRegisteredWithDelay:20];
    
}

// fast multi-transport test
-(void)testRegistrationThroughMultipleTransports {
    
    // first "long" version
    [self RegistrationThroughSettings:@"UDP"];
    
    [self goToSettings];
    
    // the fast transport change
    
    {
        // select transport TCP and come back
        SLElement* transport = [SLElement elementMatching:^BOOL(NSObject *obj) {
            if([[obj accessibilityLabel] hasPrefix:@"Transport"]) return TRUE;
            else return FALSE;
        }
                                          withDescription:@"Transport"];
        [transport tap];
        SLElement* type = [SLElement elementWithAccessibilityLabel:@"TCP"];
        [type tap];
        
        SLElement* backToSettings = [SLElement elementMatching:^BOOL(NSObject *obj) {
            if( [obj.accessibilityLabel isEqualToString:@"Settings"] &&
               (obj.accessibilityTraits & UIAccessibilityTraitSelected) == 0 ){
                return TRUE;
            } else return FALSE;
        } withDescription:@"Back to settings"];
        [backToSettings tap];
        
        // back to dialer
        SLElement* dialerButton = [SLElement elementWithAccessibilityLabel:@"Dialer"];
        [dialerButton tap];
        [self checkIsRegisteredWithDelay:20];
    }
    
    [self goToSettings];

    // select transport TLS and come back
    {
        SLElement* transport = [SLElement elementMatching:^BOOL(NSObject *obj) {
            if([[obj accessibilityLabel] hasPrefix:@"Transport"]) return TRUE;
            else return FALSE;
        }
                                          withDescription:@"Transport"];
        [transport tap];
        SLElement* type = [SLElement elementWithAccessibilityLabel:@"TLS"];
        [type tap];
        
        SLElement* backToSettings = [SLElement elementMatching:^BOOL(NSObject *obj) {
            if( [obj.accessibilityLabel isEqualToString:@"Settings"] &&
               (obj.accessibilityTraits & UIAccessibilityTraitSelected) == 0 ){
                return TRUE;
            } else return FALSE;
        } withDescription:@"Back to settings"];
        [backToSettings tap];
        
        // back to dialer
        SLElement* dialerButton = [SLElement elementWithAccessibilityLabel:@"Dialer"];
        [dialerButton tap];
        [self checkIsRegisteredWithDelay:20];
    }


    
}
//
//-(void)testUDPRegistrationThroughSettings {
//    [self RegistrationThroughSettings:@"UDP"];
//}
//
//-(void)testTCPRegistrationThroughSettings {
//    [self RegistrationThroughSettings:@"TCP"];
//}
//
//-(void)testTLSRegistrationThroughSettings {
//    [self RegistrationThroughSettings:@"TLS"];
//}
@end
