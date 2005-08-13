From: Erik Slagter <erik@slagter.name>
Subject: Re: libata and PATA devices
Date: Sat, 13 Aug 2005 18:05:23 +0200
Message-ID: <1123949123.11048.19.camel@localhost.localdomain>
References: <200508071949.03782.inform@tiker.net>
	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org>
	 <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>
	 <42FACCA8.6050408@pobox.com> <42FB853E.4070100@rtr.ca>
	 <42FB889F.50607@pobox.com> <1123789132.4422.30.camel@localhost.localdomain>
	 <42FBB33D.8050003@pobox.com>
	 <1123932640.4378.10.camel@localhost.localdomain>
	 <42FE12D6.1070600@pobox.com> <42FE181E.10003@dtbb.net>
	 <42FE1869.2030800@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BYtKuQE0I3f4HtwzBO/W"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:37774 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1751347AbVHMQGK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Aug 2005 12:06:10 -0400
In-Reply-To: <42FE1869.2030800@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tyler <pml@dtbb.net>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org


--=-BYtKuQE0I3f4HtwzBO/W
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-08-13 at 11:57 -0400, Jeff Garzik wrote:
> Tyler wrote:
> > Jeff, I think he stated in an earlier post to the list, the model numbe=
r=20
> > of the drive, and it is in fact a PATA drive... verified by checking=20
> > fujitsu's website.  Or are you just saying that it "shows up as sata" b=
y=20
> > coming up as /dev/sda since its connected to a PATA port on a sata=20
> > combined controller?
>=20
> The SATA controller thinks its SATA.

That, I already noticed a long time ago. The question is, is libata
correct in thinking this?

--=-BYtKuQE0I3f4HtwzBO/W
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBC/hpDJgD/6j32wUYRAhqNAJ0Us6xzvI34SwilQ0paXMTDYa/oCgCfY0SY
R05tbhwoJuyaJAF50eFLxxU=
=/8/d
-----END PGP SIGNATURE-----

--=-BYtKuQE0I3f4HtwzBO/W--
