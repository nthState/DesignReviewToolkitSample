#
#  Copyright © nthState Ltd. 2026. All rights reserved.
#

.PHONY: help
help:
	@echo "Available commands:"
	@echo "make help             - Show help"
	@echo "make run              - Create screenshots"

# This is an example of running DesignReviewToolkit DesignReviewToolkit
.PHONY: run
run:
  #	git clone https://github.com/nthState/DesignReviewToolkit.git
	swift run --package-path /Users/chrisdavis/Developer/DesignReviewToolkit/Source/DesignReviewToolkitCLI DesignReviewToolkitCLI pre-process files "DesignReviewToolkitSample/DemoView1.swift" "DesignReviewToolkitSample/DemoView2.swift" "DesignReviewToolkitSample/DemoView3.swift"
	rc=0; xcodebuild clean test -project "DesignReviewToolkitSample.xcodeproj" -scheme "DesignReviewToolkitSample" -destination "platform=iOS Simulator,name=iPhone 17 Pro Max,OS=latest" || rc=$$?; \
	swift run --package-path /Users/chrisdavis/Developer/DesignReviewToolkit/Source/DesignReviewToolkitCLI DesignReviewToolkitCLI clean files "DesignReviewToolkitSample/DemoView1.swift" "DesignReviewToolkitSample/DemoView2.swift" "DesignReviewToolkitSample/DemoView3.swift"; \
	exit $$rc

