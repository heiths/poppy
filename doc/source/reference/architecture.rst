************
Architecture
************


Request Diagram
---------------

.. graphviz::

   digraph Poppy{
      client [label="Client Request",style=dotted,color="grey",shape="record"];
      auth [label="Auth/Load Balancer",style=dotted,color="grey",shape="record"];
      transport [label="Transport (Pecan)",style=filled,color=".3 .45 1.0",shape="record"];
      manager [label="Manager (default)",style=filled,color=".3 .45 1.0",shape="record"];
      zookeeper [label="Taskflow (Zookeeper)",style=filled,color=".5 .95 .8",shape="record"];
      storage [style=filled,color=".7 .3 1.0",label="Storage (Cassandra)"];
      dns [style=filled,color=".7 .3 1.0",label="DNS (Rackspace)"];
      provider [style=filled,color=".7 .3 1.0",label="Provider (Akamai)"];

      client -> auth;
      auth -> transport;
      transport -> manager;
      manager -> {zookeeper storage};
      zookeeper -> {dns provider storage};
   }

poppy-server
------------
poppy-server provides the standard Openstack style REST API service, accepting HTTP requests. Authentication and Authorization are assumed to have already been completed by middleware by the time the request gets to poppy-server.

Requests are handled by the API Transport, and inputs are validated. If all is okay, the request is sent to the manager which decides what to do. If it is a GET request, the request will typically go to the storage driver to retrieve information and returned back to the user. If the request requires making third party API calls (e.g. updating a CDN provider, making a DNS request, etc), then the manager driver will publish a message to the Taskflow Job Board. The poppy-worker will handle any message that appears on the job board.

poppy-worker
------------
poppy-worker performs long lived, blocking tasks that are required for provisioning CDN services. Examples of this are creating a CDN service which requires making a call to create or update a service with a third party CDN Provider (e.g. Akamai, Fastly, Cloudfront, etc). Another example is setting up a DNS entry for the operator to CNAME to a CDN provider url.

As poppy-worker uses openstack Taskflow, retry logic is built in. Any rate limiting/down time caused by a third party API will cause the task to retry with a back off interval before it ultimately fails.
