From: Erik Slagter <erik@slagter.name>
Subject: Re: libata and PATA devices
Date: Sat, 13 Aug 2005 18:53:17 +0200
Message-ID: <1123951997.15215.1.camel@localhost.localdomain>
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
	 <1123949005.11048.16.camel@localhost.localdomain>
	 <42FE2380.5040508@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UBofvDNUkV8NoYC6AkQS"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:52625 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S932205AbVHMQyE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Aug 2005 12:54:04 -0400
In-Reply-To: <42FE2380.5040508@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>


--=-UBofvDNUkV8NoYC6AkQS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-08-13 at 12:44 -0400, Jeff Garzik wrote:

> > BTW afaik you won't be able be able to control DMA on the dvd drive wit=
h
> > this setup, so I'll stick to my patched kernel for the moment (=3D both
> > disk&cdrom are assigned to ide).
>=20
> That's normal for combined mode.  Until libata can do ATAPI (soon!), the=20
> lack of DMA is a necessary evil, since two drivers are trying to claim=20
> two halves of the same hardware.

I already had it working this way, actually, but it has a bad habit of
locking up solid every now and then. So I'll wait and in the meantime
use my patched kernel (=3Dall drives on IDE).

--=-UBofvDNUkV8NoYC6AkQS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBC/iV9JgD/6j32wUYRAgg6AJ9HdmsPm8gzHejqhzr9c8cwv+mvbgCfdvIQ
jx4tuIDw3+26mpqKvMPRpqI=
=etlN
-----END PGP SIGNATURE-----

--=-UBofvDNUkV8NoYC6AkQS--
