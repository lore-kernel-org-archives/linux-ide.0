From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/13] sata_sil24: convert to new probing mechanism and add hotplug support
Date: Fri, 12 May 2006 00:32:08 +0900
Message-ID: <11473615282452-git-send-email-htejun@gmail.com>
References: <11473615261297-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:45411 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030294AbWEKP5q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:57:46 -0400
Received: by wr-out-0506.google.com with SMTP id i22so177260wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:57:45 -0700 (PDT)
In-Reply-To: <11473615261297-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert to new probing mechanism and add hotplug support by enabling
PORT_IRQ_PHYRDY_CHG and scheduling probe when either of
PORT_IRQ_PHYRDY_CHG or PORT_IRQ_DEV_XCHG happens.  Probing is
requested explicitly as sil24's SError doesn't always reflect DEV_XCHG
and PHYRDY_CHG conditions properly.

---

 drivers/scsi/sata_sil24.c |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

f9c5769cf121692502bd0aa4c7a609d0ea604f07
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 8a1b826..8bbcf69 100644
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
@@ -322,7 +323,6 @@ struct sil24_host_priv {
 static void sil24_dev_config(struct ata_port *ap, struct ata_device *dev);
 static u32 sil24_scr_read(struct ata_port *ap, unsigned sc_reg);
 static void sil24_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val);
-static int sil24_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
 static void sil24_irq_clear(struct ata_port *ap);
@@ -380,8 +380,6 @@ static const struct ata_port_operations 
 	.check_altstatus	= ata_noop_check_status,
 	.dev_select		= ata_noop_dev_select,
 
-	.probe_reset		= sil24_probe_reset,
-
 	.qc_prep		= sil24_qc_prep,
 	.qc_issue		= sil24_qc_issue,
 
@@ -620,13 +618,6 @@ static int sil24_hardreset(struct ata_po
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
@@ -757,13 +748,18 @@ static void sil24_error_intr(struct ata_
 
 	ata_ehi_push_desc(ehi, "irq_stat 0x%08x", irq_stat);
 
-	if (irq_stat & PORT_IRQ_DEV_XCHG) {
+	if (irq_stat & (PORT_IRQ_PHYRDY_CHG | PORT_IRQ_DEV_XCHG)) {
 		ehi->err_mask |= AC_ERR_ATA_BUS;
 		/* sil24 doesn't recover very well from phy
 		 * disconnection with a softreset.  Force hardreset.
 		 */
 		ehi->action |= ATA_EH_HARDRESET;
-		ata_ehi_push_desc(ehi, ", device_exchanged");
+		ata_ehi_push_desc(ehi, ", %s",
+			       irq_stat & PORT_IRQ_PHYRDY_CHG ?
+			       "PHY RDY changed" : "device exchanged");
+
+		/* sil24 SError isn't reliable, request probing explicitly */
+		ehi->probe_mask = 1;
 		freeze = 1;
 	}
 
-- 
1.2.4


