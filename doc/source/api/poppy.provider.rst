poppy.provider
==============

.. graphviz::

   digraph ProviderBase{
      app [label="Provider Base",style=filled,color=".3 .45 1.0",shape="record"];
      d1 [style=filled,color=".7 .3 1.0",label="Akamai"];
      d2 [style=dotted,label="fastly"];
      d3 [style=dotted,label="mock"];
      app -> d1;
      app -> d2 [style=dotted];
      app -> d3 [style=dotted];
   }


poppy.provider.base
~~~~~~~~~~~~~~~~~~~

.. toctree::

    poppy.provider.base


poppy.provider.akamai
~~~~~~~~~~~~~~~~~~~~~

.. toctree::

    poppy.provider.akamai


poppy.provider.mock
~~~~~~~~~~~~~~~~~~~

.. toctree::

    poppy.provider.mock
