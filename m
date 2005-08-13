From: Erik Slagter <erik@slagter.name>
Subject: Re: libata and PATA devices
Date: Sat, 13 Aug 2005 17:50:50 +0200
Message-ID: <1123948250.11048.9.camel@localhost.localdomain>
References: <200508071949.03782.inform@tiker.net>
	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org>
	 <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>
	 <42FACCA8.6050408@pobox.com> <42FB853E.4070100@rtr.ca>
	 <42FB889F.50607@pobox.com> <1123789132.4422.30.camel@localhost.localdomain>
	 <42FBB33D.8050003@pobox.com>
	 <1123932640.4378.10.camel@localhost.localdomain>
	 <42FE12D6.1070600@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4fMcMsxuPI/LaT3Oq3nO"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:20902 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1751342AbVHMPvE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Aug 2005 11:51:04 -0400
In-Reply-To: <42FE12D6.1070600@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org


--=-4fMcMsxuPI/LaT3Oq3nO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-08-13 at 11:33 -0400, Jeff Garzik wrote:
> Erik Slagter wrote:
> > result: the pata harddisk is recognised by libata_piix and
> > assigned /dev/sda, the dvd drive is found by the generic ide driver.
> > (dmesg output attached)

> Great!  That's precisely what's supposed to happen.  Except, the hard=20
> drive appears to be SATA, not PATA:
>=20
> > ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
> > ata1: dev 0 cfg 49:2b00 82:346b 83:5b29 84:4003 85:3469 86:1a09 87:4003=
 88:203f
> > ata1: dev 0 ATA, max UDMA/100, 156301488 sectors:
> > ata1: dev 0 configured for UDMA/100
>=20
> Everything appears to be working just fine.  DVD appears via IDE driver,=20
> SATA drive appears via libata.

Nope. The harddisk is not SATA, it's PATA. See the links I posted
earlier. That's the whole point.

--=-4fMcMsxuPI/LaT3Oq3nO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBC/hbaJgD/6j32wUYRAoUfAJ92X/yn6qZTPljtkILEGMYl6ctNfQCcCS3s
ayPOfN20Y2Rwjz5z6q0f4UE=
=OHrZ
-----END PGP SIGNATURE-----

--=-4fMcMsxuPI/LaT3Oq3nO--
