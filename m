From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: clear ehi description after initial host report
Date: Tue, 9 Oct 2007 14:57:25 +0900
Message-ID: <20071009055725.GF12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:6898 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbXJIF5c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Oct 2007 01:57:32 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1917248wah
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 22:57:31 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

ehi description field is used to carry LLD specific controller
description.  Sometimes, it's used without clearing before and LLD
description gets printed with exception information one more time.
Clear after printing.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 64d2c99..88becd2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6770,13 +6770,14 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 		xfer_mask = ata_pack_xfermask(ap->pio_mask, ap->mwdma_mask,
 					      ap->udma_mask);
 
-		if (!ata_port_is_dummy(ap))
+		if (!ata_port_is_dummy(ap)) {
 			ata_port_printk(ap, KERN_INFO,
 					"%cATA max %s %s\n",
 					(ap->flags & ATA_FLAG_SATA) ? 'S' : 'P',
 					ata_mode_string(xfer_mask),
 					ap->link.eh_info.desc);
-		else
+			ata_ehi_clear_desc(&ap->link.eh_info);
+		} else
 			ata_port_printk(ap, KERN_INFO, "DUMMY\n");
 	}
 
-- 
1.5.0.3

