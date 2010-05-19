From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/6] libata-sff: separate out BMDMA irq handler
Date: Wed, 19 May 2010 22:10:21 +0200
Message-ID: <1274299824-15691-4-git-send-email-tj@kernel.org>
References: <1274299824-15691-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43333 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522Ab0ESUK4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2010 16:10:56 -0400
In-Reply-To: <1274299824-15691-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Separate out BMDMA irq handler from SFF irq handler.  The misnamed
host_intr() functions are renamed to ata_sff_port_intr() and
ata_bmdma_port_intr().  Common parts are factored into
__ata_sff_port_intr() and __ata_sff_interrupt() and used by sff and
bmdma interrupt routines.

All BMDMA drivers now use ata_bmdma_interrupt() or
ata_bmdma_port_intr() while all non-BMDMA SFF ones use
ata_sff_interrupt() or ata_sff_port_intr().

For now, ata_pci_sff_init_one() uses ata_bmdma_interrupt() as it's
used by both SFF and BMDMA drivers.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/ata_piix.c      |    2 +-
 drivers/ata/libata-sff.c    |  208 +++++++++++++++++++++++++++----------------
 drivers/ata/pata_atp867x.c  |    2 +-
 drivers/ata/pata_cs5520.c   |    2 +-
 drivers/ata/pata_hpt3x3.c   |    2 +-
 drivers/ata/pata_icside.c   |    2 +-
 drivers/ata/pata_macio.c    |    2 +-
 drivers/ata/pata_mpc52xx.c  |    2 +-
 drivers/ata/pata_ninja32.c  |    2 +-
 drivers/ata/pata_pdc2027x.c |    2 +-
 drivers/ata/pata_rdc.c      |    2 +-
 drivers/ata/pata_scc.c      |    2 +-
 drivers/ata/pata_sil680.c   |    2 +-
 drivers/ata/sata_mv.c       |    2 +-
 drivers/ata/sata_nv.c       |    4 +-
 drivers/ata/sata_qstor.c    |    2 +-
 drivers/ata/sata_sis.c      |    2 +-
 drivers/ata/sata_svw.c      |    2 +-
 drivers/ata/sata_uli.c      |    2 +-
 drivers/ata/sata_via.c      |    2 +-
 drivers/ata/sata_vsc.c      |    2 +-
 include/linux/libata.h      |    5 +-
 22 files changed, 155 insertions(+), 100 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 83bc49f..9ee2427 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1626,7 +1626,7 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 	host->flags |= ATA_HOST_PARALLEL_SCAN;
 
 	pci_set_master(pdev);
-	return ata_pci_sff_activate_host(host, ata_sff_interrupt, &piix_sht);
+	return ata_pci_sff_activate_host(host, ata_bmdma_interrupt, &piix_sht);
 }
 
 static void piix_remove_one(struct pci_dev *pdev)
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 55bc488..bef7571 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1469,27 +1469,27 @@ bool ata_sff_qc_fill_rtf(struct ata_queued_cmd *qc)
 }
 EXPORT_SYMBOL_GPL(ata_sff_qc_fill_rtf);
 
