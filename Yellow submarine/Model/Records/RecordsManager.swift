import UIKit
import CoreData

class RecordsManager {
    
    var records : [RecordsData] = []
    let context = (UIApplication.shared.delegate as!
                   AppDelegate).persistentContainer.viewContext
    
    static let shared = RecordsManager()
    
    func saveGameResults( withCount userScore : Int) {
        let date = Date()
//        let recordsData = RecordsData(context: context)
        guard let entity = NSEntityDescription.entity(forEntityName: "RecordsData", in: context) else {return}
        
        let recordsObject = RecordsData(entity: entity, insertInto: context)
        recordsObject.score = Int64(userScore)
        recordsObject.date = date
        
        do {
            try context.save()
            records.append(recordsObject)
        } catch let error as NSError {
            print (error.localizedDescription)
        }
        print("\(userScore) was saved to CoreData")
        //        let date = Date()
        //        let formatter = DateFormatter()
        //        formatter.dateFormat = "dd/MM, h:mm a"
        //        formatter.amSymbol = "AM"
        //        formatter.pmSymbol = "PM"
        //        formatter.timeZone = .current
        //        let dateString = formatter.string(from: date)
    }
    
    func loadGameResults() {
        let fetchRequest : NSFetchRequest<RecordsData> = RecordsData.fetchRequest()
        do {
            records = try context.fetch(fetchRequest)
        }  catch  let error as NSError {
            print(error.localizedDescription)
        }
    }
}
