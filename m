From: Brett Russ <russb@emc.com>
Subject: [PATCH libata-dev-2.6] libata: flush COMRESET write
Date: Fri, 25 Mar 2005 18:19:07 -0500 (EST)
Message-ID: <20050325231907.E1D11BADC@lns1032.lss.emc.com>
Received: from mailhub.lss.emc.com ([168.159.2.31]:42707 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261843AbVCYXTK
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Mar 2005 18:19:10 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jeff,

I'm seeing single drives getting stuck in ata_busy_sleep() with these
log messages on boot:

<4>ata2 is slow to respond, please be patient
<3>ata2 failed to respond (30 secs)

One thing I found was the bug fixed below, where the COMRESET wasn't
getting flushed properly.  This may or may not be the reason, but it
can't hurt.  I have to keep looking and testing.

I wanted to also send a separate patch to ensure the port was stopped
before issuing COMRESET, since this is required by at least the ICH6R,
but the port_stop() routines seemed too heavy to call from
__sata_phy_reset() so I'm not sending anything like that yet.

Signed-off-by: Brett Russ <russb@emc.com>

Index: libata-dev-2.6/drivers/scsi/libata-core.c
===================================================================
--- libata-dev-2.6.orig/drivers/scsi/libata-core.c	2005-03-23 16:44:48.000000000 -0500
+++ libata-dev-2.6/drivers/scsi/libata-core.c	2005-03-25 16:58:22.000000000 -0500
@@ -1262,7 +1262,7 @@
 
 	if (ap->flags & ATA_FLAG_SATA_RESET) {
 		scr_write(ap, SCR_CONTROL, 0x301); /* issue phy wake/reset */
-		scr_read(ap, SCR_STATUS);	/* dummy read; flush */
+		scr_read(ap, SCR_CONTROL);	/* dummy read; flush */
 		udelay(400);			/* FIXME: a guess */
 	}
 	scr_write(ap, SCR_CONTROL, 0x300);	/* issue phy wake/clear reset */
