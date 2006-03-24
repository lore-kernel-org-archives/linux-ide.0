From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] libata: make per-dev transfer mode limits per-dev
Date: Fri, 24 Mar 2006 14:07:50 +0900
Message-ID: <1143176870419-git-send-email-htejun@gmail.com>
References: <11431768691564-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.194]:22986 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932474AbWCXFHz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 00:07:55 -0500
Received: by xproxy.gmail.com with SMTP id t10so445378wxc
        for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 21:07:54 -0800 (PST)
In-Reply-To: <11431768691564-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Now that each ata_device has xfer masks, per-dev limits can be made
per-dev instead of per-port.  Make per-dev limits per-dev.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    2 +-
 drivers/scsi/sata_sil.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

d1e4136f124dfae288a5dd382e9d54866a355a44
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index a87748b..1063928 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1327,7 +1327,7 @@ static int ata_dev_configure(struct ata_
 		if (print_info)
 			printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
 			       ap->id, dev->devno);
-		ap->udma_mask &= ATA_UDMA5;
+		dev->udma_mask &= ATA_UDMA5;
 		dev->max_sectors = ATA_MAX_SECTORS;
 	}
 
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 3e75d67..18c296c 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -371,7 +371,7 @@ static void sil_dev_config(struct ata_po
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


