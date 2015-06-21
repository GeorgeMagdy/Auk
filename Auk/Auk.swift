import UIKit

final class Auk: AukInterface {
  private weak var scrollView: UIScrollView?
  var settings = AukSettings()

  init(scrollView: UIScrollView) {
    self.scrollView = scrollView
  }
  
  func setup() {
    scrollView?.showsHorizontalScrollIndicator = settings.showsHorizontalScrollIndicator
    scrollView?.pagingEnabled = settings.pagingEnabled
  }
  
  func show(#image: UIImage) {
    setup()
    let page = createPage()
    page.show(image: image, settings: settings)
  }
  
  func show(#url: String) {
    setup()
    let page = createPage()
    page.show(url: url, settings: settings)
  }
  
  /// Create a page, add it to the scroll view content and layout.
  private func createPage() -> AukPage {
    let page = AukPage()
    
    if let scrollView = scrollView {
      scrollView.addSubview(page)
      AukScrollViewContent.layout(scrollView)
    }
    
    return page
  }
  
  var pageIndex: Int {
    if let scrollView = scrollView {
      return Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
    }
    
    return 0
  }
  
  func changePage(toPageIndex: Int, pageWidth: CGFloat) {
    scrollView?.contentOffset.x = CGFloat(toPageIndex) * pageWidth
  }
  
  /**
  
  Check if the given page is currently visible to user.
  
  :returns: True if the page is visible to the user.
  
  */
  func isPageVisible(page: AukPage) -> Bool {
    if let scrollView = scrollView {
      return CGRectIntersectsRect(scrollView.bounds, page.frame)
    }
    
    return false
  }
}