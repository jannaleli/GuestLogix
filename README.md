# GuestLogix
* [Overview](#overview)
* [Installation](#install)
* [Future Implementation](#Future)
* [Screenshots](#screenshots)

### <a name="install">Overview</a>
* Used Breadth-First Search to find the shortest path possible between two terminals. BFS accommodates unweighted edges. Can use Dijsktra also.
* Used MVVC for architecture. Although still must improve.
* Used Codable for Models. It is much easier to handle especially when coding and decoding. Must still implement in Core Data since we are dealing with thousands of entry. It might be good to combine Core Data and Codable. More on this soon.
* Implement a better Dependency Injection. Right now, we just settled on making the stores global but this is wrong and not ideal at all. 
* Must add MAP ANNOTATIONS for all airport that are returned.
* The airplane must be angled properly in MapKit.

### <a name="install">How to Install</a>

This project aims into finding the shortest route possible between two airports.

-  Just open the file [`.xcworkspace`] on Xcode and launch on Simulator.
