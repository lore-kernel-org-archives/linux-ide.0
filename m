From: Erik Slagter <erik@slagter.name>
Subject: Re: TX4000 RAID and sata_promise
Date: Tue, 16 Aug 2005 15:30:54 +0200
Message-ID: <1124199054.5550.71.camel@localhost.localdomain>
References: <01f501c5a223$9faf5470$6f0aa8c0@rgkb.local>
	 <4301E5C5.2030203@dtbb.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oIvpRnFxUQE0P16IY+Ql"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:6852 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S965212AbVHPNbT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 09:31:19 -0400
In-Reply-To: <4301E5C5.2030203@dtbb.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tyler <pml@dtbb.net>
Cc: Yuri Kirsanov <flash@rccb.ru>, linux-ide@vger.kernel.org


--=-oIvpRnFxUQE0P16IY+Ql
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-08-16 at 06:10 -0700, Tyler wrote:
> Check out dmraid or dm_raid (not sure which it goes by, in order to
> google it), it is the package that tries to support "bios raids" on
> ide/sata cards.  It may be what you're looking for.

Even better, forget the whole fake raid from the bios, and use the
mirroring support from the linux kernel.

--=-oIvpRnFxUQE0P16IY+Ql
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDAeqOJgD/6j32wUYRAuj3AJ96t6qMFjSh/pCde2YMoEG6WWIp6QCfZ28W
1mA597jMRzBie9wAhzW6nss=
=6hZa
-----END PGP SIGNATURE-----

--=-oIvpRnFxUQE0P16IY+Ql--
