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

import Foundation

class NewsClient {

  struct Constants {

    static let apiKey = "REPLACE_WITH_NEWSAPIORG_KEY"
    static let baseURL = URL(string: "https://newsapi.org/v1")!

    struct Paths {

      static let article = "articles"

    }

    struct Keys {

      static let apiKey = "apiKey"
      static let source = "source"

    }

  }

  let urlSession: URLSession

  init() {
    let config = URLSessionConfiguration.default
    urlSession = URLSession(configuration: config)
  }

  typealias ArticlesCompletion = (([Article]?, Error?) -> Void)

  func articles(forSource source: NewsSource, completion: @escaping ArticlesCompletion) -> Cancellable {
    let articlesURL = Constants.baseURL.appendingPathComponent(Constants.Paths.article)
    var components = URLComponents(string: articlesURL.absoluteString)
    components?.queryItems = [
      URLQueryItem(name : Constants.Keys.apiKey, value: Constants.apiKey),
      URLQueryItem(name : Constants.Keys.source, value: source.rawValue)
    ]
    guard let url = components?.url else {
      fatalError("Could not create url")
    }

    let task = urlSession.dataTask(with: url) { (data, _, error) in
      DispatchQueue.main.async {
        if let error = error {
          completion(nil, error)
        } else {
          completion(ArticlesResponse.parseArticles(fromJSON: data), nil)
        }
      }
    }
    task.resume()
    return task
  }

}
