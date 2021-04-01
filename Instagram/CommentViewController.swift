//
//  CommentViewController.swift
//  Instagram
//
//  Created by PC-SYSKAI552 on 2021/03/31.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    @IBOutlet weak var replyLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var postData: PostData!
    
    //コメント投稿ボタン
    @IBAction func handleCommentButton(_ sender: Any) {
        
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        
        if textField.text != "" {
            
            // 画像と投稿データの保存場所を定義する
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
            
            // FireStoreに投稿データを保存する
            let name = Auth.auth().currentUser?.displayName
            postRef.updateData([
                "comments": FieldValue.arrayUnion([name! + ": " + self.textField.text!])
            ])
            // HUDで投稿完了を表示する
            SVProgressHUD.showSuccess(withStatus: "コメントを投稿しました")
            // 投稿処理が完了したので先頭画面に戻る
            UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        }else {
            
            SVProgressHUD.showError(withStatus: "コメントを入力してください")
            
        }
        
        
        
        
        
    }
    
    //キャンセルボタン
    @IBAction func handleCancelButton(_ sender: Any) {
        
        // ホーム画面に戻る
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 送信先の表示
        self.replyLabel.text = "\(postData.name!) : \(postData.caption!)"
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
