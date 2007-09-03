From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes]: libata clear horkage on ata_dev_init()
Date: Mon, 3 Sep 2007 12:20:11 +0900
Message-ID: <20070903032011.GA16890@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:25200 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbXICDUT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 23:20:19 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1749329wah
        for <linux-ide@vger.kernel.org>; Sun, 02 Sep 2007 20:20:19 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

dev->horkage should be cleared over device hotunplug/plug.  Clear it
in ata_dev_init().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2ad4dda..112e7a9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6025,6 +6025,7 @@ void ata_dev_init(struct ata_device *dev)
 	 */
 	spin_lock_irqsave(ap->lock, flags);
 	dev->flags &= ~ATA_DFLAG_INIT_MASK;
+	dev->horkage = 0;
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	memset((void *)dev + ATA_DEVICE_CLEAR_OFFSET, 0,
