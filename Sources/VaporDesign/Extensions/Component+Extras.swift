import Plot

public extension Component {
    func width(_ size: Int) -> Component {
        attribute(named: "width", value: "\(size)")
    }
    
    func height(_ size: Int) -> Component {
        attribute(named: "height", value: "\(size)")
    }
    
    func role(_ role: String) -> Component {
        attribute(named: "role", value: role)
    }
}
