From: Willy Gardiol <willy@gardiol.org>
Subject: Promise and sparc64
Date: Sat, 20 Dec 2003 19:53:49 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200312201953.50714.willy@gardiol.org>
Reply-To: willy@gardiol.org
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alfa.fastwebnet.it ([213.140.2.55]:7348 "EHLO
	alfa.fastwebnet.it") by vger.kernel.org with ESMTP id S264944AbTLTSxw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Dec 2003 13:53:52 -0500
Content-Description: clearsigned data
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I have got an Ultra5 (sparc based, sun4u) and tried to plug both a Prom=
ise=20
Ultra100tx2 (pdc20268) and a Promise FastTrack 2000 (pcd20271).

The system boots and the kernel (2.4.23) works, the two UDMA100 disks p=
lugged=20
(one per channel) on the promised works in PIO mode.

If i enable DMA on a single drive it WORKS (up to udma2 tested, with hd=
parm=20
- -X66)=20
When i enable DMA on the other channel (it does not count which one) i =
start=20
getting many DMA errors (-20 and -22 error codes) and soon the disks ha=
ngs=20
bringing the system down (but no kernel panic).

Similar, if i enable DMA on one channel then start coping data bethween=
 the=20
two channels the systems suffers the same symptoms.

Please note, both the controller and the disks have been used successfu=
lly in=20
UDMA5 on a x86 system before, and now the disks positively works in mdm=
a2=20
using the onboard CMD ide controller of the Ultra5 (does not seems to b=
e able=20
to do UDMA at all)

Is this a know issue?


- --=20

!=20
 Willy Gardiol - willy@gardiol.org
 www.gardiol.org
 Use linux for your freedom.

  "Linux is like a wigwam: no windows,
   no gates, Apache inside."

  "Linux =E8 come una tenda indiana: niente finestre,
   niente porte, gli Apache dentro.

      Albert Arendsen



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/5Jq9Q9qolN/zUk4RAvTlAKCYfE2rP5bWTqPaD1yhCvpffwcEsQCgnQoF
qS/Dyo0oxVDlM4S3+SHaYTA=3D
=3DFIAW
-----END PGP SIGNATURE-----

