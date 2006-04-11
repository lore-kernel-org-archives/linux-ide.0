From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] libata: make reset methods complain when they fail
Date: Tue, 11 Apr 2006 22:16:45 +0900
Message-ID: <1144761405822-git-send-email-htejun@gmail.com>
References: <11447614041095-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.226]:54135 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750814AbWDKNQs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:16:48 -0400
Received: by wproxy.gmail.com with SMTP id i11so920396wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:16:47 -0700 (PDT)
In-Reply-To: <11447614041095-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make reset methods complain loud when they fail.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    8 +++++---
 drivers/scsi/sata_sil24.c  |    2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

3bf1cd4f285525deb2381a6f9d625a0f25007899
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


