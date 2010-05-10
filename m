From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 18/23] libata-sff: separate out BMDMA qc_issue
Date: Mon, 10 May 2010 21:41:42 +0200
Message-ID: <1273520507-32459-19-git-send-email-tj@kernel.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44896 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755700Ab0EJTl7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2010 15:41:59 -0400
In-Reply-To: <1273520507-32459-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, sshtylyov@mvista.com
Cc: Tejun Heo <tj@kernel.org>

Separate out ata_bmdma_qc_issue() from ata_sff_qc_issue() such that
ata_sff_qc_issue() only deals with non-BMDMA SFF protocols (PIO and
nodata) while ata_bmdma_qc_issue() deals with the BMDMA protocols and
uses ata_sff_qc_issue() for non-DMA commands.  All the users are
updated accordingly.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-sff.c   |  112 ++++++++++++++++++++++++++------------------
 drivers/ata/pata_acpi.c    |    4 +-
 drivers/ata/pata_cs5530.c  |    2 +-
 drivers/ata/pata_hpt3x2n.c |    2 +-
 drivers/ata/pata_it821x.c  |    4 +-
 drivers/ata/pata_oldpiix.c |    2 +-
 drivers/ata/pata_radisys.c |    2 +-
 drivers/ata/pata_sc1200.c  |    2 +-
 drivers/ata/sata_mv.c      |    2 +-
 drivers/ata/sata_nv.c      |    4 +-
 include/linux/libata.h     |    1 +
 11 files changed, 80 insertions(+), 57 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index f0e4a5e..e350eb1 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1357,15 +1357,11 @@ fsm_start:
 }
 
 /**
- *	ata_sff_qc_issue - issue taskfile to device in proto-dependent manner
+ *	ata_sff_qc_issue - issue taskfile to a SFF controller
  *	@qc: command to issue to device
  *
- *	Using various libata functions and hooks, this function
- *	starts an ATA command.  ATA commands are grouped into
- *	classes called "protocols", and issuing each type of protocol
- *	is slightly different.
- *
- *	May be used as the qc_issue() entry in ata_port_operations.
+ *	This function issues a PIO or NODATA command to a SFF
+ *	controller.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
@@ -1380,23 +1376,8 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 	/* Use polling pio if the LLD doesn't handle
 	 * interrupt driven pio and atapi CDB interrupt.
 	 */
-	if (ap->flags & ATA_FLAG_PIO_POLLING) {
-		switch (qc->tf.protocol) {
-		case ATA_PROT_PIO:
-		case ATA_PROT_NODATA:
-		case ATAPI_PROT_PIO:
-		case ATAPI_PROT_NODATA:
-			qc->tf.flags |= ATA_TFLAG_POLLING;
-			break;
-		case ATAPI_PROT_DMA:
-			if (qc->dev->flags & ATA_DFLAG_CDB_INTR)
-				/* see ata_dma_blacklisted() */
-				BUG();
-			break;
-		default:
-			break;
-		}
-	}
+	if (ap->flags & ATA_FLAG_PIO_POLLING)
+		qc->tf.flags |= ATA_TFLAG_POLLING;
 
 	/* select the device */
 	ata_dev_select(ap, qc->dev->devno, 1, 0);
@@ -1415,15 +1396,6 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 
 		break;
 
-	case ATA_PROT_DMA:
-		WARN_ON_ONCE(qc->tf.flags & ATA_TFLAG_POLLING);
-
-		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
-		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
-		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
-		ap->hsm_task_state = HSM_ST_LAST;
-		break;
-
 	case ATA_PROT_PIO:
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
 			ata_qc_set_polling(qc);
@@ -1468,18 +1440,6 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 			ata_sff_queue_pio_task(ap, 0);
 		break;
 
-	case ATAPI_PROT_DMA:
-		WARN_ON_ONCE(qc->tf.flags & ATA_TFLAG_POLLING);
-
-		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
-		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
-		ap->hsm_task_state = HSM_ST_FIRST;
-
-		/* send cdb by polling if no cdb interrupt */
-		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
-			ata_sff_queue_pio_task(ap, 0);
-		break;
-
 	default:
 		WARN_ON_ONCE(1);
 		return AC_ERR_SYSTEM;
