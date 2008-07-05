From: Nigel Kukard <nkukard@lbsd.net>
Subject: sata_sil: int slow_down uninitialized
Date: Sat, 05 Jul 2008 08:58:52 +0000
Message-ID: <1215248332.3396.16.camel@nigel-x60>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ISmKQszp4U2kD/JJacaN"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-0-3.linuxrulz.org ([66.197.129.166]:50568 "EHLO
	smtp-0-3.linuxrulz.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbYGEJ3G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jul 2008 05:29:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org


--=-ISmKQszp4U2kD/JJacaN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Guys,

Maybe I'm wrong, but line 247 of sata_sil...
static int slow_down;

is not initialized and used on line 540.

Is this right?

-N

--=-ISmKQszp4U2kD/JJacaN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBIbzfMKoUGSidwLE4RAiKsAKCpqeuuZVehEsLBEjGKCPeTPpqKLgCgkfWX
pWEEULBuTz70rrBN/UY5C1w=
=tNrx
-----END PGP SIGNATURE-----

--=-ISmKQszp4U2kD/JJacaN--

