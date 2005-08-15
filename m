From: Erik Slagter <erik@slagter.name>
Subject: Re: IDENTIFY DEVICE not working any more?
Date: Mon, 15 Aug 2005 12:34:55 +0200
Message-ID: <1124102095.8189.45.camel@localhost.localdomain>
References: <43005B4D.1090801@conterra.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hgDT5TGp17F6fgLXhFZP"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:20380 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S932659AbVHOKfo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Aug 2005 06:35:44 -0400
In-Reply-To: <43005B4D.1090801@conterra.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dieter =?ISO-8859-1?Q?St=FCken?= <stueken@conterra.de>
Cc: Linux IDE Mailing List <linux-ide@vger.kernel.org>


--=-hgDT5TGp17F6fgLXhFZP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-08-15 at 11:07 +0200, Dieter St=C3=BCken wrote:
> I used smartmontools for sata devices quite successfully awhile.
> Since 2.6.12.2 however, I get an ioerror on "DENTIFY DEVICE"
> errno=3D25 [Inappropriate ioctl for device] and smartctl gives up.
>=20
> So, is the prelimnary SMART support over ATA commands broken again
> and I have to wait patiently until smart over SCSI commands will
> work some day.

Over here it works fine (sata_promise driver + 2.6.12.3 +
smartmontools).

Also afaik the .1/.2/.3 patches did not contain changes to the libata or
scsi layer.

--=-hgDT5TGp17F6fgLXhFZP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDAG/PJgD/6j32wUYRAtJSAJ9c0Vbe2Lcim2tvABwOJhkMTlx+iwCghrQV
tBVg6szhoeIniYKsK9xYT7U=
=HLfg
-----END PGP SIGNATURE-----

--=-hgDT5TGp17F6fgLXhFZP--
