//
//  Copyright © nthState Ltd. 2026. All rights reserved.
//

import SwiftUI
import Testing
import DesignReviewToolkitSample
import DesignReviewToolkit

@MainActor
class DemoView2Tests {
  
  let testingBundle = Bundle(for: DemoView2Tests.self)
  let configuration: Configuration
  let isRecording: Bool = true

  init() throws {
    self.configuration = Configuration(showStyle: true)
  }

  @Test(.tags(.diff)) func `DemoView2 Annotated`() async throws {

    let view = DemoView2()
    
    let generator = Generator(configuration: self.configuration)
    
    let temp: URL? = isRecording ? FileManager.default.temporaryDirectory.appending(path: "DemoView2.png") : nil
    let image = try await generator.generate(from: view, write: temp)
    
    let comparisonImageURL = try #require(testingBundle.url(forResource: "DemoView2", withExtension: "png"), "Couldn't find png")
    let imagesMatch = try await generator.isVisuallyEqual(image, to: comparisonImageURL)
    
    #expect(imagesMatch)
  }
  
  @Test(.tags(.generation)) func `DemoView2 Output`() async throws {

    let view = DemoView2()
    
    let generator = Generator(configuration: self.configuration)
    
    let output = URL(fileURLWithPath: #file).deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("Output/DemoView2.png")
    let _ = try await generator.generate(from: view, write: output)
  }

}
