From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Sat, 28 Jan 2006 00:54:02 +0100
Message-ID: <1138406042.2953.0.camel@rousalka.dyndns.org>
References: <43D8637F.5030207@gmail.com>
	 <37416.192.54.193.25.1138266889.squirrel@rousalka.dyndns.org>
	 <20060126092120.GP4212@suse.de>
	 <5840.192.54.193.25.1138269692.squirrel@rousalka.dyndns.org>
	 <1138309495.3968.3.camel@rousalka.dyndns.org>
	 <20060127081319.GU4311@suse.de>
	 <65391.192.54.193.25.1138351983.squirrel@rousalka.dyndns.org>
	 <20060127091002.GX4311@suse.de> <20060127092046.GY4311@suse.de>
	 <58cb370e0601270146n40a5b249v53a736a8021c82f4@mail.gmail.com>
	 <20060127095039.GA4311@suse.de>
	 <1138390636.3017.2.camel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Fa/0cWJvxEQSnOk9q2Er"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx.laposte.net ([81.255.54.11]:25065 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S1422710AbWA0Xzt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jan 2006 18:55:49 -0500
In-Reply-To: <1138390636.3017.2.camel@rousalka.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>


--=-Fa/0cWJvxEQSnOk9q2Er
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le vendredi 27 janvier 2006 =C3=A0 20:37 +0100, Nicolas Mailhot a =C3=A9cri=
t :
> Le vendredi 27 janvier 2006 =C3=A0 10:50 +0100, Jens Axboe a =C3=A9crit :
>=20
> > Of course, silly typo! Thanks for catching that. Update patch below.
> =20
> ...
>=20
> a patched kernel reboots before finishing to initialize (Just before it
> prints a line starting with SCSI - the rest is too fast for me to catch)
>=20
> Now the kernel base is slightly different from yesterday, so the bug may
> be in the base not the patch. I'll rebuild a new kernel with the same
> base and yesterday's patch to check this now

I can confirm today's patch is not OK. The same baseline with
yesterday's patch boot fine.

--=20
Nicolas Mailhot

--=-Fa/0cWJvxEQSnOk9q2Er
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEABECAAYFAkPaspoACgkQI2bVKDsp8g2ieQCfXhYaEui+/hF99XSPjWlGoUBY
IRIAoIVj0PJCZzuKFUQixTSQOrJH8Rmj
=j6m8
-----END PGP SIGNATURE-----

--=-Fa/0cWJvxEQSnOk9q2Er--

