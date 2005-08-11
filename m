From: Erik Slagter <erik@slagter.name>
Subject: Re: libata and PATA devices
Date: Thu, 11 Aug 2005 18:48:43 +0200
Message-ID: <1123778923.4422.11.camel@localhost.localdomain>
References: <200508071949.03782.inform@tiker.net>
	 <20050808030239.GA27502@havoc.gtf.org>
	 <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>
	 <42FACCA8.6050408@pobox.com>
	 <1123753051.4226.22.camel@localhost.localdomain>
	 <58cb370e05081103031cb9ccdb@mail.gmail.com>
	 <1123755440.4226.28.camel@localhost.localdomain>
	 <58cb370e050811032658a2b61e@mail.gmail.com>
	 <1123774157.4422.3.camel@localhost.localdomain>
	 <58cb370e050811085747380256@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-J8JTXiwK/Qz52mqXFpZd"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:47312 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1751116AbVHKQtM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Aug 2005 12:49:12 -0400
In-Reply-To: <58cb370e050811085747380256@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org


--=-J8JTXiwK/Qz52mqXFpZd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> > > AFAIR ICH6M has only one PATA port and putting both HDD and DVD drive
> > > on the same PATA port would sacrifice performance (because only one P=
ATA
> > > device can be used at a time).
> >=20
> > That's duff. The PATA harddisk that is used in my laptop, also comes in
> > a SATA version...
>=20
> You didn't even tell the vendor/model of the HDD
>=20
> hdparm -I /dev/hda
> =20
> output (with your patch applied) would be useful.

It has been discussed here before. It's a Fujitsu MHT2080AH, see
http://www.fujitsu.com/global/services/computing/storage/hdd/mhdd/mht20ahxx=
-catalog.html, although this one is more clear on the subject: http://www.d=
ealtime.com/xPF-Fujitsu_80GB_5400_RPM_ATA_6_2_5IN_FDB_NOTEBOOK_HARD_DRIVE


--=-J8JTXiwK/Qz52mqXFpZd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBC+4FrJgD/6j32wUYRApDpAJwMP137YZrDmddZaiq3ir+EYbDb8ACggImS
GKIE+TeVvoB9q0M4BqaQUpE=
=pmZb
-----END PGP SIGNATURE-----

--=-J8JTXiwK/Qz52mqXFpZd--
