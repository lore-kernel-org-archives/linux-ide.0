From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 0/3] hotplug polling, respin
Date: Tue, 24 Apr 2007 23:25:38 -0700
Message-ID: <20070425062538.GU7810@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+epxrXWOh++2HLjY"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b01.ext.isohunt.com ([208.71.112.51]:39161 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423227AbXDYGZd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Apr 2007 02:25:33 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--+epxrXWOh++2HLjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've been (very) slowly working on re-spinning Tejun's PMP work.

As the very first in the body of work, here is the patchset to implement
hotplug polling.

The last submission of this
(http://thread.gmane.org/gmane.linux.ide/13467) already had a tentative
ACK, pending a link power-saving patchset, that I can't find more
details on.

I only have sata_nv and sata_sil24 online for testing, but it does work
fine for both of those (and Tejun had previously tested many more
controllers).

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--+epxrXWOh++2HLjY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGLvRiPpIsIjIzwiwRAnkbAKCyR+DGGZza2Du58fgVZeyIiyoiBwCg/JzE
iKtNWDkxuedeER1CcG3/qfc=
=JRXr
-----END PGP SIGNATURE-----

--+epxrXWOh++2HLjY--
