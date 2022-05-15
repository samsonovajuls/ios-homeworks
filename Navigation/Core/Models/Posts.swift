import Foundation

struct Posts: Decodable {
    struct Post: Decodable {
        let author: String      //никнейм автора публикации
        let description: String //текст публикации
        let image: String       //имя картинки из каталога Assets.xcassets
        var likes: Int          //количество лайков
        var views: Int          //количество просмотров

        enum CodingKeys: String, CodingKey {
            case author, description, image, likes, views
        }
    }

    let posts: [Post]
}