-/**
- *	ata_sff_host_intr - Handle host interrupt for given (port, task)
- *	@ap: Port on which interrupt arrived (possibly...)
- *	@qc: Taskfile currently active in engine
- *
- *	Handle host interrupt for given queued command.  Currently,
- *	only DMA interrupts are handled.  All other commands are
- *	handled via polling with interrupts disabled (nIEN bit).
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- *
- *	RETURNS:
- *	One if interrupt was handled, zero if not (shared irq).
- */
-unsigned int ata_sff_host_intr(struct ata_port *ap,
-				      struct ata_queued_cmd *qc)
+static unsigned int ata_sff_idle_irq(struct ata_port *ap)
 {
-	struct ata_eh_info *ehi = &ap->link.eh_info;
-	u8 status, host_stat = 0;
-	bool bmdma_stopped = false;
+	ap->stats.idle_irq++;
+
+#ifdef ATA_IRQ_TRAP
+	if ((ap->stats.idle_irq % 1000) == 0) {
+		ap->ops->sff_check_status(ap);
+		if (ap->ops->sff_irq_clear)
+			ap->ops->sff_irq_clear(ap);
+		ata_port_printk(ap, KERN_WARNING, "irq trap\n");
+		return 1;
+	}
+#endif
+	return 0;	/* irq not handled */
+}
+
+static unsigned int __ata_sff_port_intr(struct ata_port *ap,
+					struct ata_queued_cmd *qc,
+					bool hsmv_on_idle)
+{
+	u8 status;
 
 	VPRINTK("ata%u: protocol %d task_state %d\n",
 		ap->print_id, qc->tf.protocol, ap->hsm_task_state);
@@ -1506,47 +1506,24 @@ unsigned int ata_sff_host_intr(struct ata_port *ap,
 		 * need to check ata_is_atapi(qc->tf.protocol) again.
 		 */
 		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
-			goto idle_irq;
-		break;
-	case HSM_ST_LAST:
-		if (qc->tf.protocol == ATA_PROT_DMA ||
-		    qc->tf.protocol == ATAPI_PROT_DMA) {
-			/* check status of DMA engine */
-			host_stat = ap->ops->bmdma_status(ap);
-			VPRINTK("ata%u: host_stat 0x%X\n",
-				ap->print_id, host_stat);
-
-			/* if it's not our irq... */
-			if (!(host_stat & ATA_DMA_INTR))
-				goto idle_irq;
-
-			/* before we do anything else, clear DMA-Start bit */
-			ap->ops->bmdma_stop(qc);
-			bmdma_stopped = true;
-
-			if (unlikely(host_stat & ATA_DMA_ERR)) {
-				/* error when transfering data to/from memory */
-				qc->err_mask |= AC_ERR_HOST_BUS;
-				ap->hsm_task_state = HSM_ST_ERR;
-			}
-		}
+			return ata_sff_idle_irq(ap);
 		break;
 	case HSM_ST:
+	case HSM_ST_LAST:
 		break;
 	default:
-		goto idle_irq;
+		return ata_sff_idle_irq(ap);
 	}
 
-
 	/* check main status, clearing INTRQ if needed */
 	status = ata_sff_irq_status(ap);
 	if (status & ATA_BUSY) {
-		if (bmdma_stopped) {
+		if (hsmv_on_idle) {
 			/* BMDMA engine is already stopped, we're screwed */
 			qc->err_mask |= AC_ERR_HSM;
 			ap->hsm_task_state = HSM_ST_ERR;
 		} else
-			goto idle_irq;
+			return ata_sff_idle_irq(ap);
 	}
 
 	/* clear irq events */
@@ -1555,43 +1532,30 @@ unsigned int ata_sff_host_intr(struct ata_port *ap,
 
 	ata_sff_hsm_move(ap, qc, status, 0);
 
-	if (unlikely(qc->err_mask) && (qc->tf.protocol == ATA_PROT_DMA ||
-				       qc->tf.protocol == ATAPI_PROT_DMA))
-		ata_ehi_push_desc(ehi, "BMDMA stat 0x%x", host_stat);
-
 	return 1;	/* irq handled */
-
-idle_irq:
-	ap->stats.idle_irq++;
-
-#ifdef ATA_IRQ_TRAP
-	if ((ap->stats.idle_irq % 1000) == 0) {
-		ap->ops->sff_check_status(ap);
-		if (ap->ops->sff_irq_clear)
-			ap->ops->sff_irq_clear(ap);
-		ata_port_printk(ap, KERN_WARNING, "irq trap\n");
-		return 1;
-	}
-#endif
-	return 0;	/* irq not handled */
 }
-EXPORT_SYMBOL_GPL(ata_sff_host_intr);
 
 /**
- *	ata_sff_interrupt - Default ATA host interrupt handler
- *	@irq: irq line (unused)
- *	@dev_instance: pointer to our ata_host information structure
+ *	ata_sff_port_intr - Handle SFF port interrupt
+ *	@ap: Port on which interrupt arrived (possibly...)
+ *	@qc: Taskfile currently active in engine
  *
- *	Default interrupt handler for PCI IDE devices.  Calls
- *	ata_sff_host_intr() for each port that is not disabled.
+ *	Handle port interrupt for given queued command.
  *
  *	LOCKING:
- *	Obtains host lock during operation.
+ *	spin_lock_irqsave(host lock)
  *
  *	RETURNS:
- *	IRQ_NONE or IRQ_HANDLED.
+ *	One if interrupt was handled, zero if not (shared irq).
  */
-irqreturn_t ata_sff_interrupt(int irq, void *dev_instance)
+unsigned int ata_sff_port_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
+{
+	return __ata_sff_port_intr(ap, qc, false);
+}
+EXPORT_SYMBOL_GPL(ata_sff_port_intr);
+
+static inline irqreturn_t __ata_sff_interrupt(int irq, void *dev_instance,
+	unsigned int (*port_intr)(struct ata_port *, struct ata_queued_cmd *))
 {
 	struct ata_host *host = dev_instance;
 	bool retried = false;
@@ -1611,7 +1575,7 @@ retry:
 		qc = ata_qc_from_tag(ap, ap->link.active_tag);
 		if (qc) {
 			if (!(qc->tf.flags & ATA_TFLAG_POLLING))
-				handled |= ata_sff_host_intr(ap, qc);
+				handled |= port_intr(ap, qc);
 			else
 				polling |= 1 << i;
 		} else
@@ -1661,6 +1625,25 @@ retry:
 
 	return IRQ_RETVAL(handled);
 }
+
+/**
+ *	ata_sff_interrupt - Default SFF ATA host interrupt handler
+ *	@irq: irq line (unused)
+ *	@dev_instance: pointer to our ata_host information structure
+ *
+ *	Default interrupt handler for PCI IDE devices.  Calls
+ *	ata_sff_port_intr() for each port that is not disabled.
+ *
+ *	LOCKING:
+ *	Obtains host lock during operation.
+ *
+ *	RETURNS:
+ *	IRQ_NONE or IRQ_HANDLED.
+ */
+irqreturn_t ata_sff_interrupt(int irq, void *dev_instance)
+{
+	return __ata_sff_interrupt(irq, dev_instance, ata_sff_port_intr);
+}
 EXPORT_SYMBOL_GPL(ata_sff_interrupt);
 
 /**
@@ -1698,7 +1681,7 @@ void ata_sff_lost_interrupt(struct ata_port *ap)
 								status);
 	/* Run the host interrupt logic as if the interrupt had not been
 	   lost */
-	ata_sff_host_intr(ap, qc);
+	ata_sff_port_intr(ap, qc);
 }
 EXPORT_SYMBOL_GPL(ata_sff_lost_interrupt);
 
@@ -2541,7 +2524,7 @@ int ata_pci_sff_init_one(struct pci_dev *pdev,
 	host->flags |= hflag;
 
 	pci_set_master(pdev);
-	rc = ata_pci_sff_activate_host(host, ata_sff_interrupt, sht);
+	rc = ata_pci_sff_activate_host(host, ata_bmdma_interrupt, sht);
 out:
 	if (rc == 0)
 		devres_remove_group(&pdev->dev, NULL);
@@ -2788,6 +2771,75 @@ unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc)
 EXPORT_SYMBOL_GPL(ata_bmdma_qc_issue);
 
 /**
+ *	ata_bmdma_port_intr - Handle BMDMA port interrupt
+ *	@ap: Port on which interrupt arrived (possibly...)
+ *	@qc: Taskfile currently active in engine
+ *
+ *	Handle port interrupt for given queued command.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	One if interrupt was handled, zero if not (shared irq).
+ */
+unsigned int ata_bmdma_port_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
+{
+	struct ata_eh_info *ehi = &ap->link.eh_info;
+	u8 host_stat = 0;
+	bool bmdma_stopped = false;
+	unsigned int handled;
+
+	if (ap->hsm_task_state == HSM_ST_LAST && ata_is_dma(qc->tf.protocol)) {
+		/* check status of DMA engine */
+		host_stat = ap->ops->bmdma_status(ap);
+		VPRINTK("ata%u: host_stat 0x%X\n", ap->print_id, host_stat);
+
+		/* if it's not our irq... */
+		if (!(host_stat & ATA_DMA_INTR))
+			return ata_sff_idle_irq(ap);
+
+		/* before we do anything else, clear DMA-Start bit */
+		ap->ops->bmdma_stop(qc);
+		bmdma_stopped = true;
+
+		if (unlikely(host_stat & ATA_DMA_ERR)) {
+			/* error when transfering data to/from memory */
+			qc->err_mask |= AC_ERR_HOST_BUS;
+			ap->hsm_task_state = HSM_ST_ERR;
+		}
+	}
+
+	handled = __ata_sff_port_intr(ap, qc, bmdma_stopped);
+
+	if (unlikely(qc->err_mask) && ata_is_dma(qc->tf.protocol))
+		ata_ehi_push_desc(ehi, "BMDMA stat 0x%x", host_stat);
+
+	return handled;
+}
+EXPORT_SYMBOL_GPL(ata_bmdma_port_intr);
+
+/**
+ *	ata_bmdma_interrupt - Default BMDMA ATA host interrupt handler
+ *	@irq: irq line (unused)
+ *	@dev_instance: pointer to our ata_host information structure
+ *
+ *	Default interrupt handler for PCI IDE devices.  Calls
+ *	ata_bmdma_port_intr() for each port that is not disabled.
+ *
+ *	LOCKING:
+ *	Obtains host lock during operation.
+ *
+ *	RETURNS:
+ *	IRQ_NONE or IRQ_HANDLED.
+ */
+irqreturn_t ata_bmdma_interrupt(int irq, void *dev_instance)
+{
+	return __ata_sff_interrupt(irq, dev_instance, ata_bmdma_port_intr);
+}
+EXPORT_SYMBOL_GPL(ata_bmdma_interrupt);
+
+/**
  *	ata_bmdma_error_handler - Stock error handler for BMDMA controller
  *	@ap: port to handle error for
  *
diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
index bb6e074..9529593 100644
--- a/drivers/ata/pata_atp867x.c
+++ b/drivers/ata/pata_atp867x.c
@@ -525,7 +525,7 @@ static int atp867x_init_one(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	rc = ata_host_activate(host, pdev->irq, ata_sff_interrupt,
+	rc = ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
 				IRQF_SHARED, &atp867x_sht);
 	if (rc)
 		dev_printk(KERN_ERR, &pdev->dev, "failed to activate host\n");
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 17c5f34..030952f 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -221,7 +221,7 @@ static int __devinit cs5520_init_one(struct pci_dev *pdev, const struct pci_devi
 			continue;
 
 		rc = devm_request_irq(&pdev->dev, irq[ap->port_no],
-				      ata_sff_interrupt, 0, DRV_NAME, host);
+				      ata_bmdma_interrupt, 0, DRV_NAME, host);
 		if (rc)
 			return rc;
 
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index 727a81c..b63d5e2 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -248,7 +248,7 @@ static int hpt3x3_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		ata_port_pbar_desc(ap, 4, offset_cmd[i], "cmd");
 	}
 	pci_set_master(pdev);
-	return ata_host_activate(host, pdev->irq, ata_sff_interrupt,
+	return ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
 				 IRQF_SHARED, &hpt3x3_sht);
 }
 
diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
index b56e8f7..9f2889f 100644
--- a/drivers/ata/pata_icside.c
+++ b/drivers/ata/pata_icside.c
@@ -470,7 +470,7 @@ static int __devinit pata_icside_add_ports(struct pata_icside_info *info)
 		pata_icside_setup_ioaddr(ap, info->base, info, info->port[i]);
 	}
 
-	return ata_host_activate(host, ec->irq, ata_sff_interrupt, 0,
+	return ata_host_activate(host, ec->irq, ata_bmdma_interrupt, 0,
 				 &pata_icside_sht);
 }
 
diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 25df50f..1ea30fd 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -1110,7 +1110,7 @@ static int __devinit pata_macio_common_init(struct pata_macio_priv	*priv,
 
 	/* Start it up */
 	priv->irq = irq;
-	return ata_host_activate(priv->host, irq, ata_sff_interrupt, 0,
+	return ata_host_activate(priv->host, irq, ata_bmdma_interrupt, 0,
 				 &pata_macio_sht);
 }
 
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 96b11b6..da752ef 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -659,7 +659,7 @@ mpc52xx_ata_init_one(struct device *dev, struct mpc52xx_ata_priv *priv,
 	ata_port_desc(ap, "ata_regs 0x%lx", raw_ata_regs);
 
 	/* activate host */
-	return ata_host_activate(host, priv->ata_irq, ata_sff_interrupt, 0,
+	return ata_host_activate(host, priv->ata_irq, ata_bmdma_interrupt, 0,
 				 &mpc52xx_ata_sht);
 }
 
diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
index dd53a66..cc50bd0 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -149,7 +149,7 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 
 	ninja32_program(base);
 	/* FIXME: Should we disable them at remove ? */
-	return ata_host_activate(host, dev->irq, ata_sff_interrupt,
+	return ata_host_activate(host, dev->irq, ata_bmdma_interrupt,
 				 IRQF_SHARED, &ninja32_sht);
 }
 
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 09f1f22..b183511 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -754,7 +754,7 @@ static int __devinit pdc2027x_init_one(struct pci_dev *pdev, const struct pci_de
 		return -EIO;
 
 	pci_set_master(pdev);
-	return ata_host_activate(host, pdev->irq, ata_sff_interrupt,
+	return ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
 				 IRQF_SHARED, &pdc2027x_sht);
 }
 
diff --git a/drivers/ata/pata_rdc.c b/drivers/ata/pata_rdc.c
index 37092cf..2dd7748 100644
--- a/drivers/ata/pata_rdc.c
+++ b/drivers/ata/pata_rdc.c
@@ -354,7 +354,7 @@ static int __devinit rdc_init_one(struct pci_dev *pdev,
 	host->flags |= ATA_HOST_PARALLEL_SCAN;
 
 	pci_set_master(pdev);
-	return ata_pci_sff_activate_host(host, ata_sff_interrupt, &rdc_sht);
+	return ata_pci_sff_activate_host(host, ata_bmdma_interrupt, &rdc_sht);
 }
 
 static void rdc_remove_one(struct pci_dev *pdev)
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index fb318cd..d9db3f8 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -1105,7 +1105,7 @@ static int scc_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	return ata_host_activate(host, pdev->irq, ata_sff_interrupt,
+	return ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
 				 IRQF_SHARED, &scc_sht);
 }
 
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 43faf10..ac55937 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -374,7 +374,7 @@ static int __devinit sil680_init_one(struct pci_dev *pdev,
 	ata_sff_std_ports(&host->ports[1]->ioaddr);
 
 	/* Register & activate */
-	return ata_host_activate(host, pdev->irq, ata_sff_interrupt,
+	return ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
 				 IRQF_SHARED, &sil680_sht);
 
 use_ioports:
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 16bacd3..a476cd9 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2811,7 +2811,7 @@ static void mv_port_intr(struct ata_port *ap, u32 port_cause)
 	} else if (!edma_was_enabled) {
 		struct ata_queued_cmd *qc = mv_get_active_qc(ap);
 		if (qc)
-			ata_sff_host_intr(ap, qc);
+			ata_bmdma_port_intr(ap, qc);
 		else
 			mv_unexpected_intr(ap, edma_was_enabled);
 	}
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 358dde0..4269b99 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -920,7 +920,7 @@ static int nv_host_intr(struct ata_port *ap, u8 irq_stat)
 	}
 
 	/* handle interrupt */
