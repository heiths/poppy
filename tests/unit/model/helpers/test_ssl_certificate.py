# Copyright (c) 2015 Rackspace, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.


import ddt

from poppy.model import ssl_certificate
from tests.unit import base


@ddt.ddt
class TestSSLCertificate(base.TestCase):

    def test_ssl_certificate(self):

        project_id = '12345'
        cert_details = {
            'mock': {
                'extra_info': 'nope'
            }
        }
        flavor_id = 'myflavor'
        domain_name = 'www.mydomain.com'
        cert_type = 'san'

        ssl_cert = ssl_certificate.SSLCertificate(project_id=project_id,
                                                  flavor_id=flavor_id,
                                                  domain_name=domain_name,
                                                  cert_type=cert_type,
                                                  cert_details=cert_details)

        # test all properties
        # project_id
        self.assertEqual(ssl_cert.project_id, project_id)
        ssl_cert.project_id = '123456'

        # flavor_id
        self.assertEqual(ssl_cert.flavor_id, flavor_id)
        ssl_cert.flavor_id = 'yourflavor'

        # domain_name
        self.assertEqual(ssl_cert.domain_name, domain_name)
        ssl_cert.domain_name = 'www.yourdomain.com'

        # cert_type
        self.assertEqual(ssl_cert.cert_type, cert_type)
        ssl_cert.cert_type = 'custom'
        self.assertRaises(ValueError, setattr, ssl_cert, 'cert_type',
                          'whatever')
        # cert_details
        self.assertEqual(ssl_cert.cert_details, cert_details)
        cert_details_two = cert_details.copy()
        cert_details_two['mock']['extra_info'] = 'maybe'
        ssl_cert.cert_details = cert_details_two
        self.assertEqual(ssl_cert.cert_details, cert_details_two)
        # check cert type here, the model was incorrectly modifying
        # cert_type in the cert_details setter
        self.assertEqual('custom', ssl_cert.cert_type)

        # get cert status
        cert_details['mock']['extra_info'] = {
            'status': 'deployed'
        }
        ssl_cert.cert_details = cert_details
        self.assertEqual(ssl_cert.get_cert_status(), 'deployed')
        cert_details['mock']['extra_info'] = {
            'status': 'whatever'
        }

        self.assertRaises(ValueError, ssl_cert.get_cert_status)
