From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] sata_mv: Fix chip type for Hightpoint RocketRaid 1740
Date: Tue, 27 Jan 2009 16:21:12 -0500
Message-ID: <497F7AC8.7070700@rtr.ca>
References: <20070709143841.133abb71@the-village.bc.nu> <4696965E.70403@garzik.org> <497F795D.8090600@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:43902 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755468AbZA0VVN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jan 2009 16:21:13 -0500
In-Reply-To: <497F795D.8090600@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, stable@kernel.org

Fix chip type for the Highpoint RocketRAID 1740 4-port PCI(-X) card.
It really has a Marvell 6042 on it, rather than a (8-port) 5081 chip.
Confirmed by multiple (two) users.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

This patch is a candidate for linux-stable as well.

--- old/drivers/ata/sata_mv.c	2009-01-27 16:03:08.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-27 16:05:15.000000000 -0500
@@ -663,7 +663,7 @@
 	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
 	/* RocketRAID 1720/174x have different identifiers */
 	{ PCI_VDEVICE(TTI, 0x1720), chip_6042 },
-	{ PCI_VDEVICE(TTI, 0x1740), chip_508x },
+	{ PCI_VDEVICE(TTI, 0x1740), chip_6042 },
 	{ PCI_VDEVICE(TTI, 0x1742), chip_508x },
 
 	{ PCI_VDEVICE(MARVELL, 0x6040), chip_604x },
