From: Erik Slagter <erik@slagter.name>
Subject: Re: libata and PATA devices
Date: Sat, 13 Aug 2005 18:03:25 +0200
Message-ID: <1123949005.11048.16.camel@localhost.localdomain>
References: <200508071949.03782.inform@tiker.net>
	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org>
	 <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>
	 <42FACCA8.6050408@pobox.com> <42FB853E.4070100@rtr.ca>
	 <42FB889F.50607@pobox.com> <1123789132.4422.30.camel@localhost.localdomain>
	 <42FBB33D.8050003@pobox.com>
	 <1123932640.4378.10.camel@localhost.localdomain>
	 <42FE12D6.1070600@pobox.com>
	 <1123948250.11048.9.camel@localhost.localdomain>
	 <42FE1828.4000104@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eVvmLJJag8lKlZ27bVGS"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:458 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1751349AbVHMQLN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Aug 2005 12:11:13 -0400
In-Reply-To: <42FE1828.4000104@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>


--=-eVvmLJJag8lKlZ27bVGS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-08-13 at 11:56 -0400, Jeff Garzik wrote:
> > Nope. The harddisk is not SATA, it's PATA. See the links I posted
> > earlier. That's the whole point.
>=20
> The controller thinks its a SATA device, so there is probably a bridge=20
> installed.

I suppose it's something like that.

It's all very confusing.

E.g. that would mean I must treat my PATA harddisk as if it's a SATA
harddisk, but on the other hand, it's not really a SATA disk, so I
cannot use SATA features.

Maybe an idea to spend a few words on the matter, including the way
you're supposed to configure the kernel for this setup.

BTW afaik you won't be able be able to control DMA on the dvd drive with
this setup, so I'll stick to my patched kernel for the moment (=3D both
disk&cdrom are assigned to ide).

--=-eVvmLJJag8lKlZ27bVGS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBC/hnNJgD/6j32wUYRAmUKAJ9y3EzOI++lFfluU2oKYcKN7h4PfACfQBUc
0j3+KBRAkAwyUYgNJ5AHUIw=
=TbsY
-----END PGP SIGNATURE-----

--=-eVvmLJJag8lKlZ27bVGS--
