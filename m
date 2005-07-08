From: Erik Slagter <erik@slagter.name>
Subject: Readahead with softraid1
Date: Fri, 08 Jul 2005 14:00:29 +0200
Message-ID: <1120824029.23681.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MZBx49+zyIMpr65yCxJD"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:61611 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S262459AbVGHMBG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Jul 2005 08:01:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--=-MZBx49+zyIMpr65yCxJD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I am using softraid 1 on two sata disks and I'm trying to get the best
possible performance. IMHO read actions (if properly addressed) should
be split over the two drivers and performed independently. However, I
don't notice anything to back this up. The read performance (with the
dreaded hdparm) shows read performance on sda,sdb and md0 exactly the
same.

I've been playing a bit with readahead and it does matter a bit in that
if I disable readahead for sda/sdb completely, the read rate for these
goes completely down (to be expected) whilst the read rate on md0 stays
the same (also a bit to be expected). Other combinations do not show any
significant impact.

I also played with the i/o scheduler and nr_requests (as from previous
messages here).

What am I doing wrong here???

--=-MZBx49+zyIMpr65yCxJD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCzmrdJgD/6j32wUYRAgriAJ4iA9Su/Z2nI93q5fSzQTiHNXPm4ACdHfsO
ytFL2nau2ImWTvxKRxQFO68=
=53r0
-----END PGP SIGNATURE-----

--=-MZBx49+zyIMpr65yCxJD--
