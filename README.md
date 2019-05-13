# GuestLogix
* [Future Implementation](#overview)
* [Overview/Installation](#install)
* [Screenshots](#screenshots)

### <a name="overview"> Future Implementation</a>
* Used Breadth-First Search to find the shortest path possible between two terminals. BFS accommodates unweighted edges. Can use Dijsktra also but this algorithm is more effective if the edges are weighted. 
* Used MVVC for architecture. Although still must improve. We can use Viper since it is more understandable as it has better separation of Routers/View and Controllers.
* Used Codable for Models. It is much easier to handle especially when coding and decoding. Must still implement in Core Data since we are dealing with thousands of entry. It might be good to combine Core Data and Codable. More on this soon.
* Implement a better Dependency Injection. Right now, we just settled on making the stores global but this is wrong and not ideal at all. 
* Must add MAP ANNOTATIONS for all airport that are returned.
* The airplane must be angled properly in MapKit.

### <a name="install">Overview/How to Install</a>

This project aims into finding the shortest route possible between two airports.

-  Just open the file [`.xcworkspace`] on Xcode and launch on Simulator.

### <a name="screenshots">Screenshots</a>
![image](https://user-images.githubusercontent.com/18160031/57607418-957fb280-759d-11e9-84d8-5cf2e82a391e.png)
![image](https://user-images.githubusercontent.com/18160031/57607428-99abd000-759d-11e9-99b1-c8839935f095.png)
![image](https://user-images.githubusercontent.com/18160031/57607440-a2040b00-759d-11e9-9f07-8337a5a9917c.png)
![image](https://user-images.githubusercontent.com/18160031/57607407-91ec2b80-759d-11e9-9d11-dfc03e91247f.png)
![image](https://user-images.githubusercontent.com/18160031/57607414-944e8580-759d-11e9-92c3-d4d519cc7d85.png)
![image](https://user-images.githubusercontent.com/18160031/57607422-97e20c80-759d-11e9-8f60-260cc6ad39a0.png)


