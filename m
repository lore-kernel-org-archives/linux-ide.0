From: Hamish Rodda <rodda@kde.org>
Subject: Problem with Silicon Image SATA (3112) + DVB-T PCI card
Date: Mon, 22 Nov 2004 19:56:06 +1100
Message-ID: <200411221956.09859.rodda@kde.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1967374.UQAyL7uI6b";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:9618 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261995AbUKVI4Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Nov 2004 03:56:16 -0500
Received: from tablet.home (c210-49-200-183.lowrp1.vic.optusnet.com.au [210.49.200.183])
	by mail28.syd.optusnet.com.au (8.12.11/8.12.11) with ESMTP id iAM8uBQb003005
	for <linux-ide@vger.kernel.org>; Mon, 22 Nov 2004 19:56:11 +1100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--nextPart1967374.UQAyL7uI6b
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I am encountering a problem with the following hardware / software=20
combination:

Linux 2.6.10-rc2-mm2 compiled for x86_64 architecture
nForce 3 chipset
Silicon Image 3112 SATA controller
Twinhan (VisionPlus) DVB-t capture card (for receiving digital TV) + latest=
=20
linux-dvb drivers

The problem I'm seeing is that when a sata hard drive is accessed, the FIFO=
=20
buffers on the DVB capture card overflow, resulting in a discontinuity in t=
he=20
video transport stream.  Presumably the sata controller utilises the PCI bu=
s=20
for too long when it is active, preventing the transfer of the buffer's=20
contents in a timely way.

The same problems are often reported by Windows users with the same hardwar=
e,=20
and even with differing hardware (some promise controllers have also be=20
implicated, and I wouldn't be surprised if there were others).  Users with =
a=20
sata controller integrated into the south bridge don't have this problem.
=20
I have tried fiddling with PCI latency settings to no avail.

1. Is there any already existing way to limit the amount of data transferre=
d=20
in one go by the sata controller?

2. Is it possible that a software fix for this issue could be found?  If so:

2a. (preferably) is anyone interested in helping?, or

2b. if this is sufficiently trivial, can someone point me in the right=20
direction to fix this myself, since the specs are open? (I have decent=20
experience with c++, but not with c or the kernel)


I've thought of replacing the motherboard with one which has a sata control=
ler=20
integrated into the southbridge, and I may do that if this is too complicat=
ed=20
to fix, but I thought I'd mention the problem for the benefit of others too=
,=20
and hopefully save myself the added cost...

Thanks,
Hamish.

--nextPart1967374.UQAyL7uI6b
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBoampH8BtnSmIlUYRArj5AJ96YNUAQ8B4bIgKdeikv0L8/jby1ACg4ThG
61qVbPXZOClBix7LeIUkjSk=
=SQMe
-----END PGP SIGNATURE-----

--nextPart1967374.UQAyL7uI6b--
