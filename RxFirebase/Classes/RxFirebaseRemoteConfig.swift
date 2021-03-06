//
//  RxFirebaseRemoteConfig.swift
//  Pods
//
//  Created by David Wong on 20/05/2016.
//
//

import FirebaseRemoteConfig
import RxSwift

public extension FIRRemoteConfig {
    /**
     Fetches Remote Config data and sets a duration that specifies how long config data lasts.
     
     @param expirationDuration  Duration that defines how long fetched config data is available, in seconds. When the config data expires, a new fetch is required.
     
    */
    func rx_fetchWithExpirationDuration(expirationDuration: NSTimeInterval) -> Observable<FIRRemoteConfig> {
        return Observable.create { observer in
            self.fetchWithExpirationDuration(expirationDuration) { (status, error) -> Void in
                if (status == FIRRemoteConfigFetchStatus.Success) {
                    self.activateFetched()
                    observer.onNext(self)
                    observer.onCompleted()
                } else if let error = error{
                    observer.onError(error)
                }
            }
            
            return NopDisposable.instance
        }
    }
}