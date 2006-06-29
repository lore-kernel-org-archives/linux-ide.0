From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 6/9] sata_mv.c conversion
Date: Thu, 29 Jun 2006 18:10:18 +0200
Message-ID: <20060629161018.GG23122@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp107.plus.mail.re2.yahoo.com ([206.190.53.32]:51119 "HELO
	smtp107.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750865AbWF2QLU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 12:11:20 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>

Convert the sata-mv.c to the new scheme.

Signed-off-by: <petkov@math.uni-muenster.de>

--- libata-dev/drivers/scsi/sata_mv.c.orig	2006-06-29 07:27:18.000000000 +0200
+++ libata-dev/drivers/scsi/sata_mv.c	2006-06-29 07:41:45.000000000 +0200
@@ -686,7 +686,7 @@ static void mv_stop_dma(struct ata_port 
 	}
 
 	if (EDMA_EN & reg) {
-		ata_port_printk(ap, KERN_ERR, "Unable to stop eDMA\n");
+		ata_port_printk(ap, ATA_MSG_ERR, "Unable to stop eDMA\n");
 		/* FIXME: Consider doing a reset here to recover */
 	}
 }
@@ -1317,8 +1317,9 @@ static void mv_err_intr(struct ata_port 
 		struct mv_port_priv *pp	= ap->private_data;
 		pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
 	}
-	DPRINTK(KERN_ERR "ata%u: port error; EDMA err cause: 0x%08x "
-		"SERR: 0x%08x\n", ap->id, edma_err_cause, serr);
+	ata_port_printk(ap, ATA_MSG_ERR, 
+			"ata%u: port error; EDMA err cause: 0x%08x "
+			"SERR: 0x%08x\n", ap->id, edma_err_cause, serr);
 
 	/* Clear EDMA now that SERR cleanup done */
 	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
@@ -1944,11 +1945,15 @@ static void __mv_phy_reset(struct ata_po
 	int retry = 5;
 	u32 sstatus;
 
-	VPRINTK("ENTER, port %u, mmio 0x%p\n", ap->port_no, port_mmio);
-
-	DPRINTK("S-regs after ATA_RST: SStat 0x%08x SErr 0x%08x "
-		"SCtrl 0x%08x\n", mv_scr_read(ap, SCR_STATUS),
-		mv_scr_read(ap, SCR_ERROR), mv_scr_read(ap, SCR_CONTROL));
+	ata_port_printk(ap, ATA_MSG_TRACE, 
+			"%s: ENTER, port %u, mmio 0x%p\n", 
+			__FUNCTION__, ap->port_no, port_mmio);
+
+	ata_port_printk(ap, ATA_MSG_CMD, 
+			"S-regs after ATA_RST: SStat 0x%08x SErr 0x%08x "
+			"SCtrl 0x%08x\n", mv_scr_read(ap, SCR_STATUS),
+			mv_scr_read(ap, SCR_ERROR), 
+			mv_scr_read(ap, SCR_CONTROL));
 
 	/* Issue COMRESET via SControl */
 comreset_retry:
@@ -1974,15 +1979,17 @@ comreset_retry:
 	    (retry-- > 0))
 		goto comreset_retry;
 
-	DPRINTK("S-regs after PHY wake: SStat 0x%08x SErr 0x%08x "
-		"SCtrl 0x%08x\n", mv_scr_read(ap, SCR_STATUS),
-		mv_scr_read(ap, SCR_ERROR), mv_scr_read(ap, SCR_CONTROL));
+	ata_port_printk(ap, ATA_MSG_CMD, 
+			"S-regs after PHY wake: SStat 0x%08x SErr 0x%08x "
+			"SCtrl 0x%08x\n", mv_scr_read(ap, SCR_STATUS),
+			mv_scr_read(ap, SCR_ERROR), 
+			mv_scr_read(ap, SCR_CONTROL));
 
 	if (ata_port_online(ap)) {
 		ata_port_probe(ap);
 	} else {
 		sata_scr_read(ap, SCR_STATUS, &sstatus);
-		ata_port_printk(ap, KERN_INFO,
+		ata_port_printk(ap, ATA_MSG_INFO,
 				"no device found (phy stat %08x)\n", sstatus);
 		ata_port_disable(ap);
 		return;
@@ -2011,7 +2018,8 @@ comreset_retry:
 
 	dev->class = ata_dev_classify(&tf);
 	if (!ata_dev_enabled(dev)) {
-		VPRINTK("Port disabled post-sig: No device present.\n");
+		ata_port_printk(ap, ATA_MSG_INFO, 
+				"Port disabled post-sig: No device present.\n");
 		ata_port_disable(ap);
 	}
 
@@ -2019,7 +2027,7 @@ comreset_retry:
 
 	pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
 
-	VPRINTK("EXIT\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, "%s: EXIT\n", __FUNCTION__);
 }
 
 static void mv_phy_reset(struct ata_port *ap)
@@ -2042,15 +2050,18 @@ static void mv_eng_timeout(struct ata_po
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 
-	ata_port_printk(ap, KERN_ERR, "Entering mv_eng_timeout\n");
-	DPRINTK("All regs @ start of eng_timeout\n");
+	ata_port_printk(ap, ATA_MSG_TRACE, 
+			"%s: ENTER: All regs @ start of eng_timeout\n",
+			__FUNCTION__);
 	mv_dump_all_regs(ap->host_set->mmio_base, ap->port_no,
 			 to_pci_dev(ap->host_set->dev));
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
-        printk(KERN_ERR "mmio_base %p ap %p qc %p scsi_cmnd %p &cmnd %p\n",
-	       ap->host_set->mmio_base, ap, qc, qc->scsicmd,
-	       &qc->scsicmd->cmnd);
+        ata_port_printk(ap, ATA_MSG_TRACE, 
+			"%s: mmio_base %p ap %p qc %p scsi_cmnd %p &cmnd %p\n",
+			__FUNCTION__, 
+			ap->host_set->mmio_base, ap, qc, qc->scsicmd,
+			&qc->scsicmd->cmnd);
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	mv_err_intr(ap, 0);

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de

