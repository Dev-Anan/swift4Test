/**
 * Copyright (c) 2017 Razeware LLC
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
import SDWebImage

class ArticleCell: UICollectionViewCell {

  static let cellID = "ArticleCellID"
  static let cellHeight: CGFloat = 370.0
  static let cellPadding: CGFloat = 8.0

  @IBOutlet var imageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var subtitleLabel: UILabel!
  @IBOutlet var dateLabel: UILabel!

  var article: Article? {
    didSet {
      guard let article = article else {
        return
      }

      imageView.sd_setImage(with: article.imageURL)
      titleLabel.text = article.title
      subtitleLabel.text = article.description
      if let date = article.publishedAt {
        dateLabel.isHidden = false
        dateLabel.text = Formatters.shortDateFormatter.string(from: date)
      } else {
        dateLabel.isHidden = true
      }
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.sd_cancelCurrentImageLoad()
    titleLabel.text = nil
    subtitleLabel.text = nil
    dateLabel.text = nil
  }

}
