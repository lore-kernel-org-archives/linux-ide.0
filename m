From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Missing support for Intel Corporation 6300ESB PATA Storage
	Controller [8086:25a2] (rev 02)
Date: Tue, 3 Mar 2009 22:59:10 -0800
Message-ID: <20090304065910.GX16405@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ubuMVesmirrCclZT"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b01.ext.isohunt.com ([208.71.112.51]:40473 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752816AbZCDLJX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Mar 2009 06:09:23 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--ubuMVesmirrCclZT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Migrating some old boxes over to use libata, and I ran into one with no
obvious libata driver.
00:1f.1 IDE interface [0101]: Intel Corporation 6300ESB PATA Storage Contro=
ller [8086:25a2] (rev 02)

The same system has this PCI ID that IS supported by ata_piix, but we've
got IDE disks in place, not SATA:
00:1f.2 IDE interface [0101]: Intel Corporation 6300ESB SATA Storage Contro=
ller [8086:25a3] (rev 02)

Just an accidental omission? Does ata_piix work for it? I don't have a
remote serial console or direct access to the machine, so I can't test
it myself.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--ubuMVesmirrCclZT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkmuJr4ACgkQPpIsIjIzwixc1wCg/jELYLrRjZ24+iwSO7osHrxZ
DOwAoIwRRDqwrg4E8UD9U6+6djGyjkku
=c8J4
-----END PGP SIGNATURE-----

--ubuMVesmirrCclZT--
