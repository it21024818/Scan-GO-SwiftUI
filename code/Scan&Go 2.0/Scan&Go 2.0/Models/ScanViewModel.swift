//
//  ScanViewModel.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 5/27/24.
//

import AVKit
import Foundation
import SwiftUI
import VisionKit

// Enum defining different types of scans
enum ScanType: String {
    case barcode, text
}

// Enum defining different types of data scanner access status
enum DataScannerAccessStatusType {
    case notDetermined
    case cameraAccessNotGranted
    case cameraNotAvailable
    case scannerAvailable
    case scannerNotAvailable
}

// ViewModel for handling scanning functionality
@MainActor
final class ScanViewModel: ObservableObject {
    
    // Published properties to update UI
    @Published var dataScannerAccessStatus: DataScannerAccessStatusType = .notDetermined
    @Published var recognizedItems: [RecognizedItem] = []
    @Published var scanType: ScanType = .barcode
    @Published var textContentType: DataScannerViewController.TextContentType?
    @Published var recognizesMultipleItems = true
    
    // Computed property to determine the recognized data type based on scan type
    var recognizedDataType: DataScannerViewController.RecognizedDataType {
        scanType == .barcode ? .barcode() : .text(textContentType: textContentType)
    }
    
    // Computed property to generate unique identifier for the data scanner view
    var dataScannerViewId: Int {
        var hasher = Hasher()
        hasher.combine(scanType)
        hasher.combine(recognizesMultipleItems)
        if let textContentType {
            hasher.combine(textContentType)
        }
        return hasher.finalize()
    }
    
    // Header text to display
    var headerText: String {
        switch scanType {
        case .barcode:
            return "Scanning for barcodes"
        case .text:
            return "Scanning for text"
        }
    }
    
    // Private property to check if scanner is available
    private var isScannerAvailable: Bool {
        DataScannerViewController.isAvailable && DataScannerViewController.isSupported
    }
    
    // Method to request data scanner access status asynchronously
    func requestDataScannerAccessStatus() async {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            dataScannerAccessStatus = .cameraNotAvailable
            return
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
        case .authorized:
            dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
            
        case .restricted, .denied:
            dataScannerAccessStatus = .cameraAccessNotGranted
            
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            if granted {
                dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
            } else {
                dataScannerAccessStatus = .cameraAccessNotGranted
            }
        
        default: break
            
        }
    }
}
