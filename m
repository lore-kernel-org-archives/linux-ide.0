From: =?ISO-8859-1?Q?Jan_Kundr=E1t?= <jkt@gentoo.org>
Subject: is Promise TX4302 supported?
Date: Wed, 27 Jun 2007 03:46:47 +0200
Message-ID: <4681C187.70306@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig612CE7CB51973AF5487E2D4D"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pc175e.fzu.cz ([147.231.127.175]:58618 "EHLO postak-1.fzu.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752933AbXF0CLB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Jun 2007 22:11:01 -0400
Received: from postak-3.fzu.cz (postak3.fzu.cz [10.128.1.5])
	by postak-1.fzu.cz (8.13.1/8.13.1) with ESMTP id l5R1kcdt009635
	for <linux-ide@vger.kernel.org>; Wed, 27 Jun 2007 03:46:38 +0200
Received: from [10.18.6.23] (nat5.suchdol.net [82.208.33.254])
	(authenticated bits=0)
	by postak-3.fzu.cz (8.13.6/8.13.6) with ESMTP id l5R1krqA011577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 27 Jun 2007 03:46:53 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig612CE7CB51973AF5487E2D4D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi folks,
I'm considering buying a four-channel SATA PCI controller marked as
Promise TX-4302 (two internal SATA links, two eSATA, independent on each
other). According to the product page at Promise [1], Linux is missing
from the list of supported operating systems, although Google suggests
that online stores include Linux in the list of supported OSes.

I wasn't able to find this chip mentioned at the list of supported
chipsets [2]. There's a similarly looking TX-4, but I don't like the
idea of buying a nice room decoration instead of a working device.

I wasn't able to find out any reference to AHCI in the specs, either.

I would appreciate if you CC me on your replies as I'm not subscribed to
this list, but if it's considered impolite here, I can surely subscribe :=
).

[1]
http://www.promise.com/product/product_detail_eng.asp?segment=3Dundefined=
&product_id=3D168
[2] http://linux-ata.org/driver-status.html

Thanks in advance,
-jkt

--=20
cd /local/pub && more beer > /dev/mouth


--------------enig612CE7CB51973AF5487E2D4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGgcGHamXfqERyJRcRAq04AJ0TFMjc+L4VgmgiOpBk0CKttQ4aQACgmv+U
Z1w1BPWHPo1I6Zs6ykrUNBA=
=3wEi
-----END PGP SIGNATURE-----

--------------enig612CE7CB51973AF5487E2D4D--
