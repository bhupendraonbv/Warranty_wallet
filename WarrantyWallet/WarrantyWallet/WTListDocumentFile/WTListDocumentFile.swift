//
//  WTListDocumentFile.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 16/01/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class WTListDocumentFile: UIViewController,UIGestureRecognizerDelegate,TopviewDelegate,UIScrollViewDelegate,UIWebViewDelegate {

     @IBOutlet weak var scrlVW: UIScrollView!
    @IBOutlet weak var imgVW: UIImageView!
    var pinchGesture  = UIPinchGestureRecognizer()
    @IBOutlet weak var vwBG: UIView!
    var topview:TopViewController!
    var arrrecvImg = String()
     var spinnerActivity: MBProgressHUD = MBProgressHUD()
    
 @IBOutlet weak var VWLoadWebview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         print(arrrecvImg)
        
        let fileUrl = NSURL(string: arrrecvImg)
        print(fileUrl ?? 11)
        
        VWLoadWebview.delegate = self
        VWLoadWebview.loadRequest(URLRequest(url : fileUrl! as URL))
        VWLoadWebview.scalesPageToFit = true
        VWLoadWebview.scrollView.zoomScale = 1.0
        
        
        addTopView()
    }
   
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imgVW
        
    }

    func addTopView(){
        topview = TopViewController(title: "Document List", menuBtnType: TopLeftBtnType.menuBtn, controller: self, isFilterBtnShow: true, channelPage:false)
        topview.delegate = nil
        
        topview.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
        self.view.addSubview(topview.view)
        self.view.layoutIfNeeded()
        
    }
    
    func pinchedView(sender:UIPinchGestureRecognizer){
        self.view.bringSubview(toFront: imgVW)
        sender.view?.transform = (sender.view?.transform)!.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 0.5
    }
    
    
    func setZoomScale()
    {
        let imageViewSize = imgVW.bounds.size
        let scrollViewSize = scrlVW.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        scrlVW.minimumZoomScale = min(widthScale, heightScale)
        scrlVW.maximumZoomScale = 6.0
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        self.spinnerActivity.label.text = "Loading..."
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        //TODO: describir el error
        MBProgressHUD.hide(for: self.view!, animated: true)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
       MBProgressHUD.hide(for: self.view!, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension UIImageView{
    
    func setImageFromURlimg(stringImageUrl url: String){
        
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}
