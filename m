From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream 1/3] libata: use ata_port_printk() in ata_wait_idle()
Date: Mon, 30 Jul 2007 14:23:03 +0900
Message-ID: <20070730052303.GH22374@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:6300 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933442AbXG3FXL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jul 2007 01:23:11 -0400
Received: by rv-out-0910.google.com with SMTP id k20so337109rvb
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2007 22:23:10 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

ata_wait_idle() identified controller by printing out the address of
the Status register.  This is bogus because 1. it's iomapped address
2. some controllers don't have Status register and don't initialize
the field.  Use ata_port_printk() instead.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Currently there's no equivalent ata_msg_* level for ATA_DEBUG, so the
printk is conditionalized with #ifdef ATA_DEBUG.  We need to kill
ATA_DEBUG, ATA_VERBOSE_DEBUG and integrate them into ata_msg_* in the
future.

 include/linux/libata.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -1106,9 +1106,11 @@ static inline u8 ata_wait_idle(struct at
 {
 	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 
+#ifdef ATA_DEBUG
 	if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ)))
-		DPRINTK("ATA: abnormal status 0x%X on port 0x%p\n",
-			status, ap->ioaddr.status_addr);
+		ata_port_printk(ap, KERN_DEBUG, "abnormal Status 0x%X\n",
+				status);
+#endif
 
 	return status;
 }
