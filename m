From: Erik Slagter <erik@slagter.name>
Subject: Re: libata and PATA devices
Date: Tue, 16 Aug 2005 09:21:22 +0200
Message-ID: <1124176883.4314.3.camel@localhost.localdomain>
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
	 <1123951997.15215.1.camel@localhost.localdomain>  <43010B78.7050807@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-19Qzh7cJcowubHHAKGcU"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:35234 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S932614AbVHPHWE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 03:22:04 -0400
In-Reply-To: <43010B78.7050807@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org


--=-19Qzh7cJcowubHHAKGcU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-08-15 at 17:39 -0400, Mark Lord wrote:
> > I already had it working this way, actually, but it has a bad habit of
> > locking up solid every now and then. So I'll wait and in the meantime
> > use my patched kernel (=3Dall drives on IDE).
>=20
> That's a different problem, with a one-liner fix recently
> posted to address it -- Jeff even has the one-liner out
> for 2.6.13 now, I believe.

Yep, I already applied it. Seems to work for me.

--=-19Qzh7cJcowubHHAKGcU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDAZPyJgD/6j32wUYRAlzxAJ9VZ2fRzmKH+ZnhrskbtGKFwcQnnwCeKz2z
prEmKAvETcmCEJGOTlW0UNw=
=6C3F
-----END PGP SIGNATURE-----

--=-19Qzh7cJcowubHHAKGcU--
