import Foundation
import HealthKit
import Firebase
extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
    
    
    
}



class HealthManager: ObservableObject {
    let healthStore = HKHealthStore()
    
    @Published var sleeps: [String: Sleep] = [:]
    
    init() {
        let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        let healthTypes: Set = [sleepType]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            } catch {
                print("Error fetching sleep data: \(error.localizedDescription)")
            }
        }
    }
    
   
    func formatDateToString(    _ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d" // Format for "Wednesday, January 1"
        dateFormatter.locale = Locale(identifier: "en_US") // Set locale if needed

        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    func convertSecondsToHoursMinutes(seconds: TimeInterval) -> (hours: Int, minutes: Int) {
        let hours = Int(seconds) / 3600
        let minutes = Int(seconds) / 60 % 60
        return (hours, minutes)
    }
    func getSleepDuration(startDate: Date, endDate: Date, completion: @escaping (TimeInterval?, Error?) -> Void) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion(nil, NSError(domain: "com.yourapp.healthkit", code: 1, userInfo: [NSLocalizedDescriptionKey: "Sleep analysis not available"]))
            return
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let samples = samples as? [HKCategorySample], error == nil else {
                completion(nil, error)
                return
            }
            
            var totalSleepTime: TimeInterval = 0
            
            for sample in samples {
                let sleepTime = sample.endDate.timeIntervalSince(sample.startDate)
                totalSleepTime += sleepTime
            }
            
            let sleepDate = startDate;
            
            
           
            let (hours, minutes) = self.convertSecondsToHoursMinutes(seconds: totalSleepTime)
            
            let email = Auth.auth().currentUser?.email
            let documentName = "\(email ?? "")\(self.formatDateToString(sleepDate))"
            
            
            
            
            let sleep = Sleep(id: documentName, user: email ?? "", hours: "\(hours)", minutes: "\(minutes)", userEmail: email ?? "", date: self.formatDateToString(sleepDate))
//            DispatchQueue.main.async {
//                self.sleeps["todaysDuration"] = sleep;
//                self.addSleep(sleep: sleep)
//            }
            
            self.addSleep(sleep: sleep)
            
            
            completion(totalSleepTime, nil)
        }
        
        
        healthStore.execute(query)
    }
    
    func addSleep(sleep: Sleep) {
        
       
        
        let db = Firestore.firestore()
        let ref = db.collection("sleeps").document(sleep.id)
        ref.setData(["hours": sleep.hours, "minutes": sleep.minutes, "date": sleep.date, "id": sleep.id, "userEmail": sleep.userEmail, "user": sleep.user]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func checkDailySleep() {
        
        
    }
    
    
    
}
