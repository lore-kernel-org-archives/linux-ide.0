From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/10] libata: ata_dev_disable() should be called from EH context
Date: Sat, 15 Dec 2007 15:05:00 +0900
Message-ID: <11976987074039-git-send-email-htejun@gmail.com>
References: <11976987063011-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:53450 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756969AbXLOGFN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Dec 2007 01:05:13 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1193515rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 14 Dec 2007 22:05:13 -0800 (PST)
In-Reply-To: <11976987063011-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_port_detach() calls ata_dev_disable() with host lock held but
ata_dev_disable() should be called from EH context.  ata_port_detach()
steals EH context by setting ATA_PFLAG_UNLOADAING and flushing EH.
Drop locking around ata_dev_disable() and note that ata_port_detach()
owns EH context at that point.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e4dea86..a8131e5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -7208,18 +7208,14 @@ static void ata_port_detach(struct ata_port *ap)
 
 	ata_port_wait_eh(ap);
 
-	/* EH is now guaranteed to see UNLOADING, so no new device
-	 * will be attached.  Disable all existing devices.
+	/* EH is now guaranteed to see UNLOADING - EH context belongs
+	 * to us.  Disable all existing devices.
 	 */
-	spin_lock_irqsave(ap->lock, flags);
-
 	ata_port_for_each_link(link, ap) {
 		ata_link_for_each_dev(dev, link)
 			ata_dev_disable(dev);
 	}
 
-	spin_unlock_irqrestore(ap->lock, flags);
-
 	/* Final freeze & EH.  All in-flight commands are aborted.  EH
 	 * will be skipped and retrials will be terminated with bad
 	 * target.
-- 
1.5.2.4

