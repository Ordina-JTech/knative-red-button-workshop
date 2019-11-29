# Left or right? - KNative Routing

After your first deployment it won't be long before a new deployment to production is needed. But not every change is put live immediately. With KNative you can easily setup a staging deployment and incrementally migrate traffic from the old to the new deployment.


## Tag the first release

With the `kn` cli we can change the traffic to different revisions of your deployment. At the moment all the traffic is routed to your latest deployment.

You can check this with the command: `kn route list -n <namespace>`. You first need to add a tag to the current revision.
If you don't do this and you do a new deployment, the new deployment will automatically get 100% of the traffic.

So tag the current revision now. \
_Hint: use this pattern: `kn service update <service> --tag <revisionname>=<tagname> -n <namespace>`_ \
_Hint: to show current revisions use: `kn revision list -n <namespace>`_

After creating the tag we are not ready yet. The most important part is to direct all the traffic to this tagged revision.
If you don't do the following step all the traffic will be automatically routed to the a new revision when creating a new revision.
Now route all the traffic to the tag you just created above.
Use: `kn service update <service> --traffic <tagname>=100,@latest=0 -n <namespace>`

You have now setup the first revision of your application.


## Staging the next release
For a final check you might want to put a next release live, without directly exposing it to the users.

Now alter the `deploy.sh` script and deploy your next revision (hint: you cannot use kn service 'create' anymore, please use kn service 'update').
Make sure to change the 'style' environment variable, so you can differentiate between the releases from your browser.
Possible options are: monochrome (default), vim, custom, retro \
_Note: write the option without quotes ~~"vim"~~_

Use `kn` to check to which revision your traffic is routed to now:
`kn route list -n <namespace>`

Check if it is up. Also verify that the styling is different from the previous release.


## Migrating traffic to the new release
Using the traffic segment of your service definition create a 50/50 split between the first and the second revision.

`kn service update <servie> --traffic <tag>=50,@latest=50 -n <namespace>`

In your browser you should be able to get both revisions after a few requests.
