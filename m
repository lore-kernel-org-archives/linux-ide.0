From: Mark Lord <liml@rtr.ca>
Subject: REPOST: [PATCH 7/8] sata_mv leave SError bits untouched in mv_err_intr
Date: Sat, 19 Apr 2008 15:07:49 -0400
Message-ID: <480A4305.80506@rtr.ca>
References: <480A3D2E.4040503@rtr.ca> <480A3FC3.9070006@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2532 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755808AbYDSTHp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Apr 2008 15:07:45 -0400
In-Reply-To: <480A3FC3.9070006@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Here it is again, minus the checkpatch.pl complaint: 

Rework mv_err_intr() to leave the SError bits as-is,
so that libata-eh has a chance to see/use them.

We originally thought that clearing them here was necessary
before writing back to edma_err_cause (per the Marvell datasheets),
but we will end up reseting the chip regardless in those cases.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2008-04-19 13:47:23.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-04-19 13:53:33.000000000 -0400
@@ -1519,13 +1519,11 @@
 /**
  *      mv_err_intr - Handle error interrupts on the port
  *      @ap: ATA channel to manipulate
- *      @reset_allowed: bool: 0 == don't trigger from reset here
+ *      @qc: affected command (non-NCQ), or NULL
  *
- *      In most cases, just clear the interrupt and move on.  However,
- *      some cases require an eDMA reset, which also performs a COMRESET.
- *      The SERR case requires a clear of pending errors in the SATA
- *      SERROR register.  Finally, if the port disabled DMA,
- *      update our cached copy to match.
+ *      Most cases require a full reset of the chip's state machine,
+ *      which also performs a COMRESET.
+ *      Also, if the port disabled DMA, update our cached copy to match.
  *
  *      LOCKING:
  *      Inherited from caller.
@@ -1536,21 +1534,18 @@
 	u32 edma_err_cause, eh_freeze_mask, serr = 0;
 	struct mv_port_priv *pp = ap->private_data;
 	struct mv_host_priv *hpriv = ap->host->private_data;
-	unsigned int edma_enabled = (pp->pp_flags & MV_PP_FLAG_EDMA_EN);
 	unsigned int action = 0, err_mask = 0;
 	struct ata_eh_info *ehi = &ap->link.eh_info;
 
 	ata_ehi_clear_desc(ehi);
 
-	if (!edma_enabled) {
-		/* just a guess: do we need to do this? should we
-		 * expand this, and do it in all cases?
-		 */
-		sata_scr_read(&ap->link, SCR_ERROR, &serr);
-		sata_scr_write_flush(&ap->link, SCR_ERROR, serr);
-	}
-
+	/*
+	 * Read and clear the err_cause bits.  This won't actually
+	 * clear for some errors (eg. SError), but we will be doing
+	 * a hard reset in those cases regardless, which *will* clear it.
+	 */
 	edma_err_cause = readl(port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
+	writelfl(~edma_err_cause, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 
 	ata_ehi_push_desc(ehi, "edma_err_cause=%08x", edma_err_cause);
 
@@ -1590,16 +1585,19 @@
 			ata_ehi_push_desc(ehi, "EDMA self-disable");
 		}
 		if (edma_err_cause & EDMA_ERR_SERR) {
-			sata_scr_read(&ap->link, SCR_ERROR, &serr);
-			sata_scr_write_flush(&ap->link, SCR_ERROR, serr);
-			err_mask = AC_ERR_ATA_BUS;
+			/*
+			 * Ensure that we read our own SCR, not a pmp link SCR:
+			 */
+			ap->ops->scr_read(ap, SCR_ERROR, &serr);
+			/*
+			 * Don't clear SError here; leave it for libata-eh:
+			 */
+			ata_ehi_push_desc(ehi, "SError=%08x", serr);
+			err_mask |= AC_ERR_ATA_BUS;
 			action |= ATA_EH_RESET;
 		}
 	}
 
-	/* Clear EDMA now that SERR cleanup done */
-	writelfl(~edma_err_cause, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
-
 	if (!err_mask) {
 		err_mask = AC_ERR_OTHER;
 		action |= ATA_EH_RESET;
