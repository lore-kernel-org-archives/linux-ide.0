From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/5] sata_sil24: better error message from softreset
Date: Tue, 11 Apr 2006 22:22:29 +0900
Message-ID: <11447617493747-git-send-email-htejun@gmail.com>
References: <11447617493149-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.231]:30078 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750823AbWDKNWe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:22:34 -0400
Received: by wproxy.gmail.com with SMTP id i3so957218wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:22:33 -0700 (PDT)
In-Reply-To: <11447617493149-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Improve softreset error message.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

acf5b3fda42c68a0f4a84131e50f8514faebee94
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 512ee6f..c75c228 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -435,6 +435,7 @@ static int sil24_softreset(struct ata_po
 	dma_addr_t paddr = pp->cmd_block_dma;
 	unsigned long timeout = jiffies + ATA_TMOUT_BOOT;
 	u32 irq_enable, irq_stat;
+	const char *reason;
 
 	DPRINTK("ENTER\n");
 
@@ -474,8 +475,11 @@ static int sil24_softreset(struct ata_po
 	writel(irq_enable, port + PORT_IRQ_ENABLE_SET);
 
 	if (!(irq_stat & PORT_IRQ_COMPLETE)) {
-		printk(KERN_ERR "ata%u: softreset failed (timeout)\n", ap->id);
-		return -EIO;
+		if (irq_stat & PORT_IRQ_ERROR)
+			reason = "SRST command error";
+		else
+			reason = "timeout";
+		goto err;
 	}
 
 	sil24_update_tf(ap);
@@ -487,6 +491,10 @@ static int sil24_softreset(struct ata_po
  out:
 	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
+
+ err:
+	printk(KERN_ERR "ata%u: softreset failed (%s)\n", ap->id, reason);
+	return -EIO;
 }
 
 static int sil24_hardreset(struct ata_port *ap, unsigned int *class)
-- 
1.2.4


