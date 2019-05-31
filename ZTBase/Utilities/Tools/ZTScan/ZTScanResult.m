


#import "ZTScanResult.h"

AVMetadataObjectType const AVMetadataObjectTypePlateNumber = @"AVMetadataObjectTypePlateNumber";

@implementation ZTScanResult

- (instancetype)initWithScanString:(NSString*)str imgScan:(UIImage*)img barCodeType:(NSString*)type
{
    if (self = [super init]) {
        self.strScanned = str;
        self.imgScanned = img;
        self.strBarCodeType = type;
    }
    
    return self;
}

@end

