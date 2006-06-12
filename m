From: Jim Paris <jim@jtan.com>
Subject: libata-tj-stable success report, with minor patch
Date: Sun, 11 Jun 2006 22:23:58 -0400
Message-ID: <20060612022358.GA29164@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:32923 "EHLO neurosis.jim.sh")
	by vger.kernel.org with ESMTP id S1750712AbWFLCYG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jun 2006 22:24:06 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hello Tejun,

I recently purchased a Norco DS-1220[1] 12-bay SATA enclosure from
Newegg[2].  It comes with a sil3124-based PCI/X card and uses sil3726
port multipliers.  Ater unsuccesfully wrestling with buggy proprietry
drivers included in the box, I found your libata-tj-stable[3] patches
and applied them to 2.6.16.19.  With the minor fix below, it seems to
be working wonderfully.  Thank you!!

The enclosure takes 4 SATA connections.  Bays appear connected like thi=
s:
  ata1.00    =3D bay 5
  ata1.01-04 =3D bay 1-4
  ata2.00    =3D bay 10
  ata2.01-04 =3D bay 6-9
  ata3.00    =3D bay 11
  ata4.00    =3D bay 12

Your patches only detected the first 4 out of 5 ports on each PM.
To fix this, I made this (admittedly na=EFve) change:

--- drivers/scsi/libata-pm.orig	2006-06-11 21:01:28.000000000 -0400
+++ drivers/scsi/libata-pm.c	2006-06-11 21:03:57.000000000 -0400
@@ -324,7 +324,7 @@
 	 * it requires hardreset to resume PM links.
 	 */
 	if (vendor =3D=3D 0x1095 && devid =3D=3D 0x4726) {
-		*nr_ports -=3D 2;
+		*nr_ports -=3D 1;
 		*link_flags |=3D ATA_LFLAG_HRST_TO_RESUME;
 	}
 }

The patch is also available here[4], along with dmesg and lspci output.
With this, all 12 bays are working fine.  I also did some limited
hotplug testing and ran into no problems at all.  Again, thank you!

-jim

[1] http://www.norcotek.com/news.php?news_id=3D24
[2] http://www.newegg.com/Product/Product.asp?Item=3DN82E16816133001
[3] http://home-tj.org/wiki/index.php/Libata-tj-stable
[4] http://jim.sh/~jim/libata/
