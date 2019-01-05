//
//  EmptyStateProvider.swift
//  CollectionKit
//
//  Created by Luke Zhao on 2017-08-08.
//  Copyright © 2017 lkzhao. All rights reserved.
//

import UIKit

public class EmptyStateProvider: ComposedProvider {
  public var emptyStateView: UIView?
  public var emptyStateViewGetter: () -> UIView
  public var contentProvider: Provider
  public var emptyStateViewSectionIdentifier: String = "emptyStateView"

  public init(identifier: String? = nil,
              emptyStateView: @autoclosure @escaping () -> UIView,
              content: Provider) {
    self.emptyStateViewGetter = emptyStateView
    self.contentProvider = content
    super.init(identifier: identifier,
               layout: RowLayout(emptyStateViewSectionIdentifier).transposed(),
               sections: [content])
  }

  public override func willReload() {
    contentProvider.willReload()
    if contentProvider.numberOfItems == 0, sections.first?.identifier != emptyStateViewSectionIdentifier {
      if emptyStateView == nil {
        emptyStateView = emptyStateViewGetter()
      }
      let viewSection = SimpleViewProvider(
        identifier: "emptyStateView",
        views: [emptyStateView!],
        sizeStrategy: (.fill, .fill)
      )
      sections = [viewSection]
      super.willReload()
    } else if contentProvider.numberOfItems > 0, sections.first?.identifier == emptyStateViewSectionIdentifier {
      sections = [contentProvider]
    } else {
      super.willReload()
    }
  }

  public override func hasReloadable(_ reloadable: CollectionReloadable) -> Bool {
    return super.hasReloadable(reloadable) || contentProvider.hasReloadable(reloadable)
  }
}
