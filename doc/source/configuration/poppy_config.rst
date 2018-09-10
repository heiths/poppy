Description
-----------

This file includes some of the important configurations and also some of the regular configurations, not all the configuration information are explained below.

Default configuration
---------------------

Make sure to keep the ``logging.conf`` in the correct directory as per the README document, typically found under the ``.poppy`` directory.

.. code-block:: ini

    [DEFAULT]
    verbose = True 			# To get verbosity for poppy server and worker
    debug = True 			# To get debug logs for poppy server and worker
    base_url = http://0.0.0.0:8888	# To have accessibility from anywhere

    log_config_append = ${HOME}/.poppy/logging.conf


drivers configuration
---------------------
.. code-block:: ini

    [drivers]
    providers = akamai 			# Currently Akamai is one of the supported providers


storage configuration
---------------------
We currently use cassandra as our database.
The migrations folder is located ``poppy/storage/cassandra/migrations`` relative to the poppy folder.
By having the ``automatic_schema_migrations = True``, the migrations will automatically run immediately after the first request.

.. code-block:: ini

    [drivers:storage:cassandra]
    migrations_path = ${HOME}/poppy/poppy/storage/cassandra/migrations


taskflow configuration
----------------------

Currently the dependencies run dockerized.
In your ``/etc/hosts`` file, add the following line
``127.0.0.1 dockerhost``

.. code-block:: ini

    [drivers:distributed_task:taskflow]
    jobboard_backend_host = "dockerhost"		#Set the host to dockerhost for this


akamai provider configuration
-----------------------------

Set all the api keys, get these api keys from your administrator.
Get the appropriate cert names and set them accordingly for testing, the ones listed above are the ones which are used for dev testing.

.. code-block:: ini

    [drivers:provider:akamai]

    contract_id : <contract_id>			#Set the contract id value, you should get it from your administrator
    group_id : <group_id>			#Set the group, you should get it from your administrator

    san_cert_cnames = <name of san certs separated by commas>
    sni_cert_cnames = <name of sni certs separated by commas>
