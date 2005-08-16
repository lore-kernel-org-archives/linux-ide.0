From: Erik Slagter <erik@slagter.name>
Subject: Re: UDMA modes
Date: Tue, 16 Aug 2005 11:05:17 +0200
Message-ID: <1124183117.5550.58.camel@localhost.localdomain>
References: <42D7AAA0000490E9@mail-2.mail.tiscali.sys>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rbnexQGfS/Fi5Xu18O9D"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:35728 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S965149AbVHPJH2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 05:07:28 -0400
In-Reply-To: <42D7AAA0000490E9@mail-2.mail.tiscali.sys>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sampei02@tiscali.it
Cc: linux-ide@vger.kernel.org


--=-rbnexQGfS/Fi5Xu18O9D
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-08-16 at 09:02 +0200, sampei02@tiscali.it wrote:
> I have motherboard which supports DMA ATA 66/100/133 and I connect HD wit=
h
> new 80-wire cable.
> I have FC3 with Kernel 2.6.9
> With hdparm -i /dev/hda I get:
>=20
> DMA modes: udma0 udma1 udma2
> UDMA modes: udma0 udma1 *udma2
>=20
> Why udma is 2 and not udma 5 ?

Controller not explicitly supported by linux or not configured in the
kernel? Controller needs BITS option? (see IDE config). Harddisk doesn't
support > udma2?

--=-rbnexQGfS/Fi5Xu18O9D
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDAaxNJgD/6j32wUYRArfFAJsFJmamux07MO0O4/nMm40l7ahdbgCdEzO/
aEW62MCtNrJCv79X8pLf0To=
=WikS
-----END PGP SIGNATURE-----

--=-rbnexQGfS/Fi5Xu18O9D--
