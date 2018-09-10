********
Concepts
********

.. toctree::
   :maxdepth: 1


The `Wikipedia entry`_ for CDN states: “A content delivery network or
content distribution network (CDN) is a large distributed system of
servers deployed in multiple data centers across the Internet. The goal
of a CDN is to serve content to end-users with high availability and
high performance. CDNs serve a large fraction of the Internet content
today, including web objects (text, graphics and scripts), downloadable
objects (media files, software, documents), applications (e-commerce,
portals), live streaming media, on-demand streaming media, and social
networks.”

The Internet is a network of networks. To get content from a server on
the other side of the planet, IP packets have to travel through a series
of backbone servers and public network cables.

CDNs like the `Rackspace CDN`_ augment the transport network by
employing various techniques to optimize content delivery. It is fairly
easy to see how CDNs help by looking at how the Internet works. A trace
route to an Internet address tells us how many network hops a simple
request takes. Following is one to Yahoo.com.

::

    >tracert www.yahoo.com
    Tracing route to www-real.wa1.b.yahoo.com [209.191.93.52] over a maximum of 30 hops:
    1     1 ms     1 ms     1 ms  192.168.1.1
    2    11 ms     9 ms     9 ms  71.145.159.254
    3    11 ms     9 ms     9 ms  99.171.168.33
    4    11 ms     9 ms     9 ms  bb1-10g0-0.aus2tx.sbcglobal.net [151.164.188.145]
    5    16 ms    19 ms    16 ms  ex2-p14-1.eqdltx.sbcglobal.net [151.164.242.42]
    6    16 ms    16 ms    18 ms  asn10310-10-yahoo.eqdltx.sbcglobal.net [151.164.250.10]
    7    19 ms    17 ms   106 ms  ae2-p101.msr1.mud.yahoo.com [216.115.104.107]
    8    18 ms    18 ms    17 ms  te-8-1.bas-c1.mud.yahoo.com [68.142.193.5]
    9    18 ms    18 ms    17 ms  f1.www.vip.mud.yahoo.com [209.191.93.52]
    Trace complete.

Additional hops mean more time to render data from a request on the
user’s browser. The speed of delivery is also constrained by the slowest
network in the chain. The solution is a CDN that places servers around
the world and, depending on where the end user is located, serves the
user with data from the closest or most appropriate server. CDNs reduce
the number of hops needed to handle a request. The difference is shown
in the following figures.

Before the Use of a CDN
^^^^^^^^^^^^^^^^^^^^^^^

-  End user requests www.rackspace.com (origin server) in browser.
-  End user’s browser receives content through multiple servers.

After the Use of a CDN
^^^^^^^^^^^^^^^^^^^^^^

-  End user requests www.rackspace.com (origin server) in browser.
-  End user’s browser receives content from the optimum servers.

CDNs focus on improving performance of web page delivery. CDNs like the
Akamai CDN support progressive downloads, which optimizes delivery of
digital assets such as web page images. CDN nodes and servers are
deployed in multiple locations.



.. _Wikipedia entry: http://en.wikipedia.org/wiki/Content_delivery_network
.. _Rackspace CDN: http://www.rackspace.com/cloud/cdn-content-delivery-network

