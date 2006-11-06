From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: sata_mv 7042 support and port multipliers
Date: Sun, 5 Nov 2006 20:31:14 -0800
Message-ID: <20061106043114.GO15897@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dp9QYJgVRVEW2bsm"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.isohunt.com ([69.64.61.20]:25775 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S1423490AbWKFEbS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Nov 2006 23:31:18 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


--dp9QYJgVRVEW2bsm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I recently picked up a new eSATA controller
(http://www.sonnettech.com/product/tempo_sata_e4p.html), along with a
port-multiplier enclosure (Fusion 500P from the same company) and a
bunch of disks, since I was running out of space.

I added this to the table mv_pci_tbl[]:
{ PCI_VDEVICE(MARVELL, 0x7042), chip_7042 },

However, I see it doesn't quite work. 7042 support doesn't seem to have
been touched or even mentioned since Jeff posted the 6042 changes in
January.

The card reports as revision 2, which is not in the code either.

I've got the hardware, so I'm willing to do heavy lifting of code (NCQ,
Hotplug, PMP) if it hasn't been done yet, if somebody point me to some
docs on the matter.  I've seen the mvSata-3.6.1 driver, and it appears
to have most of the stuff on revision 1, but nothing on hardware
revision 2 either.

Jeff: you mentioned back in September about Marvell being a bit more
generous with docs? Were 7042 docs amongst them or do I have to slog
through the messy mvSata driver to find everything?

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--dp9QYJgVRVEW2bsm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFTrqSPpIsIjIzwiwRAvzeAKC40MyMvsKQYoVB6yqm+EdRqiWXGgCeOZiQ
HeitB2STlW1fGl8vmDnJex4=
=gQwL
-----END PGP SIGNATURE-----

--dp9QYJgVRVEW2bsm--
