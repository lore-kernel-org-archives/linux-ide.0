From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Thu, 26 Jan 2006 22:04:55 +0100
Message-ID: <1138309495.3968.3.camel@rousalka.dyndns.org>
References: <20060126055050.GA4737@htj.dyndns.org>
	 <43D8637F.5030207@gmail.com>
	 <37416.192.54.193.25.1138266889.squirrel@rousalka.dyndns.org>
	 <20060126092120.GP4212@suse.de>
	 <5840.192.54.193.25.1138269692.squirrel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8jCu1L8aJ/3omMtw+pC4"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx.laposte.net ([81.255.54.11]:25740 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S964890AbWAZVGC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 16:06:02 -0500
In-Reply-To: <5840.192.54.193.25.1138269692.squirrel@rousalka.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>


--=-8jCu1L8aJ/3omMtw+pC4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le jeudi 26 janvier 2006 =C3=A0 11:01 +0100, Nicolas Mailhot a =C3=A9crit :
> Le Jeu 26 janvier 2006 10:21, Jens Axboe a =C3=A9crit :
> > On Thu, Jan 26 2006, Nicolas Mailhot wrote:
>=20
> >> What parts can be done one a pre-breakage kernel and what parts on a
> >> problem kernel (I ask this because a problem kernel will corrupt
> >> basically
> >> any file it writes to, even in single login mode the damage is
> >> significant
> >> so I need to limit the corruption window to minimum).
> >
> > You need a new kernel (after the barrier rework), so 2.6.16-rc1 for
> > instance.
>=20
> Ok, I'll do the test this evening (CET) with the rawhide/davej kernel-of
> the day.

I applied the fua backout patch and the kernel booted beautifully.
Now I guess I need to see if Maxtor released a fixed firmware right ?
(is it possible to change the firmware on a running system ?)

Regards,

--=20
Nicolas Mailhot

--=-8jCu1L8aJ/3omMtw+pC4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEABECAAYFAkPZOXcACgkQI2bVKDsp8g2upACg5R+z3GQvmsUVM3K2kE72fAuW
tH8AoI8O74ZJVTqP4Ca4hEyRWnQ+Q1V8
=D/RE
-----END PGP SIGNATURE-----

--=-8jCu1L8aJ/3omMtw+pC4--

