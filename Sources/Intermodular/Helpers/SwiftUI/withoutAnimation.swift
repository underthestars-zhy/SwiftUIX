//
// Copyright (c) Vatsal Manot
//

import Swift
import SwiftUI

var _areAnimationsDisabledGlobally: Bool = false

/// Returns the result of recomputing the view’s body with animations disabled.
public func withoutAnimation(_ flag: Bool = true, _ body: () -> ()) {
    guard flag else {
        return body()
    }
    
    _areAnimationsDisabledGlobally = true
    
    withAnimation(.none) {
        body()
    }
    
    _areAnimationsDisabledGlobally = false
}

func _withoutAnimation(_ flag: Bool = true, _ body: () -> ()) {
    guard flag else {
        return body()
    }
    
    withAnimation(.none) {
        body()
    }
}

func _withoutAnimation_AppKitOrUIKit(_ flag: Bool = true, _ body: () -> ()) {
    guard flag else {
        return body()
    }
    
#if os(iOS)
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    body()
    CATransaction.commit()
#else
    body()
#endif
}

public func withAnimation(
    _ animation: Animation = .default,
    after delay: DispatchTimeInterval,
    body: @escaping () -> Void
) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        withAnimation(animation) {
            body()
        }
    }
}
