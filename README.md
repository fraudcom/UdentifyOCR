# UdentifyOCR

A proprietary iOS SDK for document verification featuring OCR (Optical Character Recognition), hologram detection, and document liveness checks.

[![Swift Version](https://img.shields.io/badge/Swift-5.5+-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS-blue.svg)](https://www.apple.com/ios/)
[![License](https://img.shields.io/badge/License-Proprietary-red.svg)](LICENSE)

## Overview

**UdentifyOCR** is a comprehensive document verification SDK developed by Fraud.com International LTD. It provides advanced capabilities for identity document verification, including:

- **OCR (Optical Character Recognition)**: Extract text and data from identity documents
- **Hologram Detection**: Verify the authenticity of document holograms
- **Document Liveness**: Ensure documents are physically present and not photos of photos

## Features

### 🎯 OCR Document Scanning
- Support for ID cards and driver's licenses
- Front and back side scanning
- Real-time document detection and alignment guidance
- Automatic image quality assessment (IQA)
- Manual and automatic capture modes
- Cropped and full-resolution image outputs

### 🌈 Hologram Verification
- Video-based hologram capture
- Automatic torch control for optimal lighting
- Multi-segment video recording
- Advanced security checks

### 📱 Document Liveness Detection
Document Liveness Detection is a system that verifies whether the submitted document is a genuine and original document. It detects spoofing attempts such as photo, video, or 3D mask-based attacks.

## Requirements

- iOS 13.0+
- Xcode 26.1.1
- Swift 5.5+
- Camera permissions

## Installation

### Swift Package Manager (SPM)

To integrate UdentifyOCR into your project using Swift Package Manager:

1. In Xcode, select **File > Add Packages...**

2. Enter the repository URL:
   ```
   https://github.com/fraudcom/UdentifyOCR
   ```

3. Select the version or branch you want to use

4. Click **Add Package**

Alternatively, you can add it to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/fraudcom/UdentifyOCR", .upToNextMajor(from: "1.0.0"))
]
```

And add it to your target dependencies:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["UdentifyOCR"]
    )
]
```

## Quick Start

### 1. Import the SDK

```swift
import UdentifyOCR
import UdentifyCommons
```

### 2. Request Camera Permissions

Add the following keys to your `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>We need camera access to scan your identity document</string>
```

## Usage

### OCR Document Scanning

#### Basic Implementation

```swift
import UIKit
import UdentifyOCR
import UdentifyCommons

class DocumentScanViewController: UIViewController {
    private var cameraController: OCRCameraViewController?
    
    func startOCRScanning() {
        // Initialize OCR camera controller
        guard let ocrController = OCRCameraViewController.instantiate(
            withApiCallDisabled: self,
            serverURL: "https://your-server.com",
            transactionID: "TRX...",
            documentType: .ID_CARD,
            country: .TUR,
            documentSide: .bothSides
        ) else {
            print("Failed to instantiate OCR controller")
            return
        }

        OCRSettingsProvider.getInstance().currentSettings = OcrCameraSettings()

        self.cameraController = ocrController

        // set options before showing
        ocrController.modalPresentationStyle = .fullScreen
        
        // Present the controller
        navigationController?.pushViewController(ocrController, animated: true)
        // Or
        // present(ocrController, animated: true)
    }
}

// MARK: - OCRCameraControllerDelegate
extension DocumentScanViewController: OCRCameraControllerDelegate {
    
    func onDocumentScan(for side: OCRDocumentSide, payload: DocumentScanPayload, croppedImages: (front: UIImage?, back: UIImage?)) {
        print("Document scanned for side: \(side)")
        
        // Access captured images
        if let frontImage = croppedImages.front {
            print("Front image captured: \(frontImage.size)")
        }
        
        if let backImage = croppedImages.back {
            print("Back image captured: \(backImage.size)")
        }
        
        // Process the payload based on type
        switch payload {
        case .images(front: let front, back: let back):
            print("Received \(images.count) images")
        case .imagePaths(let paths):
            print("Received \(paths.count) image paths")
        }
    }
    
    func onSuccess(response: OCRResponse) {
    }
    
    func onFailure(error: Error) {
    }
    
    func onIqaResult(for side: OCRDocumentSide, iqaFeedback: IQAFeedback, iqaResponse: IQAResponse?) {
        print("Image quality assessment for \(side): \(iqaFeedback)")
        // Handle IQA results
    }
    
    func onOCRDirectiveChanged(directive: OCRDirective) {
        print("OCR directive changed: \(directive)")
        // Update UI or perform TTS based on directive
    }
    
    func onBackButtonPressed(at controllerType: ControllerType) {
        print("Back button pressed")
        // Handle back navigation
    }
    
    func didFinishOcrAndDocumentLivenessCheck(response: OCRAndDocumentLivenessResponse) {
        print("OCR and liveness check completed")
        // Process combined results
    }
    
    func onDestroy(controllerType: ControllerType) {
        print("Controller destroyed")
    }
    
    func willDismiss(controllerType: ControllerType) {
        print("Controller will dismiss")
    }
    
    func didDismiss(controllerType: ControllerType) {
        print("Controller dismissed")
    }
}
```

#### Document Types

```swift
// Supported document types
.ID_CARD         // National ID card
.PASSPORT        // Passport
.DRIVER_LICENSE  // Driver's license
```

#### Scan Modes

```swift
// Scan both sides of the document
documentSide: .bothSides

// Scan front side only
documentSide: .frontSide

// Scan back side only
documentSide: .backSide
```

#### Capture Modes

```swift
// Automatic capture (recommended)
manualCapture: false

// Manual capture - user taps to capture
manualCapture: true
```

### Hologram Verification

#### Basic Implementation

```swift
import UIKit
import UdentifyOCR
import UdentifyCommons

class HologramVerificationViewController: UIViewController {

    private var cameraController: HologramCameraViewController?
    
    func startHologramVerification() {
        // Initialize hologram camera controller
        guard let hologramController = HologramCameraViewController.instantiate(
            delegate: self,
            serverURL: "https://your-server.com",
            transactionID: "TRX..."
        ) else {
            print("Failed to instantiate hologram controller")
            return
        }
            
        self.cameraController = hologramController
            
        OCRSettingsProvider.getInstance().currentSettings = OcrCameraSettings()
            
        // set options before showing
        hologramController.modalPresentationStyle = .fullScreen
        
        // Present the controller
        navigationController?.pushViewController(hologramController, animated: true)
    }
}

// MARK: - HologramCameraControllerDelegate
extension HologramVerificationViewController: HologramCameraControllerDelegate {
    
    func onVideoRecordFinished(videoUrls: [URL]) {
        print("Hologram videos recorded: \(videoUrls.count)")
        
        // Upload videos for verification
        HologramCameraViewController.uploadHologramVideo(
            serverURL: "https://your-server.com",
            transactionID: "TRX...",
            paths: videoUrls,
            requestTimeout: 30
        ) { response in
            if let error = response.error {
                print("Hologram verification failed: \(error.localizedDescription)")
            } else {
                print("Hologram exists: \(response.hologramExists)")
                print("ID matches OCR: \(response.ocrIdAndHologramIdMatch)")
                print("Face matches OCR: \(response.ocrFaceAndHologramFaceMatch)")
                
                if let hologramFace = response.hologramFaceImage {
                    print("Hologram face extracted: \(hologramFace.size)")
                }
            }
        }
    }
    
    func onHologramDirectiveChanged(directive: HologramDirective) {
        print("Hologram directive changed: \(directive)")
        // Update UI based on directive
    }
    
    func onFailure(error: Error) {
        print("Hologram verification failed: \(error.localizedDescription)")
    }
    
    func onBackButtonPressed(at controllerType: ControllerType) {
        print("Back button pressed")
    }
    
    func onDestroy(controllerType: ControllerType) {
        print("Controller destroyed")
    }
    
    func willDismiss(controllerType: ControllerType) {
        print("Controller will dismiss")
    }
    
    func didDismiss(controllerType: ControllerType) {
        print("Controller dismissed")
    }
}
```

## Customization

### UI Customization

The SDK provides extensive UI customization through `OCRSettings`:

```swift
import UdentifyOCR

// Get the settings provider instance
let settingsProvider = OCRSettingsProvider.getInstance()

// Customize appearance
var settings = settingsProvider.currentSettings

// Update settings as needed
settings.configs.footerViewStyle.backgroundColor = .systemBlue
settings.configs.buttonBackColor = .white
settings.configs.placeholderContainerStyle.borderColor = .green

// Apply settings
settingsProvider.updateSettings(settings)
```

### Logging

Configure logging levels for debugging:

```swift
// Available log levels:
.verbose   // Most detailed
.debug     // Debug information
.info      // General information
.warning   // Warnings only
.error     // Errors only
.none      // No logging
```

## API Reference

### OCRCameraViewController

```swift
public static func instantiate(
    withApiCallDisabled delegate: OCRCameraControllerDelegate?,
    serverURL: String,
    transactionID: String,
    documentType: OCRDocumentType,
    country: UdentifyCommons.Country? = nil,
    documentSide: OCRDocumentSide = .bothSides,
    manualCapture: Bool = false,
    logLevel: LogLevel = .warning
) -> OCRCameraViewController?
```

### HologramCameraViewController

```swift
public static func instantiate(
    delegate: HologramCameraControllerDelegate?,
    serverURL: String,
    transactionID: String,
    country: UdentifyCommons.Country? = nil,
    logLevel: LogLevel = .warning
) -> HologramCameraViewController?

public static func uploadHologramVideo(
    serverURL: String,
    transactionID: String,
    paths: [URL],
    requestTimeout: Double = 30,
    completion: @escaping (HologramResponse) -> Void
)
```

## Best Practices

1. **Transaction IDs**: Use unique transaction IDs for each verification session to track operations server-side

2. **Error Handling**: Always implement proper error handling in delegate methods

3. **Memory Management**: The SDK automatically manages camera resources and memory. Ensure you don't hold strong references to controllers

4. **User Experience**: 
   - Enable automatic capture mode for better UX (default)
   - Use manual capture only when necessary
   - Provide clear instructions to users

5. **Server Integration**: Ensure your backend is configured to handle OCR, liveness, and hologram verification requests

6. **Testing**: Test with various document types and lighting conditions

## Troubleshooting

### Common Issues

**Camera not starting**
- Verify camera permissions are granted
- Check that you're running on a physical device (not simulator)
- Ensure the device has a camera

**OCR accuracy issues**
- Ensure good lighting conditions
- Keep the document flat and within the guide frame
- Wait for the green border indicating optimal position
- Calibrate **blurCoefficient** according to your needs. The blurCoefficient is a threshold value ranging from -1 to 1 that determines the level of blurriness in the captured image. If the blurriness ratio of the image is above this threshold, the image is considered non-blurry and processed. Conversely, if the blurriness ratio is below this value, the image is deemed blurry and not processed. The default value is 0.0, where approaching -1 makes the system less selective, and approaching 1 makes it more selective by only accepting sharper images. A value of -1 disables blurriness detection.

**Hologram verification fails**
- Ensure proper lighting for hologram visibility
- Check network connectivity for video upload

## Support

For support, licensing inquiries, or technical questions:

- **Email**: support@fraud.com
- **Documentation**: Contact your account representative

## License

UdentifyOCR is proprietary software. Copyright © 2026 Fraud.com International Ltd. All rights reserved. See the [LICENSE](LICENSE) file for more info.

