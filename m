From: Mathias Jeschke <jeschke@informatik.hu-berlin.de>
Subject: ASUS P5B and AHCI with 4 SATA drives (reminder)
Date: Sat, 11 Nov 2006 01:20:16 +0100
Message-ID: <20061111002016.GA3742@mail.majes.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from berlin.zq1.de ([85.25.132.119]:3091 "EHLO mail.majes.de")
	by vger.kernel.org with ESMTP id S1946859AbWKKAUT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Nov 2006 19:20:19 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo kernel hackers,

as I mentioned in my last mail from 2006-08-31 [1],
the AHCI driver (ahci.c) from the default linux kernel tree
does not support all 4 ports of my ASUS P5B mainboard.
(only 2 of 4 hard discs)

I ask you, what is wrong with my patch I attached at the mail
to Jeff and this mailing-list?
I know that introducing a new kernel commandline argument is no smart
way to solve it, but better than no solution, yet. Isn't it?

Has anybody more details about that problem of detecting the right
number of physical ports and their mapping?

Regards,
Mathias

[1] http://marc.theaimsgroup.com/?l=3Dlinux-ide&m=3D115705276301404&w=3D2

--=20
Mathias Jeschke
home: http://www.informatik.hu-berlin.de/~jeschke/
mail: jeschke@informatik.hu-berlin.de
gpg fingerprint: CF50 E22C 50F4 AF70 9628  7AB9 7E10 3A60 EAE5 4729

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFVRdAfhA6YOrlRykRAgbcAJ9BE0GWDyW9RXJthvn4R/kCDC+PhgCfZ2KK
sSEQ/90tYYXseAj4vodjXb0=
=+UcV
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
