From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes 1/2] libata: allow LLDs w/o any reset method
Date: Thu, 06 Mar 2008 13:09:34 +0900
Message-ID: <47CF6E7E.6090201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.188]:60810 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222AbYCFEJp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Mar 2008 23:09:45 -0500
Received: by gv-out-0910.google.com with SMTP id s4so1355754gve.37
        for <linux-ide@vger.kernel.org>; Wed, 05 Mar 2008 20:09:44 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>

Some old SFF controllers don't have any way to reset the channel.
Currently, this isn't supported and libata EH causes an oops.  Allow
LLDs w/o any reset method and just assume ATA class in such cases.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/ata/libata-eh.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -2150,6 +2150,15 @@ int ata_eh_reset(struct ata_link *link, 
 			ap->ops->set_piomode(ap, dev);
 	}
 
+	if (!softreset && !hardreset) {
+		if (verbose)
+			ata_link_printk(link, KERN_INFO, "no reset method "
+					"available, skipping reset\n");
+		if (!(lflags & ATA_LFLAG_ASSUME_CLASS))
+			lflags |= ATA_LFLAG_ASSUME_ATA;
+		goto done;
+	}
+
 	/* Determine which reset to use and record in ehc->i.action.
 	 * prereset() may examine and modify it.
 	 */
@@ -2254,6 +2263,7 @@ int ata_eh_reset(struct ata_link *link, 
 		lflags |= ATA_LFLAG_ASSUME_ATA;
 	}
 
+ done:
 	ata_link_for_each_dev(dev, link) {
 		/* After the reset, the device state is PIO 0 and the
 		 * controller state is undefined.  Reset also wakes up
