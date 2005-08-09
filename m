From: Erik Slagter <erik@slagter.name>
Subject: Re: libata and PATA devices
Date: Tue, 09 Aug 2005 19:05:33 +0200
Message-ID: <1123607133.28278.5.camel@localhost.localdomain>
References: <200508071949.03782.inform@tiker.net>
	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org>
	 <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aPI81uX5V9im2tg/NC5D"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:60877 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S964888AbVHIRGE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Aug 2005 13:06:04 -0400
In-Reply-To: <42F8B41C.4040408@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org


--=-aPI81uX5V9im2tg/NC5D
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-08-09 at 09:48 -0400, Mark Lord wrote:

> The libata code is taking forever to catch up to modern reality,
> mostly because so much of it lives eternally in Jeff's private
> git repository, where only a few people ever exercise the code.

I'd suggest sending some of it to Andy Morton, so it becomes a -mm patch
and it can be applied by non-git-people. Also imho it will get much
wider testing.

> As is, it's pretty good, except for the broken libata error handling
> that (by default) locks up machines every hour or two.

Exactly, that's why I don't use it for the moment.

And that's why I had to patch the standard ide support's PCI ID list
(and got some angry intel engineer barking on me).

> But there's also a fix for that, again floating around only in private re=
positories.

Grmbl.


--=-aPI81uX5V9im2tg/NC5D
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBC+OJdJgD/6j32wUYRAqQDAJ9LrFqKgRnKVuZwgQiChQqufGzGQgCdGjkD
Kv7ATLujIcxU8PV01T+uU5I=
=RfoO
-----END PGP SIGNATURE-----

--=-aPI81uX5V9im2tg/NC5D--
