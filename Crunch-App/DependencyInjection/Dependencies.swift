
import Foundation

class Dependencies {
    
    @Provider var cartViewModel = CartViewModel(realmManager: RealmManager()) as CartProtocol
}