-	return ata_sff_host_intr(ap, qc);
+	return ata_bmdma_port_intr(ap, qc);
 }
 
 static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
@@ -1505,7 +1505,7 @@ static irqreturn_t nv_generic_interrupt(int irq, void *dev_instance)
 
 		qc = ata_qc_from_tag(ap, ap->link.active_tag);
 		if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
-			handled += ata_sff_host_intr(ap, qc);
+			handled += ata_bmdma_port_intr(ap, qc);
 		} else {
 			/*
 			 * No request pending?  Clear interrupt status
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index d533b3d..0074351 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -454,7 +454,7 @@ static inline unsigned int qs_intr_mmio(struct ata_host *host)
 		if (!pp || pp->state != qs_state_mmio)
 			continue;
 		if (!(qc->tf.flags & ATA_TFLAG_POLLING))
-			handled |= ata_sff_host_intr(ap, qc);
+			handled |= ata_sff_port_intr(ap, qc);
 	}
 	return handled;
 }
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index f8a91bf..fff1045 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -308,7 +308,7 @@ static int sis_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_master(pdev);
 	pci_intx(pdev, 1);
-	return ata_host_activate(host, pdev->irq, ata_sff_interrupt,
+	return ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
 				 IRQF_SHARED, &sis_sht);
 }
 
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 101fd6a..7d9db4a 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -502,7 +502,7 @@ static int k2_sata_init_one(struct pci_dev *pdev, const struct pci_device_id *en
 	writel(0x0, mmio_base + K2_SATA_SIM_OFFSET);
 
 	pci_set_master(pdev);
-	return ata_host_activate(host, pdev->irq, ata_sff_interrupt,
+	return ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
 				 IRQF_SHARED, &k2_sata_sht);
 }
 
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index d8dac17..b8578c3 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -242,7 +242,7 @@ static int uli_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_master(pdev);
 	pci_intx(pdev, 1);
-	return ata_host_activate(host, pdev->irq, ata_sff_interrupt,
+	return ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
 				 IRQF_SHARED, &uli_sht);
 }
 
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 7737dd5..7da5d01 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -628,7 +628,7 @@ static int svia_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	svia_configure(pdev);
 
 	pci_set_master(pdev);
-	return ata_host_activate(host, pdev->irq, ata_sff_interrupt,
+	return ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
 				 IRQF_SHARED, &svia_sht);
 }
 
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 2107952..b777176 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -245,7 +245,7 @@ static void vsc_port_intr(u8 port_status, struct ata_port *ap)
 
 	qc = ata_qc_from_tag(ap, ap->link.active_tag);
 	if (qc && likely(!(qc->tf.flags & ATA_TFLAG_POLLING)))
-		handled = ata_sff_host_intr(ap, qc);
+		handled = ata_bmdma_port_intr(ap, qc);
 
 	/* We received an interrupt during a polled command,
 	 * or some other spurious condition.  Interrupt reporting
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8fd1ca8..b76d767 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1593,7 +1593,7 @@ extern int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 extern void ata_sff_queue_pio_task(struct ata_port *ap, unsigned long delay);
 extern unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc);
 extern bool ata_sff_qc_fill_rtf(struct ata_queued_cmd *qc);
-extern unsigned int ata_sff_host_intr(struct ata_port *ap,
+extern unsigned int ata_sff_port_intr(struct ata_port *ap,
 				      struct ata_queued_cmd *qc);
 extern irqreturn_t ata_sff_interrupt(int irq, void *dev_instance);
 extern void ata_sff_lost_interrupt(struct ata_port *ap);
@@ -1628,6 +1628,9 @@ extern int ata_pci_sff_init_one(struct pci_dev *pdev,
 extern void ata_bmdma_qc_prep(struct ata_queued_cmd *qc);
 extern unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc);
 extern void ata_bmdma_dumb_qc_prep(struct ata_queued_cmd *qc);
+extern unsigned int ata_bmdma_port_intr(struct ata_port *ap,
+				      struct ata_queued_cmd *qc);
+extern irqreturn_t ata_bmdma_interrupt(int irq, void *dev_instance);
 extern void ata_bmdma_error_handler(struct ata_port *ap);
 extern void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
-- 
1.6.4.2