@@ -2598,6 +2558,7 @@ const struct ata_port_operations ata_bmdma_port_ops = {
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.qc_prep		= ata_bmdma_qc_prep,
+	.qc_issue		= ata_bmdma_qc_issue,
 
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
@@ -2762,6 +2723,67 @@ void ata_bmdma_dumb_qc_prep(struct ata_queued_cmd *qc)
 EXPORT_SYMBOL_GPL(ata_bmdma_dumb_qc_prep);
 
 /**
+ *	ata_bmdma_qc_issue - issue taskfile to a BMDMA controller
+ *	@qc: command to issue to device
+ *
+ *	This function issues a PIO, NODATA or DMA command to a
+ *	SFF/BMDMA controller.  PIO and NODATA are handled by
+ *	ata_sff_qc_issue().
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	Zero on success, AC_ERR_* mask on failure
+ */
+unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+
+	/* see ata_dma_blacklisted() */
+	BUG_ON((ap->flags & ATA_FLAG_PIO_POLLING) &&
+	       qc->tf.protocol == ATAPI_PROT_DMA);
+
+	/* defer PIO handling to sff_qc_issue */
+	if (!ata_is_dma(qc->tf.protocol))
+		return ata_sff_qc_issue(qc);
+
+	/* select the device */
+	ata_dev_select(ap, qc->dev->devno, 1, 0);
+
+	/* start the command */
+	switch (qc->tf.protocol) {
+	case ATA_PROT_DMA:
+		WARN_ON_ONCE(qc->tf.flags & ATA_TFLAG_POLLING);
+
+		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
+		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
+		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
+		ap->hsm_task_state = HSM_ST_LAST;
+		break;
+
+	case ATAPI_PROT_DMA:
+		WARN_ON_ONCE(qc->tf.flags & ATA_TFLAG_POLLING);
+
+		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
+		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
+		ap->hsm_task_state = HSM_ST_FIRST;
+
+		/* send cdb by polling if no cdb interrupt */
+		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
+			ata_sff_queue_pio_task(ap, 0);
+		break;
+
+	default:
+		WARN_ON(1);
+		return AC_ERR_SYSTEM;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ata_bmdma_qc_issue);
+
+/**
  *	ata_bmdma_error_handler - Stock error handler for BMDMA controller
  *	@ap: port to handle error for
  *
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index 1a5a309..066b9f3 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -172,7 +172,7 @@ static unsigned int pacpi_qc_issue(struct ata_queued_cmd *qc)
 	struct pata_acpi *acpi = ap->private_data;
 
 	if (acpi->gtm.flags & 0x10)
-		return ata_sff_qc_issue(qc);
+		return ata_bmdma_qc_issue(qc);
 
 	if (adev != acpi->last) {
 		pacpi_set_piomode(ap, adev);
@@ -180,7 +180,7 @@ static unsigned int pacpi_qc_issue(struct ata_queued_cmd *qc)
 			pacpi_set_dmamode(ap, adev);
 		acpi->last = adev;
 	}
-	return ata_sff_qc_issue(qc);
+	return ata_bmdma_qc_issue(qc);
 }
 
 /**
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index 4b9a66f..e809a42 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -156,7 +156,7 @@ static unsigned int cs5530_qc_issue(struct ata_queued_cmd *qc)
 		    	cs5530_set_dmamode(ap, adev);
 	}
 
-	return ata_sff_qc_issue(qc);
+	return ata_bmdma_qc_issue(qc);
 }
 
 static struct scsi_host_template cs5530_sht = {
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 01457b2..8b95aeb 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -320,7 +320,7 @@ static unsigned int hpt3x2n_qc_issue(struct ata_queued_cmd *qc)
 
 		hpt3x2n_set_clock(ap, dpll ? 0x21 : 0x23);
 	}
-	return ata_sff_qc_issue(qc);
+	return ata_bmdma_qc_issue(qc);
 }
 
 static struct scsi_host_template hpt3x2n_sht = {
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 8d73438..2bd2b00 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -430,7 +430,7 @@ static unsigned int it821x_smart_qc_issue(struct ata_queued_cmd *qc)
 		case 0xFC:	/* Internal 'report rebuild state' */
 		/* Arguably should just no-op this one */
 		case ATA_CMD_SET_FEATURES:
-			return ata_sff_qc_issue(qc);
+			return ata_bmdma_qc_issue(qc);
 	}
 	printk(KERN_DEBUG "it821x: can't process command 0x%02X\n", qc->tf.command);
 	return AC_ERR_DEV;
