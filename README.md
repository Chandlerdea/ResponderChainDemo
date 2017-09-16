# ResponderChainDemo

This project is meant to demonstrate using the responder chain to delegate the actions of UIControl objects inside of a UITableViewCell. This also works with UICollectionViewCells, but this project will use UITableViewCells. This project is simply meant to demonstrate one approach to a common situation that iOS developers encounter.

## The Problem

Let's say we have a `UITableVewCell` subclass called `SomeCell`, which has a button. We want the view controller which owns the table view to be notified when the button inside `SomeCell` is pressed.

### The Old Way

1. Create a delegate protocol `SomeCellDelegate`
2. Add a `delegate` property of type `SomeCellDelegate` to the cell
3. Make the cell the target of the button
4. Inside of the button's target method, call the correct function on the delegate, usually passing the cell as an argument
5. Make sure the view controller conforms to the delegate

This isn't necessarily bad, but there are some potential issues. 
* You could easily have a retain cycle if the protocol isn't a class protocol, and the delegate property isn't weak
* You could also have to manually set the delegate of the cell

### The Responder Chain Way

1. Create a delegate protocol `SomeCellDelegate`
2. Make the cell the target of the button
3. Inside of the button's target method, add this line:

       UIApplication.shared.sendAction(#selector(SomeCellDelegate.doSuff(_:)), to: .none, from: self, for: .none)
    
4. Make sure the view controller conforms to the delegate
    
The `sendAction` funtion will cause the system to go up the responder chain, and call `resonds(to:)` on each responder, until the function returns `true`. This solves the potential retain cycle issue, and is overall a more clean solution, using the responder chain as it is meant to be used.
    
 
