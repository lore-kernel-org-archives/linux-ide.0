From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: libata/avr32 build failure
Date: Fri, 4 Apr 2008 17:14:15 +1100
Message-ID: <20080404171415.c47a3067.sfr@canb.auug.org.au>
References: <20080404171040.d3d64c2d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__4_Apr_2008_17_14_15_+1100_l7we_J3eAg7a.isX"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:52853 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566AbYDDGOX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 02:14:23 -0400
In-Reply-To: <20080404171040.d3d64c2d.sfr@canb.auug.org.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
Cc: linux-next@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org

--Signature=_Fri__4_Apr_2008_17_14_15_+1100_l7we_J3eAg7a.isX
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Fri, 4 Apr 2008 17:10:40 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> For a while the linux-next build for avr32 defconfig (and others) has
> been failing like this:
>=20
> drivers/ata/libata-core.c:127: error: 'ata_pci_default_filter' undeclared=
 here (not in a function)
>=20
> It seems to be because the declaration of ata_pci_default_filter is
> protected by CONFIG_PCI but the usage above is protected by CONFIG_ATA
> only.
>=20
> Also reported by Randy Dunlap (on March 26) and Haavard Skinnemoen (on
> March 29).

The bug looks like it was introduced by commit
dc14c0c5012855bfc9a5f76056b92f198d52834c ("libata: implement and use ops
inheritance").

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__4_Apr_2008_17_14_15_+1100_l7we_J3eAg7a.isX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH9cc6TgG2atn1QN8RAgjWAKCR319dCcdMaw3g1Y0kSAJ8ZudA9wCfRp7+
ouohT5Jvg1Utjbak+j4iMG4=
=kvrS
-----END PGP SIGNATURE-----

--Signature=_Fri__4_Apr_2008_17_14_15_+1100_l7we_J3eAg7a.isX--
