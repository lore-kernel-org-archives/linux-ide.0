From: Andreas =?iso-8859-1?q?Kl=F6ckner?= <inform@tiker.net>
Subject: libata and PATA devices
Date: Sun, 7 Aug 2005 19:48:59 +0200
Message-ID: <200508071949.03782.inform@tiker.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3618695.lELxVAjaSR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:44486 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1752455AbVHGRtI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Aug 2005 13:49:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

--nextPart3618695.lELxVAjaSR
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hey Jeff, all,

I was wondering why ATA_ENABLE_PATA and ATA_ENABLE_ATAPI are #undef'ed in=20
include/linux/libata.h by default, since reverting them to #define's was th=
e=20
only way to make the ata-piix driver detect my CDROM on my new shiny ThinkP=
ad=20
(Intel Corp. 82801FBM (ICH6M) SATA Controller). I would assume that most=20
people would want this. The drive worked out of the box on Ubuntu, so I=20
assume that their vendor patch includes this anyway.

Is there a specific reason that these are disabled? Are there any bad=20
consequences that I'm not aware of? Only reading the source really revealed=
=20
that this was the way to get my CD-ROM to work.

Thanks,
Andreas

--nextPart3618695.lELxVAjaSR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBC9kmPJZ7T4Hn4+FIRApMGAKCG1NlE1D87NrCdwgPwA9eD+Zf+YACeJ3+z
0uDNOuzKppKQKb+RCUGbVJk=
=ZLSb
-----END PGP SIGNATURE-----

--nextPart3618695.lELxVAjaSR--