@@ -448,7 +448,7 @@ static unsigned int it821x_smart_qc_issue(struct ata_queued_cmd *qc)
 static unsigned int it821x_passthru_qc_issue(struct ata_queued_cmd *qc)
 {
 	it821x_passthru_dev_select(qc->ap, qc->dev->devno);
-	return ata_sff_qc_issue(qc);
+	return ata_bmdma_qc_issue(qc);
 }
 
 /**
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index 5f6aba7..988ef26 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -200,7 +200,7 @@ static unsigned int oldpiix_qc_issue(struct ata_queued_cmd *qc)
 		if (ata_dma_enabled(adev))
 			oldpiix_set_dmamode(ap, adev);
 	}
-	return ata_sff_qc_issue(qc);
+	return ata_bmdma_qc_issue(qc);
 }
 
 
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index fc96022..a5fa388 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -179,7 +179,7 @@ static unsigned int radisys_qc_issue(struct ata_queued_cmd *qc)
 				radisys_set_piomode(ap, adev);
 		}
 	}
-	return ata_sff_qc_issue(qc);
+	return ata_bmdma_qc_issue(qc);
 }
 
 
diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 599e648..6b5b63a 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -174,7 +174,7 @@ static unsigned int sc1200_qc_issue(struct ata_queued_cmd *qc)
 		    	sc1200_set_dmamode(ap, adev);
 	}
 
-	return ata_sff_qc_issue(qc);
+	return ata_bmdma_qc_issue(qc);
 }
 
 /**
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index d0c8449..16bacd3 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2356,7 +2356,7 @@ static unsigned int mv_qc_issue(struct ata_queued_cmd *qc)
 		if (IS_GEN_II(hpriv))
 			return mv_qc_issue_fis(qc);
 	}
-	return ata_sff_qc_issue(qc);
+	return ata_bmdma_qc_issue(qc);
 }
 
 static struct ata_queued_cmd *mv_get_active_qc(struct ata_port *ap)
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 23dbde8..ef1fdfb 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1468,7 +1468,7 @@ static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc)
 		BUG_ON(!(pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE) &&
 			(qc->flags & ATA_QCFLAG_DMAMAP));
 		nv_adma_register_mode(qc->ap);
-		return ata_sff_qc_issue(qc);
+		return ata_bmdma_qc_issue(qc);
 	} else
 		nv_adma_mode(qc->ap);
 
@@ -2088,7 +2088,7 @@ static unsigned int nv_swncq_qc_issue(struct ata_queued_cmd *qc)
 	struct nv_swncq_port_priv *pp = ap->private_data;
 
 	if (qc->tf.protocol != ATA_PROT_NCQ)
-		return ata_sff_qc_issue(qc);
+		return ata_bmdma_qc_issue(qc);
 
 	DPRINTK("Enter\n");
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b220451..739e416 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1625,6 +1625,7 @@ extern int ata_pci_sff_init_one(struct pci_dev *pdev,
 #endif /* CONFIG_PCI */
 
 extern void ata_bmdma_qc_prep(struct ata_queued_cmd *qc);
+extern unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc);
 extern void ata_bmdma_dumb_qc_prep(struct ata_queued_cmd *qc);
 extern void ata_bmdma_error_handler(struct ata_port *ap);
 extern void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc);
-- 
1.6.4.2

