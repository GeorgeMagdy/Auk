import UIKit

/// View containing a UIPageControl object that shows the dots for present pages.
final class AukPageIndicatorContainer: UIView {
  var pageControl: UIPageControl? {
    get {
      if subviews.count == 0 { return nil }
      return subviews[0] as? UIPageControl
    }
  }
  
  // Layouts the view, creates and layouts the page control
  func setup(settings: AukSettings, scrollView: UIScrollView) {    
    styleContainer(settings)
    AukPageIndicatorContainer.layoutContainer(self, settings: settings, scrollView: scrollView)
    
    let pageControl = createPageControl()
    AukPageIndicatorContainer.layoutPageControl(pageControl, superview: self, settings: settings)
  }
  
  // Update the number of pages showing in the page control
  func updateNumberOfPages(numberOfPages: Int) {
    pageControl?.numberOfPages = numberOfPages
  }
  
  // Update the current page in the page control
  func updateCurrentPage(currentPageIndex: Int) {
    pageControl?.currentPage = currentPageIndex
  }
  
  private func styleContainer(settings: AukSettings) {
    backgroundColor = settings.pageControl.backgroundColor
    layer.cornerRadius = CGFloat(settings.pageControl.cornerRadius)
  }
  
  private static func layoutContainer(pageIndicatorContainer: AukPageIndicatorContainer,
    settings: AukSettings, scrollView: UIScrollView) {
      
    if let superview = pageIndicatorContainer.superview {
      pageIndicatorContainer.setTranslatesAutoresizingMaskIntoConstraints(false)
        
      // Align bottom of the page view indicator with the bottom of the scroll view
      iiAutolayoutConstraints.alignSameAttributes(pageIndicatorContainer, toItem: scrollView,
        constraintContainer: superview, attribute: NSLayoutAttribute.Bottom,
        margin: CGFloat(-settings.pageControl.marginToScrollViewBottom))
      
      // Center the page view indicator horizontally in relation to the scroll view
      iiAutolayoutConstraints.alignSameAttributes(pageIndicatorContainer, toItem: scrollView,
        constraintContainer: superview, attribute: NSLayoutAttribute.CenterX, margin: 0)
    }
  }
  
  private func createPageControl() -> UIPageControl {
    let pageControl = UIPageControl()
    addSubview(pageControl)
    return pageControl
  }
  
  private static func layoutPageControl(pageControl: UIPageControl, superview: UIView, settings: AukSettings) {
    pageControl.setTranslatesAutoresizingMaskIntoConstraints(false)
    
    iiAutolayoutConstraints.fillParent(pageControl, parentView: superview,
      margin: settings.pageControl.innerPadding.width, vertically: false)
    
    iiAutolayoutConstraints.fillParent(pageControl, parentView: superview,
      margin: settings.pageControl.innerPadding.height, vertically: true)
  }
}
