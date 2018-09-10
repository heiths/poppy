..
      Licensed under the Apache License, Version 2.0 (the "License"); you may
      not use this file except in compliance with the License. You may obtain
      a copy of the License at

          http://www.apache.org/licenses/LICENSE-2.0

      Unless required by applicable law or agreed to in writing, software
      distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
      WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
      License for the specific language governing permissions and limitations
      under the License.

poppy.transport
===============

.. graphviz::

   digraph TransportBase{

      transportBase [label="Transport Base",style=filled,color=".3 .45 1.0",shape="record"];
      transport [style=filled,color=".7 .3 1.0",label="Pecan"];
      models [style=filled,color=".7 .3 1.0",label="Models"];
      hooks [style=filled,color=".7 .3 1.0",label="Hooks"];
      controllers [style=filled,color=".7 .3 1.0",label="Controllers"];
      v1 [style=filled,color=".7 .3 1.0",label="v1"];
      root [style=filled,color=".7 .3 1.0",label="root"];
      validators [style=filled,color=".7 .3 1.0",label="Validators"];
      request [style=filled,color=".7 .3 1.0",label="Request"];
      response [style=filled,color=".7 .3 1.0",label="Response"];

      poppy -> transportBase;
      transportBase -> transport;
      transportBase -> validators;
      transport -> models;
      transport -> hooks;
      transport -> controllers;
      controllers -> v1;
      controllers -> root;
      models -> {request response};
   }


-----------------

.. toctree::
    :maxdepth: 2

    poppy.transport.pecan
    poppy.transport.validators


poppy.transport.app
~~~~~~~~~~~~~~~~~~~

.. automodule:: poppy.transport.app
    :members:
    :synopsis:
    :show-inheritance:


poppy.transport.base
~~~~~~~~~~~~~~~~~~~~

.. automodule:: poppy.transport.base
    :members:
    :synopsis:
    :show-inheritance:
