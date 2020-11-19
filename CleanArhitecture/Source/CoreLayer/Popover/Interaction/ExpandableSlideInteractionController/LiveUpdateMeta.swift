//
//  LiveUpdateMeta.swift
//  CleanArhitecture
//
//  Created by Pavel Kochenda on 19.11.2020.
//  Copyright © 2020 IA. All rights reserved.
//

struct ScrollViewMeta {
    var scrollViewReachedBottom: Bool = false
    var scrollViewReachedTopOnPanBegan = false
    var scrollViewYOffset: CGFloat = 0.0
    var expandLimitReachead: Bool = false
}

struct LiveUpdateMeta {
    var currentLiveUpdateError: LiveUpdateError?
    var direction: Direction?
    var presentedViewIsFullExpanded: Bool = false
    var scrollViewMeta = ScrollViewMeta()
    
    private var panBeganPresentedFrameHeight: CGFloat!
    private var panEndPresentedFrameHeight: CGFloat!
    
    mutating func update(
        _ recognizer: UIPanGestureRecognizer,
        presentedViewController: ExpandablePopoverViewController
    ) {
        presentedViewIsFullExpanded = presentedViewController.view.frame.height > 550
        switch recognizer.state {
        case .began:
            currentLiveUpdateError = nil
            direction = nil
            self.scrollViewMeta.scrollViewReachedTopOnPanBegan = scrollViewMeta.scrollViewYOffset < 1
            self.panBeganPresentedFrameHeight = presentedViewController.view.frame.height
        case .changed:
            direction = recognizer.velocity(in: presentedViewController.view).y < 0 ? .top : .bottom
        case .ended:
            self.panEndPresentedFrameHeight = presentedViewController.view.frame.height
            direction = self.panBeganPresentedFrameHeight < self.panEndPresentedFrameHeight ? .top : .bottom
        default:
            break
        }
    }
}
