From: Erik Slagter <erik@slagter.name>
Subject: Re: TX4000 RAID and sata_promise
Date: Tue, 16 Aug 2005 15:50:07 +0200
Message-ID: <1124200207.5550.74.camel@localhost.localdomain>
References: <01f501c5a223$9faf5470$6f0aa8c0@rgkb.local>
	 <4301E5C5.2030203@dtbb.net>
	 <1124199054.5550.71.camel@localhost.localdomain>
	 <015701c5a267$594284f0$6f0aa8c0@rgkb.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rynFp2p6qP3sZBZzhn9l"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:55508 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S965228AbVHPNvF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 09:51:05 -0400
In-Reply-To: <015701c5a267$594284f0$6f0aa8c0@rgkb.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuri Kirsanov <flash@rccb.ru>
Cc: linux-ide@vger.kernel.org


--=-rynFp2p6qP3sZBZzhn9l
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-08-16 at 17:35 +0400, Yuri Kirsanov wrote:
> Right, I'd like to do that, but even when no raid is defined in BIOS, Lin=
ux
> can't see any hard disks on any ports of that card...
> I'll check out dmraid today's evening. Thanks for replies.

You'd better take on step at a time. That is, first get linux to
recognise the harddisk, THEN make a (linux) mirror on it.

--=-rynFp2p6qP3sZBZzhn9l
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDAe8PJgD/6j32wUYRApbaAJ9Rf+rEVMWyj9MkStOoCOwTG6YUQQCcDWU2
Empw/R/aBgXCBMUKG3keUhw=
=1BcQ
-----END PGP SIGNATURE-----

--=-rynFp2p6qP3sZBZzhn9l--
