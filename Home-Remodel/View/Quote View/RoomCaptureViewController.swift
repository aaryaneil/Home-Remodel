/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The sample app's main view controller that manages the scanning process.
*/

import UIKit
import RoomPlan
import Foundation
import ModelIO
import SceneKit
import ARKit

class RoomCaptureViewController: UIViewController, ARSessionDelegate {
    
    @IBOutlet var exportButton: UIButton?
    
    @IBOutlet var doneButton: UIBarButtonItem?
    @IBOutlet var cancelButton: UIBarButtonItem?
    
    private var isScanning: Bool = false
    
    private var roomCaptureView: RoomCaptureView!
    private var roomCaptureSessionConfig: RoomCaptureSession.Configuration = RoomCaptureSession.Configuration()
    
    private var finalResults: CapturedRoom?
    
    var sceneView: ARSCNView!
    var pointCloud: ARPointCloud!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Started home scanning")

        
        // Create ARSCNView and add it as a subview
        sceneView = ARSCNView(frame: view.bounds)
        view.addSubview(sceneView)
        
        // Configure AR session
        let configuration = ARWorldTrackingConfiguration()
        configuration.sceneReconstruction = .meshWithClassification
        
        // Enable LIDAR sensor if available
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.meshWithClassification) {
            configuration.environmentTexturing = .automatic
        }
        
        isScanning = true
        
        // Set AR session delegate
        sceneView.session.delegate = self
        
        // Run the AR session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
        exportPointCloudButtonTapped()
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // Update point cloud data
        pointCloud = frame.rawFeaturePoints
    }
    
    func exportPointCloudButtonTapped() {
        guard let pointCloud = pointCloud else {
            print("No point cloud data available.")
            return
        }
        
        // Export point cloud data as a text file
        let pointCloudText = pointCloud.points.map { "\($0.x),\($0.y),\($0.z)" }.joined(separator: "\n")
        
        // Save point cloud text to a file
        let fileName = "point_cloud.txt"
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            do {
                try pointCloudText.write(to: fileURL, atomically: true, encoding: .utf8)
                print("Point cloud data exported successfully. File path: \(fileURL.path)")
                exportResults(path: fileURL.absoluteString)
            } catch {
                print("Error exporting point cloud data: \(error.localizedDescription)")
            }
        }
    }
    
    // Decide to post-process and show the final results.
    func captureView(shouldPresent roomDataForProcessing: CapturedRoomData, error: Error?) -> Bool {
        return true
    }
    
    // Access the final post-processed results.
    func captureView(didPresent processedResult: CapturedRoom, error: Error?) {
        finalResults = processedResult
    }
    
    @IBAction func doneScanning(_ sender: UIBarButtonItem) {
        if isScanning {
            sceneView.session.pause()
            exportPointCloudButtonTapped()
            QuoteView()

        } else {
            cancelScanning(sender)
        }
    }

    @IBAction func cancelScanning(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
    
    // Export the USDZ output by specifying the `.parametric` export option.
    // Alternatively, `.mesh` exports a nonparametric file and `.all`
    // exports both in a single USDZ.
    func exportResults(path: String) {
        let destinationURL = FileManager.default.temporaryDirectory.appending(path: path)
        do {
            try finalResults?.export(to: destinationURL, exportOptions: .mesh)
            
            let activityVC = UIActivityViewController(activityItems: [destinationURL], applicationActivities: nil)
            activityVC.modalPresentationStyle = .popover
            
            present(activityVC, animated: true, completion: nil)
            if let popOver = activityVC.popoverPresentationController {
                popOver.sourceView = self.exportButton
            }
        } catch {
            print("Error = \(error)")
        }
    }
    
    private func setActiveNavBar() {
        UIView.animate(withDuration: 1.0, animations: {
            self.cancelButton?.tintColor = .white
            self.doneButton?.tintColor = .white
            self.exportButton?.alpha = 0.0
        }, completion: { complete in
            self.exportButton?.isHidden = true
        })
    }
    
    private func setCompleteNavBar() {
        self.exportButton?.isHidden = false
        UIView.animate(withDuration: 1.0) {
            self.cancelButton?.tintColor = .systemBlue
            self.doneButton?.tintColor = .systemBlue
            self.exportButton?.alpha = 1.0
        }
    }
}

