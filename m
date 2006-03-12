From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/4] libata: make per-dev transfer mode limits per-dev
Date: Sun, 12 Mar 2006 16:02:36 +0900
Message-ID: <11421469561848-git-send-email-htejun@gmail.com>
References: <11421469551948-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:27977 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751480AbWCLHCl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Mar 2006 02:02:41 -0500
Received: by pproxy.gmail.com with SMTP id d42so679707pyd
        for <linux-ide@vger.kernel.org>; Sat, 11 Mar 2006 23:02:40 -0800 (PST)
In-Reply-To: <11421469551948-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Now that each ata_device has xfer masks, per-dev limits can be made
per-dev instead of per-port.  Make per-dev limits per-dev.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    2 +-
 drivers/scsi/sata_sil.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

c54ae650a5eeee6dc67e32b52be23d29f8e4d16f
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index beedc4b..8db5458 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1350,7 +1350,7 @@ static int ata_dev_configure(struct ata_
 		if (print_info)
 			printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
 			       ap->id, dev->devno);
-		ap->udma_mask &= ATA_UDMA5;
+		dev->udma_mask &= ATA_UDMA5;
 		dev->max_sectors = ATA_MAX_SECTORS;
 	}
 
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 4f2a67e..3746f97 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -372,7 +372,7 @@ static void sil_dev_config(struct ata_po
 	if (quirks & SIL_QUIRK_UDMA5MAX) {
 		printk(KERN_INFO "ata%u(%u): applying Maxtor errata fix %s\n",
 		       ap->id, dev->devno, model_num);
-		ap->udma_mask &= ATA_UDMA5;
+		dev->udma_mask &= ATA_UDMA5;
 		return;
 	}
 }
-- 
1.2.4


