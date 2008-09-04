From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] sata_mv add RocketRaid 1720 PCI ID to driver
Date: Thu, 04 Sep 2008 18:16:46 -0400
Message-ID: <48C05E4E.6090407@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050709050307040107020404"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:58725 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755148AbYIDWQs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Sep 2008 18:16:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: Petr Jelen <petr.jelen@gmail.com>

This is a multi-part message in MIME format.
--------------050709050307040107020404
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Add PCI ID for RocketRAID 1720 to sata_mv.

Signed-off-by: Petr Jelen <petr.jelen@gmail.com>
Signed-off-by: Mark Lord <mlord@pobox.com>

---

This is for 2.6.27.  Pretty harmless.

--- linux-2.6.27-rc4/drivers/ata/sata_mv.c	2008-08-29 21:35:45.000000000 +0200
+++ linux/drivers/ata/sata_mv.c	2008-08-29 21:36:38.000000000 +0200
@@ -667,7 +667,8 @@
 	{ PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
 	{ PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
 	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
-	/* RocketRAID 1740/174x have different identifiers */
+	/* RocketRAID 1720/174x have different identifiers */
+	{ PCI_VDEVICE(TTI, 0x1720), chip_6042 },
 	{ PCI_VDEVICE(TTI, 0x1740), chip_508x },
 	{ PCI_VDEVICE(TTI, 0x1742), chip_508x },
 



--------------050709050307040107020404
Content-Type: text/x-diff;
 name="rr1720.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rr1720.patch"

--- linux-2.6.26/drivers/ata/sata_mv.c.orig	2008-08-29 21:35:45.000000000 +0200
+++ linux-2.6.26/drivers/ata/sata_mv.c	2008-08-29 21:36:38.000000000 +0200
@@ -667,7 +667,8 @@
 	{ PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
 	{ PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
 	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
-	/* RocketRAID 1740/174x have different identifiers */
+	/* RocketRAID 1720/174x have different identifiers */
+	{ PCI_VDEVICE(TTI, 0x1720), chip_6042 },
 	{ PCI_VDEVICE(TTI, 0x1740), chip_508x },
 	{ PCI_VDEVICE(TTI, 0x1742), chip_508x },
 

--------------050709050307040107020404--
