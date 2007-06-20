From: Patrick Nagel <mail@patrick-nagel.net>
Subject: Random freezes with libata + ICH7 PATA
Date: Wed, 20 Jun 2007 13:43:59 +0800
Message-ID: <200706201344.03808.mail@patrick-nagel.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2688369.2znCrjjWm7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from patrick-nagel.net ([85.214.68.60]:1567 "EHLO patrick-nagel.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268AbXFTFya (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Jun 2007 01:54:30 -0400
Received: from [192.168.178.21] (unknown [218.81.208.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by patrick-nagel.net (Postfix) with ESMTP id 0F3601027C6
	for <linux-ide@vger.kernel.org>; Wed, 20 Jun 2007 05:44:10 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--nextPart2688369.2znCrjjWm7
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I tried libata with my ICH7 PATA controller for some (five? seven?) days.=20
During those days I experienced four random system freezes. I guess this=20
message is not all that helpful - I have no idea what information I should=
=20
have collected so it could be used for debugging. But at least now you know=
=20
there is a problem at all. ;)
After switching back to the old IDE driver, the system runs stable again fo=
r=20
three days or so, so it's not a sudden coincidental hardware problem.

Some details about my system (a Samsung R65 laptop, custom harddisk):

$ lspci | grep IDE
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controlle=
r=20
(rev 02)

$ dmesg | grep "hd[ab]: "
hda: HTS721010G9AT00, ATA DISK drive
hdb: DV-W28EA, ATAPI CD/DVD-ROM drive
hda: max request size: 512KiB
hda: 195371568 sectors (100030 MB) w/7539KiB Cache, CHS=3D16383/255/63,=20
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdb: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 1419kB Cache, UDMA(33)

Kernel versions I tried (the problem appeared in both):
=2D 2.6.21 with CK patchset
=2D 2.6.21.5 with Gentoo patchset (http://dev.gentoo.org/~dsd/genpatches)=20
(gentoo-sources-2.6.21-r3 package in Gentoo's repository)

There was no particularly heavy IDE load during the freezes.

If I can be of help with more information, please tell me what you need.

Patrick.

=2D-=20
Key ID: 0x86E346D4            http://patrick-nagel.net/key.asc
=46ingerprint: 7745 E1BE FA8B FBAD 76AB 2BFC C981 E686 86E3 46D4

--nextPart2688369.2znCrjjWm7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iD8DBQBGeL6jyYHmhobjRtQRAoLZAJ0eaqBYopChW4u0uydRvbU2Zt+DbQCgyEJr
Hz75bHOnhxQ1NeZOEdINIDs=
=fn6W
-----END PGP SIGNATURE-----

--nextPart2688369.2znCrjjWm7--
