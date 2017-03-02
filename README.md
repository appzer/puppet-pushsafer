pushsafer-puppet
==========

Description
-----------

A Puppet report handler for sending notifications of failed runs as a push notification by Pushsafer.com

Requirements
------------

* `puppet` (version 2.6.5 and later)

Installation & Usage
--------------------

1.  Install pushsafer-puppet as a module in your Puppet master's module
    path.

2.  Update the `privatekey` variable in the `pushsafer.yaml` file with your private or alias key from Pushsafer.com.

3.  Enable pluginsync and reports on your master and clients in `puppet.conf`

        [master]
        report = true
        reports = pushsafer
        pluginsync = true
        [agent]
        report = true
        pluginsync = true

4.  Run the Puppet client and sync the report as a plugin

Author
------

Pushsafer.com Kevin Siml <kevinsiml@googlemail.com>

License
-------

    Author:: Kevin Siml (<kevinsiml@googlemail.com>)
    Copyright:: Copyright (c) 2017 Pushsafer.com
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
