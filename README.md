# responder-chain-demo

This project is meant to demonstrate using the responder chain to delegate the actions of UIControl objects inside of a UITableViewCell. This also works with UICollectionViewCells, but this project will use UITableViewCells. This project is simply meant to demonstrate one approach to a common situation that iOS developers encounter.

Most of the time when we create UITableViewCell subclasses, they have some type of UIControl subclass as a subview of the content view. When the user selects the button, the view controller should be informed of the action. Usually, we create a protocol and use delegation to accomplish this, or do something stupid like send a NSNotification. Delegation is a completely valid solution, but I believe there is a easier, simpler way to accomplish this.

Using the responder chain, we can send events up to the UITableView, which will then ask its delegate if it can perform the action, and leave it up to the delegate to actually perform this action. This cuts down the amount of code that needs to be written, and moves all of the user input logic into one place. You can go about this in Interface Builder, or do it through code. I have the project set up to use IB, but the code is in the comments.

Please feel free to let me know if you have any questions, comments, or ideas to make it better.
