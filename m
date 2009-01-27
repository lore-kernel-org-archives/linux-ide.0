From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] sata_mv: Fix chip type for Hightpoint RocketRaid 1740/1742
Date: Tue, 27 Jan 2009 16:33:13 -0500
Message-ID: <497F7D99.4060108@rtr.ca>
References: <20070709143841.133abb71@the-village.bc.nu> <4696965E.70403@garzik.org> <497F795D.8090600@rtr.ca> <497F7AC8.7070700@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:56906 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908AbZA0VdO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jan 2009 16:33:14 -0500
In-Reply-To: <497F7AC8.7070700@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, stable@kernel.org

Fix chip type for the Highpoint RocketRAID 1740 and 1742 PCI cards.
These really do have Marvell 6042 chips on them, rather than the 5081 chip.

Confirmed by multiple (two) users (for the 1740), and by examining
the product photographs from Highpoint's web site.

Signed-off-by: Mark Lord <mlord@pobox.com>
---
This replaces the earlier 1740-only version of the patch.
This patch is a candidate for linux-stable as well.

--- old/drivers/ata/sata_mv.c	2009-01-27 16:03:08.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-27 16:28:15.000000000 -0500
@@ -663,8 +663,8 @@
 	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
 	/* RocketRAID 1720/174x have different identifiers */
 	{ PCI_VDEVICE(TTI, 0x1720), chip_6042 },
-	{ PCI_VDEVICE(TTI, 0x1740), chip_508x },
-	{ PCI_VDEVICE(TTI, 0x1742), chip_508x },
+	{ PCI_VDEVICE(TTI, 0x1740), chip_6042 },
+	{ PCI_VDEVICE(TTI, 0x1742), chip_6042 },
 
 	{ PCI_VDEVICE(MARVELL, 0x6040), chip_604x },
 	{ PCI_VDEVICE(MARVELL, 0x6041), chip_604x },
