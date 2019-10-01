# Left or right? - KNative Routing

After your first deployment it won't be long before a new deployment to production is needed. But not every change is put live immediately. With KNative you can easily setup a staging deployment and incrementally migrate traffic from the old to the new deployment.  


## Tag the first release

With the `kn` cli we can change the traffic to different revisions of your deployment. At the moment all the traffic is routed to your latest deployment.

You can check this with the command: `kn route list -n <namespace>`. You first need to add a tag to the current revision.
If you don't do this and you do a new deployment, the new deployment will automatically get 100% of the traffic.

So tag the current revision now. Hint: use this pattern: `kn service update <service> --tag <revisionname>=<tagname> -n <namespace>`
 
You have now setup the first revision of your application. 


## Staging the next release
For a final check you might want to put a next release live, without directly exposing it to the users. 

Now alter the `deploy.sh` script and deploy your next revision.
Make sure to change the 'style' environment variable, so you can differentiate between the releases from your browser. 

Use `kn` to check to which revision your traffic is routed to now:
`kn route list -n <namespace>`

Check if it is up. Also verify that the styling is different from the previous release.


## Migrating traffic to the new release
Using the traffic segment of your service definition create a 50/50 split between the first and the second revision.

`kn service update <servie> --traffic <tag>=50,@latest=50 -n <namespace>`

In your browser you should be able to get both revisions after a few requests.