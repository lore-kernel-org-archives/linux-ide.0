From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: don't normalize UNKNOWN to NONE after
 reset
Date: Tue, 08 Jan 2008 20:26:12 +0900
Message-ID: <47835DD4.4000609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:39910 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039AbYAHL0U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 06:26:20 -0500
Received: by wa-out-1112.google.com with SMTP id v27so13140644wah.23
        for <linux-ide@vger.kernel.org>; Tue, 08 Jan 2008 03:26:19 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Robert Hancock <hancockr@shaw.ca>

After non-classifying reset, ehc->classes[] could contain
ATA_DEV_UNKNOWN which used to be normalized to ATA_DEV_NONE for
consistency.  However, this causes unfortunate side effect for drivers
which have non-classifying hardresets (e.g. sata_nv) by making
hardreset report ATA_DEV_NONE for non-classifying resets and thus
makes EH believe that the port is unoccupied and recovery can be
skipped.  The end result is that after a device is swapped with
another one, the new device isn't attached after the old one is
detached.

This patch makes ata_eh_reset() not normalize UNKNOWN to NONE after
non-classifying resets.  This fixes the above problem.  As UNKNOWN and
NONE are handled differently by only EH hotplug logic, this doesn't
cause other behavior changes.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockr@shaw.ca>
---
Robert, missing new device was a bug in core EH logic not sata_nv.
BTW, I did quite a few hotplug tests with adma=0 and it works just
fine.  No lock up.

 drivers/ata/libata-eh.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index f0124a8..e7757dd 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2157,13 +2157,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		if (ata_link_offline(link))
 			continue;
 
-		/* apply class override and convert UNKNOWN to NONE */
+		/* apply class override */
 		if (lflags & ATA_LFLAG_ASSUME_ATA)
 			classes[dev->devno] = ATA_DEV_ATA;
 		else if (lflags & ATA_LFLAG_ASSUME_SEMB)
 			classes[dev->devno] = ATA_DEV_SEMB_UNSUP; /* not yet */
-		else if (classes[dev->devno] == ATA_DEV_UNKNOWN)
-			classes[dev->devno] = ATA_DEV_NONE;
 	}
 
 	/* record current link speed */

