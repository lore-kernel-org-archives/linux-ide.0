From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/11] libata: make reset methods complain when they fail
Date: Wed, 5 Apr 2006 22:17:32 +0900
Message-ID: <20060405131732.GD31998@htj.dyndns.org>
References: <20060405131637.GB31998@htj.dyndns.org> <20060405131713.GC31998@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.236]:57611 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751110AbWDENRi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Apr 2006 09:17:38 -0400
Received: by wproxy.gmail.com with SMTP id i7so184874wra
        for <linux-ide@vger.kernel.org>; Wed, 05 Apr 2006 06:17:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060405131713.GC31998@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Make reset methods complain loud when they fail.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    8 +++++---
 drivers/scsi/sata_sil24.c  |    2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

9a205828931c54fcf51c21119254b96d4c8440ca
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 9e49251..ed089a0 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2232,8 +2232,10 @@ static unsigned int ata_bus_softreset(st
 	 * the bus shows 0xFF because the odd clown forgets the D7
 	 * pulldown resistor.
 	 */
-	if (ata_check_status(ap) == 0xFF)
+	if (ata_check_status(ap) == 0xFF) {
+		printk(KERN_ERR "ata%u: SRST failed (status 0xFF)\n", ap->id);
 		return AC_ERR_OTHER;
+	}
 
 	ata_bus_post_reset(ap, devmask);
 
@@ -2494,8 +2496,8 @@ int sata_std_hardreset(struct ata_port *
 	}
 
 	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
-		printk(KERN_ERR "ata%u: COMRESET failed "
-		       "(device not ready)\n", ap->id);
+		printk(KERN_ERR
+		       "ata%u: COMRESET failed (device not ready)\n", ap->id);
 		return -EIO;
 	}
 
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 7f3fbac..60dd6f1 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -474,7 +474,7 @@ static int sil24_softreset(struct ata_po
 	writel(irq_enable, port + PORT_IRQ_ENABLE_SET);
 
 	if (!(irq_stat & PORT_IRQ_COMPLETE)) {
-		DPRINTK("EXIT, srst failed\n");
+		printk(KERN_ERR "ata%u: softreset failed (timeout)\n", ap->id);
 		return -EIO;
 	}
 
-- 
1.2.4

