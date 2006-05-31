From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/13] sata_sil24: convert to new probing mechanism and add hotplug support
Date: Wed, 31 May 2006 20:25:46 +0900
Message-ID: <11490747461164-git-send-email-htejun@gmail.com>
References: <11490747443727-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.205]:47256 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965001AbWEaLZ7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 07:25:59 -0400
Received: by nz-out-0102.google.com with SMTP id s18so8510nze
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2006 04:25:59 -0700 (PDT)
In-Reply-To: <11490747443727-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert to new probing mechanism and add hotplug support by enabling
PORT_IRQ_PHYRDY_CHG, marking ehi for hotplug and scheduling EH on
PORT_IRQ_PHYRDY_CHG or PORT_IRQ_DEV_XCHG.

Sil3124/32 family of controllers don't have any mechanism to wait for
the first D2H FIS after hotplug, so ATA_FLAG_SKIP_D2H_BSY is used.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   27 ++++++++-------------------
 1 files changed, 8 insertions(+), 19 deletions(-)

0542925b25676543e8384edf454668f89227e905
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index d4ca6d6..97e9339 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -159,7 +159,8 @@ enum {
 	PORT_IRQ_SDB_NOTIFY	= (1 << 11), /* SDB notify received */
 
 	DEF_PORT_IRQ		= PORT_IRQ_COMPLETE | PORT_IRQ_ERROR |
-				  PORT_IRQ_DEV_XCHG | PORT_IRQ_UNK_FIS,
+				  PORT_IRQ_PHYRDY_CHG | PORT_IRQ_DEV_XCHG |
+				  PORT_IRQ_UNK_FIS,
 
 	/* bits[27:16] are unmasked (raw) */
 	PORT_IRQ_RAW_SHIFT	= 16,
@@ -228,7 +229,7 @@ enum {
 	/* host flags */
 	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_NCQ,
+				  ATA_FLAG_NCQ | ATA_FLAG_SKIP_D2H_BSY,
 	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
 
 	IRQ_STAT_4PORTS		= 0xf,
@@ -325,7 +326,6 @@ static u8 sil24_check_status(struct ata_
 static u32 sil24_scr_read(struct ata_port *ap, unsigned sc_reg);
 static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val);
 static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
-static int sil24_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
 static void sil24_irq_clear(struct ata_port *ap);
@@ -385,8 +385,6 @@ static const struct ata_port_operations 
 
 	.tf_read		= sil24_tf_read,
 
-	.probe_reset		= sil24_probe_reset,
-
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
 
@@ -635,13 +633,6 @@ static int sil24_hardreset(struct ata_po
 	return -EIO;
 }
 
-static int sil24_probe_reset(struct ata_port *ap, unsigned int *classes)
-{
-	return ata_drive_probe_reset(ap, ata_std_probeinit,
-				     sil24_softreset, sil24_hardreset,
-				     ata_std_postreset, classes);
-}
-
 static inline void sil24_fill_sg(struct ata_queued_cmd *qc,
 				 struct sil24_sge *sge)
 {
@@ -772,13 +763,11 @@ static void sil24_error_intr(struct ata_
 
 	ata_ehi_push_desc(ehi, "irq_stat 0x%08x", irq_stat);
 
-	if (irq_stat & PORT_IRQ_DEV_XCHG) {
-		ehi->err_mask |= AC_ERR_ATA_BUS;
-		/* sil24 doesn't recover very well from phy
-		 * disconnection with a softreset.  Force hardreset.
-		 */
-		ehi->action |= ATA_EH_HARDRESET;
-		ata_ehi_push_desc(ehi, ", device_exchanged");
+	if (irq_stat & (PORT_IRQ_PHYRDY_CHG | PORT_IRQ_DEV_XCHG)) {
+		ata_ehi_hotplugged(ehi);
+		ata_ehi_push_desc(ehi, ", %s",
+			       irq_stat & PORT_IRQ_PHYRDY_CHG ?
+			       "PHY RDY changed" : "device exchanged");
 		freeze = 1;
 	}
 
-- 
1.3.2


