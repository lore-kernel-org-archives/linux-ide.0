From: Mark Bryars <linuxide@darkskiez.co.uk>
Subject: PATA Port on PDC20378 (FastTrak 378/SATA 378) (rev 02) Asus K8V Deluxe
Date: Wed, 02 Feb 2005 09:50:54 +0000
Message-ID: <4200A27E.2070401@darkskiez.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from usergc137.dsl.pipex.com ([62.190.170.137]:18841 "EHLO
	smtp.e-tv-interactive.com") by vger.kernel.org with ESMTP
	id S262229AbVBBJvN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Feb 2005 04:51:13 -0500
Received: from [192.168.1.178] (unknown [192.168.1.178])
	by smtp.e-tv-interactive.com (Postfix) with ESMTP id 152A333665F
	for <linux-ide@vger.kernel.org>; Wed,  2 Feb 2005 09:51:13 +0000 (GMT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I have an Asus K8V Mainboard, the promise sata controller has a PATA
port in addition to the two SATA channels and the HDD I have connected
is detected by the controller as displayed on boot. The sata_promise
driver as of stock 2.6.10 seems to only probe the two sata ports. Is
this meant to also handle the pata port or is a separate driver/patch
needed? I've searched the list and not found anything appropriate.

Thanks for your help.

Regards,
~ Mark

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCAKJ+FY62wDFsUK4RAlrBAKCXVLaBVhtn6aGbgFyotsZ7PcKhAwCfb9Ht
sKw2SewhYjss62j1lPDkDkM=
=Cojc
-----END PGP SIGNATURE-----

