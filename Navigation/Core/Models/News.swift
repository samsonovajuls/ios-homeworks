import Foundation

struct News: Decodable {
    struct Post: Decodable {
        let author: String      //никнейм автора публикации
        let description: String //текст публикации
        let image: String       //имя картинки из каталога Assets.xcassets
        let likes: Int          //количество лайков
        let views: Int          //количество просмотров

        enum CodingKeys: String, CodingKey {
            case author, description, image, likes, views
        }
    }

    let posts: [Post]
}
