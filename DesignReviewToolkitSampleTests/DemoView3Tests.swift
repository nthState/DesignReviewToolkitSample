//
//  Copyright © nthState Ltd. 2026. All rights reserved.
//

import SwiftUI
import Testing
import DesignReviewToolkitSample
import DesignReviewToolkit

@MainActor
class DemoView3Tests {
  
  let testingBundle = Bundle(for: DemoView3Tests.self)
  let configuration: Configuration
  let isRecording: Bool = false

  init() throws {
    self.configuration = Configuration(showStyle: true)
  }

  @Test(.tags(.diff)) func `DemoView3 Annotated`() async throws {

    let view = DemoView3()
    
    let generator = Generator(configuration: self.configuration)
    
    let temp: URL? = isRecording ? FileManager.default.temporaryDirectory.appending(path: "DemoView3.png") : nil
    let image = try await generator.generate(from: view, write: temp)
    
    let comparisonImageURL = try #require(testingBundle.url(forResource: "DemoView3", withExtension: "png"), "Couldn't find png")
    let imagesMatch = try await generator.isVisuallyEqual(image, to: comparisonImageURL)
    
    #expect(imagesMatch)
  }
  
  @Test(.tags(.run_manually), arguments: AccessibilityType.allCases) func `DemoView3 Generate`(_ accessibility: AccessibilityType) async throws {

    let view = DemoView3()
    
    let generator = Generator(configuration: .init(showStyle: false, includeAccessibility: [accessibility]))
    
    let temp: URL? = isRecording ? FileManager.default.temporaryDirectory.appending(path: "DemoView3.png") : nil
    let image = try await generator.generate(from: view, write: temp)

    #expect(image.width > 0 && image.height > 0)
  }
  
}

