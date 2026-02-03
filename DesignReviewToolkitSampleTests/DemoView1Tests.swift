//
//  Copyright © nthState Ltd. 2026. All rights reserved.
//

import SwiftUI
import Testing
import DesignReviewToolkitSample
import DesignReviewToolkit

@MainActor
class DemoView1Tests {
  
  let testingRoot = URL(fileURLWithPath: "/Users/chrisdavis/Developer/DesignReviewToolkitSample/DesignFilesOutput")
  let configuration: Configuration
  let isRecording: Bool = false

  init() throws {
    self.configuration = Configuration(showStyle: true)
  }

  @Test(.tags(.diff)) func `DemoView1 Annotated`() async throws {

    let view = DemoView1()
    
    let generator = Generator(configuration: self.configuration)
    
    let temp: URL? = isRecording ? testingRoot.appending(path: "DemoView1.png") : nil
    let image = try await generator.generate(from: view, write: temp)
    
    let comparisonImageURL = testingRoot.appending(path: "DemoView1.png")
    let imagesMatch = try await generator.hasMatchingData(image, to: comparisonImageURL)
    
    #expect(imagesMatch)
  }
  
  @Test(.tags(.run_manually), arguments: AccessibilityType.allCases) func `DemoView1 Generate`(_ accessibility: AccessibilityType) async throws {

    let view = DemoView1()
    
    let generator = Generator(configuration: .init(showStyle: false, includeAccessibility: [accessibility], convergeLines: true))
    
    let temp: URL? = isRecording ? testingRoot.appending(path: "DemoView1.png") : nil
    let image = try await generator.generate(from: view, write: temp)

    #expect(image.width > 0 && image.height > 0)
  }
  
}
