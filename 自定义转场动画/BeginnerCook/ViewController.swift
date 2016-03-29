/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var listView: UIScrollView!
  @IBOutlet var bgImage: UIImageView!
  var selectedImage: UIImageView?
  
  //pop 过渡动画
  let transition = PopAnimator()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  func didTapImageView(tap: UITapGestureRecognizer) {
    selectedImage = tap.view as? UIImageView
    
    let index = tap.view!.tag
    let selectedHerb = herbs[index]
    
    //present details view controller
    let herbDetails = storyboard!.instantiateViewControllerWithIdentifier("HerbDetailsViewController") as! HerbDetailsViewController
    herbDetails.herb = selectedHerb
    herbDetails.transitioningDelegate = self
    presentViewController(herbDetails, animated: true, completion: nil)
  }
}

//交互动画 设置
extension ViewController: UIViewControllerTransitioningDelegate {
  func animationControllerForPresentedController(
    presented: UIViewController,
    presentingController presenting: UIViewController,
    sourceController source: UIViewController) ->
    UIViewControllerAnimatedTransitioning? {
      
      transition.originFrame = selectedImage!.superview!.convertRect(selectedImage!.frame, toView: nil)
      transition.presenting = true
      
      return transition
  }
  
  func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition.presenting = false
    return transition
  }
}