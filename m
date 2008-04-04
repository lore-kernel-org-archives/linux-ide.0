From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: libata/avr32 build failure
Date: Fri, 4 Apr 2008 17:10:40 +1100
Message-ID: <20080404171040.d3d64c2d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__4_Apr_2008_17_10_40_+1100_E5B_ZXbA0=U.irKz"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:54518 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbYDDGKr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 02:10:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-next@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org

--Signature=_Fri__4_Apr_2008_17_10_40_+1100_E5B_ZXbA0=U.irKz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

For a while the linux-next build for avr32 defconfig (and others) has
been failing like this:

drivers/ata/libata-core.c:127: error: 'ata_pci_default_filter' undeclared h=
ere (not in a function)

It seems to be because the declaration of ata_pci_default_filter is
protected by CONFIG_PCI but the usage above is protected by CONFIG_ATA
only.

Also reported by Randy Dunlap (on March 26) and Haavard Skinnemoen (on
March 29).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__4_Apr_2008_17_10_40_+1100_E5B_ZXbA0=U.irKz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH9cZkTgG2atn1QN8RAvtiAKCLjy7PGDCnyp14UlzIx3ccy51sNwCgj/wN
EKI44ib/n0oKM4zePLAi8fw=
=2NWY
-----END PGP SIGNATURE-----

--Signature=_Fri__4_Apr_2008_17_10_40_+1100_E5B_ZXbA0=U.irKz--
