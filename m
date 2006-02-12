From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] libata: make ata_dev_knobble() per-device
Date: Sun, 12 Feb 2006 23:32:58 +0900
Message-ID: <11397547784183-git-send-email-htejun@gmail.com>
References: <11397547782407-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:27794 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751120AbWBLOdC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 09:33:02 -0500
Received: by pproxy.gmail.com with SMTP id t32so557502pyc
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2006 06:33:01 -0800 (PST)
In-Reply-To: <11397547782407-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_dev_knobble() unconditionally used the first device of the port to
determine whether a device is bridged or not.  This causes bridge
limit to be incorrectly applied or unapplied for hosts with slave
devices (e.g. ata_piix).

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

f6a90d153c45a62fb4fdd3a3c575e8163182d675
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 7a88e91..01d0ca8 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1121,9 +1121,10 @@ err_out:
 }
 
 
-static inline u8 ata_dev_knobble(const struct ata_port *ap)
+static inline u8 ata_dev_knobble(const struct ata_port *ap,
+				 struct ata_device *dev)
 {
-	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(ap->device->id)));
+	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
 }
 
 /**
@@ -1137,9 +1138,9 @@ static inline u8 ata_dev_knobble(const s
 void ata_dev_config(struct ata_port *ap, unsigned int i)
 {
 	/* limit bridge transfers to udma5, 200 sectors */
-	if (ata_dev_knobble(ap)) {
+	if (ata_dev_knobble(ap, &ap->device[i])) {
 		printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
-			ap->id, ap->device->devno);
+		       ap->id, i);
 		ap->udma_mask &= ATA_UDMA5;
 		ap->host->max_sectors = ATA_MAX_SECTORS;
 		ap->host->hostt->max_sectors = ATA_MAX_SECTORS;
-- 
1.1.5


