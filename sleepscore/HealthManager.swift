import HealthKit
import Foundation
extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
}

class HealthManager: ObservableObject {
    let healthStore = HKHealthStore()
    
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
    
    func getSleepDuration(completion: @escaping (TimeInterval?, Error?) -> Void) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion(nil, NSError(domain: "com.yourapp.healthkit", code: 1, userInfo: [NSLocalizedDescriptionKey: "Sleep analysis not available"]))
            return
        }
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            guard let samples = samples as? [HKCategorySample], error == nil else {
                completion(nil, error)
                return
            }
            
            var totalSleepTime: TimeInterval = 0
            
            for sample in samples {
                let sleepTime = sample.endDate.timeIntervalSince(sample.startDate)
                totalSleepTime += sleepTime
            }
            
            completion(totalSleepTime, nil)
        }
        
        print(query)
        healthStore.execute(query)
    }
}
