From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
 driver
Date: Sun, 16 Dec 2007 01:09:22 +1100
Message-ID: <20071216010922.13ef21d0.sfr@canb.auug.org.au>
References: <20071214182109.GA858@localhost.localdomain>
	<20071214182438.GB1017@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__16_Dec_2007_01_09_22_+1100_WWFH_=wHbbmcA3im"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:32905 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756725AbXLOOJd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Dec 2007 09:09:33 -0500
In-Reply-To: <20071214182438.GB1017@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>, Paul Mundt <lethal@linux-sh.org>, Olof Johansson <olof@lixom.net>

--Signature=_Sun__16_Dec_2007_01_09_22_+1100_WWFH_=wHbbmcA3im
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Dec 2007 21:24:38 +0300 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> +	prop =3D (u32 *)of_get_property(dn, "reg-shift", NULL);

This cast is unnecessary.

> +	if (prop)
> +		reg_shift =3D *prop;
> +
> +	prop =3D (u32 *)of_get_property(dn, "pio-mode", NULL);

So is this one.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__16_Dec_2007_01_09_22_+1100_WWFH_=wHbbmcA3im
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHY+AYTgG2atn1QN8RAp21AJ9zGiZQPsyFbyuofbsH57ogiqT92ACaAgKx
N6dQf7DMBkJo7F3DFGm8gMY=
=4aw3
-----END PGP SIGNATURE-----

--Signature=_Sun__16_Dec_2007_01_09_22_+1100_WWFH_=wHbbmcA3im--
