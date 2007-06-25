From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2.6.22-rc5] libata: kill the infamous abnormal status message
Date: Mon, 25 Jun 2007 21:31:05 +0900
Message-ID: <467FB589.2060900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:8419 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbXFYMbQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 08:31:16 -0400
Received: by py-out-1112.google.com with SMTP id u77so1705721pyb
        for <linux-ide@vger.kernel.org>; Mon, 25 Jun 2007 05:31:12 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

The infamous abnormal status message triggers on not so abnormal cases
including empty port and even when it's being triggered on actual
errors the info it provides is redundant and out of context - higher
level functions will print the info in better safe later anyway.

Also, by being triggered all the time, it leads people to think that
the abnormality is somehow related to all ATA and system problems
they're experiencing and gives owners of healthy systems unfounded
doubts about the integrity of the universe.  Make it a DPRINTK and
save the universe.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/libata.h |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 745c4f9..a3380f8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1088,11 +1088,9 @@ static inline u8 ata_wait_idle(struct ata_port *ap)
 {
 	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 
-	if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ))) {
-		if (ata_msg_warn(ap))
-			printk(KERN_WARNING "ATA: abnormal status 0x%X on port 0x%p\n",
-				status, ap->ioaddr.status_addr);
-	}
+	if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ)))
+		DPRINTK("ATA: abnormal status 0x%X on port 0x%p\n",
+			status, ap->ioaddr.status_addr);
 
 	return status;
 }
