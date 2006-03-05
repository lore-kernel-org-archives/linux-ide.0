From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/6] libata: use ata_id_xfermask() in ata_dev_configure()
Date: Mon, 6 Mar 2006 04:31:56 +0900
Message-ID: <11415871161037-git-send-email-htejun@gmail.com>
References: <11415871161709-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.178]:14947 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751762AbWCETcB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 14:32:01 -0500
Received: by pproxy.gmail.com with SMTP id i75so637257pye
        for <linux-ide@vger.kernel.org>; Sun, 05 Mar 2006 11:32:00 -0800 (PST)
In-Reply-To: <11415871161709-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Replace quick & dirty max transfer mode determination in
ata_dev_configure() with ata_id_xfermask().  While at it, rename
xfer_modes variable to xfer_mask and make it unsigned int for
consistency.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

58efdc973c86dc4fc8c7e4b43874a462a777257c
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 9946618..84a8550 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1224,7 +1224,7 @@ static inline u8 ata_dev_knobble(const s
 static int ata_dev_configure(struct ata_port *ap, struct ata_device *dev,
 			     int print_info)
 {
-	unsigned long xfer_modes;
+	unsigned int xfer_mask;
 	int i, rc;
 
 	if (!ata_dev_present(dev)) {
@@ -1255,12 +1255,8 @@ static int ata_dev_configure(struct ata_
 		goto err_out_nosup;
 	}
 
-	/* quick-n-dirty find max transfer mode; for printk only */
-	xfer_modes = dev->id[ATA_ID_UDMA_MODES];
-	if (!xfer_modes)
-		xfer_modes = (dev->id[ATA_ID_MWDMA_MODES]) << ATA_SHIFT_MWDMA;
-	if (!xfer_modes)
-		xfer_modes = ata_pio_modes(dev);
+	/* find max transfer mode; for printk only */
+	xfer_mask = ata_id_xfermask(dev->id);
 
 	ata_dump_id(dev->id);
 
@@ -1284,7 +1280,7 @@ static int ata_dev_configure(struct ata_
 				       "max %s, %Lu sectors: %s\n",
 				       ap->id, dev->devno,
 				       ata_id_major_version(dev->id),
-				       ata_mode_string(xfer_modes),
+				       ata_mode_string(xfer_mask),
 				       (unsigned long long)dev->n_sectors,
 				       lba_desc);
 		} else {
@@ -1308,7 +1304,7 @@ static int ata_dev_configure(struct ata_
 				       "max %s, %Lu sectors: CHS %u/%u/%u\n",
 				       ap->id, dev->devno,
 				       ata_id_major_version(dev->id),
-				       ata_mode_string(xfer_modes),
+				       ata_mode_string(xfer_mask),
 				       (unsigned long long)dev->n_sectors,
 				       dev->cylinders, dev->heads, dev->sectors);
 		}
@@ -1329,7 +1325,7 @@ static int ata_dev_configure(struct ata_
 		/* print device info to dmesg */
 		if (print_info)
 			printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",
-			       ap->id, dev->devno, ata_mode_string(xfer_modes));
+			       ap->id, dev->devno, ata_mode_string(xfer_mask));
 	}
 
 	ap->host->max_cmd_len = 0;
-- 
1.2.4


