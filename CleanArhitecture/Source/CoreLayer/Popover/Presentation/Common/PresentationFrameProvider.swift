//
//  PresentationFrameProvider.swift
//  CleanArhitecture
//
//  Created by Pavel Kochenda on 13.11.2020.
//  Copyright © 2020 IA. All rights reserved.
//

import UIKit

// MARK: - PresentationFrameProvider

typealias FrameOfPresentedViewClosure = ((_ containerViewFrame: CGRect) throws -> CGRect)?

protocol PresentationFrameProvider {
    var frameOfPresentedViewClosure: FrameOfPresentedViewClosure { get set }
}

// MARK: - PresentationExpandableFrameProvider

typealias FrameOfExpandablePresentedViewClosure = ((_ containerViewFrame: CGRect, _ expandStep: UInt8) throws -> CGRect)?

class ExpandablePopoverFrameMeta {
    internal init(expandSteps: [CGRect] = [], currentExpandStep: UInt8 = 0, blockDismissOnPanGesture: Bool = true, tweakExpandableFrameCommands: [TweakPopoverCommand] = []) {
        self.expandSteps = expandSteps
        self.currentExpandStep = currentExpandStep
        self.blockDismissOnPanGesture = blockDismissOnPanGesture
        self.tweakExpandableFrameCommands = tweakExpandableFrameCommands
    }
    
    var tweakExpandableFrameCommands: [TweakPopoverCommand]
    var expandSteps: [CGRect] = []
    var currentExpandStep: UInt8 = 0
    var blockDismissOnPanGesture: Bool = true
}

protocol PresentationExpandableFrameProvider {
    var expandablePopoverFrameMeta: ExpandablePopoverFrameMeta { get set }
    var frameOfExpandablePresentedViewClosure: FrameOfExpandablePresentedViewClosure { get set }
    func getMaximumExpandFrameHeight(forContainerView containerView: UIView) -> CGFloat
}


class WeakSet<T: AnyObject>: Sequence, ExpressibleByArrayLiteral, CustomStringConvertible, CustomDebugStringConvertible {

   private var objects = NSHashTable<T>.weakObjects()

   public init(_ objects: [T]) {
       for object in objects {
           insert(object)
       }
   }

   public convenience required init(arrayLiteral elements: T...) {
       self.init(elements)
   }

   public var allObjects: [T] {
       return objects.allObjects
   }

   public var count: Int {
       return objects.count
   }

   public func contains(_ object: T) -> Bool {
       return objects.contains(object)
   }

   public func insert(_ object: T) {
       objects.add(object)
   }

   public func remove(_ object: T) {
       objects.remove(object)
   }

   public func makeIterator() -> AnyIterator<T> {
       let iterator = objects.objectEnumerator()
       return AnyIterator {
           return iterator.nextObject() as? T
       }
   }

   public var description: String {
       return objects.description
   }

   public var debugDescription: String {
       return objects.debugDescription
   }
}
