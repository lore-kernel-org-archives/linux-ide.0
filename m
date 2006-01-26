From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/5] libata: make ata_dev_knobble() per-device
Date: Fri, 27 Jan 2006 00:24:03 +0900
Message-ID: <11382890432663-git-send-email-htejun@gmail.com>
References: <11382890422935-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:5002 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932359AbWAZPYJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 10:24:09 -0500
Received: by zproxy.gmail.com with SMTP id 34so368590nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 07:24:08 -0800 (PST)
In-Reply-To: <11382890422935-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <htejun@gmail.com>

ata_dev_knobble() unconditionally used the first device of the port to
determine whether a device is bridged or not.  This causes bridge
limit to be incorrectly applied or unapplied for hosts with slave
devices (e.g. ata_piix).

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

315dd661a46e94e44c6f9481465bac93f8ea84ef
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f6511bd..c92f96f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1483,9 +1483,10 @@ err_out:
 }
 
 
-static inline u8 ata_dev_knobble(const struct ata_port *ap)
+static inline u8 ata_dev_knobble(const struct ata_port *ap,
+				 struct ata_device *dev)
 {
-	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(ap->device->id)));
+	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
 }
 
 /**
@@ -1500,9 +1501,9 @@ static inline u8 ata_dev_knobble(const s
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
1.1.3


