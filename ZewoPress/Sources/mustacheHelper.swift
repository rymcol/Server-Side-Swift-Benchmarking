// import Mustache
// import File
// import HTTP
//
// struct Templates {
//
//     static let global = try! Templates()
//
//     let repository: TemplateRepository
//
//     init() throws {
//         let nameAndPaths = [
//            "index": "index.mustache",
//
//            "header": "header.mustache",
//            "footer": "footer.mustache",
//         ]
//
//         let templates = try nameAndPaths.mapValues {
//             try String(data: File(path: "webroot" + "/" + $0).read())
//         }
//
//         self.repository = TemplateRepository(templates: templates)
//     }
//
//     func get(named name: String) throws -> Template {
//         return try repository.template(named: name)
//     }
// }
//
// extension Response {
//     init(status: Status = .ok, template: Template, data: MustacheBoxable) throws {
//         self.init(status: status, body: try template.render(data.mustacheBox))
//     }
//
//     init(status: Status = .ok, template name: String, data: MustacheBoxable) throws {
//         try self.init(status: status, template: Templates.global.get(named: name), data: data)
//     }
// }
//
// extension Dictionary {
//     func mapValues<T>(transform: Value throws -> T) rethrows -> [Key: T] {
//         var dictionary: [Key: T] = [:]
//
//         for (key, value) in self {
//             dictionary[key] = try transform(value)
//         }
//
//         return dictionary
//     }
// }
