From: Erik Slagter <erik@slagter.name>
Subject: Re: UDMA modes
Date: Thu, 18 Aug 2005 11:06:48 +0200
Message-ID: <1124356009.8720.26.camel@localhost.localdomain>
References: <42D7AA4700049B26@mail-5.mail.tiscali.sys>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-T9ZJT1jvYFk6nJb760yk"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:21151 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S932135AbVHRJHQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Aug 2005 05:07:16 -0400
In-Reply-To: <42D7AA4700049B26@mail-5.mail.tiscali.sys>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sampei02@tiscali.it
Cc: "Eric D. Mudama" <edmudama@gmail.com>, linux-ide@vger.kernel.org


--=-T9ZJT1jvYFk6nJb760yk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-08-18 at 08:19 +0200, sampei02@tiscali.it wrote:

> Probing IDE interface ide1...
> hdd: LG CD-ROM CRD-8521B, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15

??? Your cdrom drive is slave with no master?

> hda: max request size: 128KiB
> hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=3D65535/16/63, UDM=
A(33)
> hda: cache flushes supported

There you have it, the ide driver thinks your drive can only handle
UDMA/33. Maybe it's on a blacklist?

--=-T9ZJT1jvYFk6nJb760yk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDBE+oJgD/6j32wUYRAvbBAJ9Yli3oHvNNXWRDjVwwlxDmVpMu1ACfWGJ0
0B2UZugS+XoWOjPpv9DzAvM=
=BzQe
-----END PGP SIGNATURE-----

--=-T9ZJT1jvYFk6nJb760yk--
