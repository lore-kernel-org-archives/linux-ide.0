From: Chuck Ebbert <cebbert@redhat.com>
Subject: [patch, resend] libata: Fix LBA48 on pata_it821x RAID volumes.
Date: Sun, 26 Oct 2008 18:10:19 -0400
Message-ID: <20081026181019.073dd529@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:47891 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504AbYJZWKr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Oct 2008 18:10:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Ondrej Zary <linux@rainbow-software.org>, Alan Cox <alan@redhat.com>

From: Ondrej Zary <linux@rainbow-software.org>

libata: Fix LBA48 on pata_it821x RAID volumes.

[http://lkml.org/lkml/2008/10/18/82]

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
Acked-by: Alan Cox <alan@redhat.com>

--- linux-2.6.27-orig/drivers/ata/pata_it821x.c	2008-10-18 17:09:07.000000000 +0200
+++ linux-2.6.27-pentium/drivers/ata/pata_it821x.c	2008-10-18 17:10:24.000000000 +0200
@@ -557,9 +557,8 @@
 	if (strstr(model_num, "Integrated Technology Express")) {
 		/* Set feature bits the firmware neglects */
 		id[49] |= 0x0300;	/* LBA, DMA */
-		id[82] |= 0x0400;	/* LBA48 */
 		id[83] &= 0x7FFF;
-		id[83] |= 0x4000;	/* Word 83 is valid */
+		id[83] |= 0x4400;	/* Word 83 is valid and LBA48 */
 		id[86] |= 0x0400;	/* LBA48 on */
 		id[ATA_ID_MAJOR_VER] |= 0x1F;
 	}

