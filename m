From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/5] sata_sil24: fix timeout calculation in sil24_softreset
Date: Tue, 11 Apr 2006 22:22:29 +0900
Message-ID: <11447617492943-git-send-email-htejun@gmail.com>
References: <11447617493149-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.239]:22142 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750824AbWDKNWc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:22:32 -0400
Received: by wproxy.gmail.com with SMTP id i11so921431wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:22:32 -0700 (PDT)
In-Reply-To: <11447617493149-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

sil24_softreset calculated timeout by adding ATA_TMOUT_BOOT * HZ to
jiffies; however, as ATA_TMOUT_BOOT is already in jiffies, multiplying
by HZ makes the value way off.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

ff4713c0aaf1f8c397ab5f0365fead598e83fb3f
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 60dd6f1..512ee6f 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -433,7 +433,7 @@ static int sil24_softreset(struct ata_po
 	struct sil24_port_priv *pp = ap->private_data;
 	struct sil24_prb *prb = &pp->cmd_block[0].ata.prb;
 	dma_addr_t paddr = pp->cmd_block_dma;
-	unsigned long timeout = jiffies + ATA_TMOUT_BOOT * HZ;
+	unsigned long timeout = jiffies + ATA_TMOUT_BOOT;
 	u32 irq_enable, irq_stat;
 
 	DPRINTK("ENTER\n");
-- 
1.2.4


