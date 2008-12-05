From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 6/7] libata: clean up the SFF code for coding style
Date: Fri, 05 Dec 2008 19:43:50 +0000
Message-ID: <20081205194333.17133.94943.stgit@localhost.localdomain>
References: <20081205194231.17133.42760.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40173 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755737AbYLETnt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Dec 2008 14:43:49 -0500
In-Reply-To: <20081205194231.17133.42760.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kai@kaishome.de, linux-ide@vger.kernel.org, jeff@garzik.org

From: Alan Cox <alan@redhat.com>

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/ata/libata-sff.c |  136 +++++++++++++++++++++++-----------------------
 1 files changed, 69 insertions(+), 67 deletions(-)


diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index e9c09cd..61b1fb4 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -69,6 +69,7 @@ const struct ata_port_operations ata_sff_port_ops = {
 
 	.port_start		= ata_sff_port_start,
 };
+EXPORT_SYMBOL_GPL(ata_sff_port_ops);
 
 const struct ata_port_operations ata_bmdma_port_ops = {
 	.inherits		= &ata_sff_port_ops,
@@ -80,6 +81,7 @@ const struct ata_port_operations ata_bmdma_port_ops = {
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
 };
+EXPORT_SYMBOL_GPL(ata_bmdma_port_ops);
 
 /**
  *	ata_fill_sg - Fill PCI IDE PRD table
@@ -169,8 +171,9 @@ static void ata_fill_sg_dumb(struct ata_queued_cmd *qc)
 			blen = len & 0xffff;
 			ap->prd[pi].addr = cpu_to_le32(addr);
 			if (blen == 0) {
-			   /* Some PATA chipsets like the CS5530 can't
-			      cope with 0x0000 meaning 64K as the spec says */
+				/* Some PATA chipsets like the CS5530 can't
+				   cope with 0x0000 meaning 64K as the spec
+				   says */
 				ap->prd[pi].flags_len = cpu_to_le32(0x8000);
 				blen = 0x8000;
 				ap->prd[++pi].addr = cpu_to_le32(addr + 0x8000);
@@ -203,6 +206,7 @@ void ata_sff_qc_prep(struct ata_queued_cmd *qc)
 
 	ata_fill_sg(qc);
 }
+EXPORT_SYMBOL_GPL(ata_sff_qc_prep);
 
 /**
  *	ata_sff_dumb_qc_prep - Prepare taskfile for submission
@@ -220,6 +224,7 @@ void ata_sff_dumb_qc_prep(struct ata_queued_cmd *qc)
 
 	ata_fill_sg_dumb(qc);
 }
+EXPORT_SYMBOL_GPL(ata_sff_dumb_qc_prep);
 
 /**
  *	ata_sff_check_status - Read device status reg & clear interrupt
@@ -236,6 +241,7 @@ u8 ata_sff_check_status(struct ata_port *ap)
 {
 	return ioread8(ap->ioaddr.status_addr);
 }
+EXPORT_SYMBOL_GPL(ata_sff_check_status);
 
 /**
  *	ata_sff_altstatus - Read device alternate status reg
@@ -278,7 +284,7 @@ static u8 ata_sff_irq_status(struct ata_port *ap)
 		status = ata_sff_altstatus(ap);
 		/* Not us: We are busy */
 		if (status & ATA_BUSY)
-		    	return status;
+			return status;
 	}
 	/* Clear INTRQ latch */
 	status = ap->ops->sff_check_status(ap);
@@ -322,6 +328,7 @@ void ata_sff_pause(struct ata_port *ap)
 	ata_sff_sync(ap);
 	ndelay(400);
 }
+EXPORT_SYMBOL_GPL(ata_sff_pause);
 
 /**
  *	ata_sff_dma_pause	-	Pause before commencing DMA
@@ -330,7 +337,7 @@ void ata_sff_pause(struct ata_port *ap)
  *	Perform I/O fencing and ensure sufficient cycle delays occur
  *	for the HDMA1:0 transition
  */
- 
+
 void ata_sff_dma_pause(struct ata_port *ap)
 {
 	if (ap->ops->sff_check_altstatus || ap->ioaddr.altstatus_addr) {
@@ -344,6 +351,7 @@ void ata_sff_dma_pause(struct ata_port *ap)
 	   corruption. */
 	BUG();
 }
+EXPORT_SYMBOL_GPL(ata_sff_dma_pause);
 
 /**
  *	ata_sff_busy_sleep - sleep until BSY clears, or timeout
@@ -399,6 +407,7 @@ int ata_sff_busy_sleep(struct ata_port *ap,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_sff_busy_sleep);
 
 static int ata_sff_check_ready(struct ata_link *link)
 {
@@ -425,6 +434,7 @@ int ata_sff_wait_ready(struct ata_link *link, unsigned long deadline)
 {
 	return ata_wait_ready(link, deadline, ata_sff_check_ready);
 }
+EXPORT_SYMBOL_GPL(ata_sff_wait_ready);
 
 /**
  *	ata_sff_dev_select - Select device 0/1 on ATA bus
@@ -452,6 +462,7 @@ void ata_sff_dev_select(struct ata_port *ap, unsigned int device)
 	iowrite8(tmp, ap->ioaddr.device_addr);
 	ata_sff_pause(ap);	/* needed; also flushes, for mmio */
 }
+EXPORT_SYMBOL_GPL(ata_sff_dev_select);
 
 /**
  *	ata_dev_select - Select device 0/1 on ATA bus
@@ -516,6 +527,7 @@ u8 ata_sff_irq_on(struct ata_port *ap)
 
 	return tmp;
 }
+EXPORT_SYMBOL_GPL(ata_sff_irq_on);
 
 /**
  *	ata_sff_irq_clear - Clear PCI IDE BMDMA interrupt.
@@ -537,6 +549,7 @@ void ata_sff_irq_clear(struct ata_port *ap)
 
 	iowrite8(ioread8(mmio + ATA_DMA_STATUS), mmio + ATA_DMA_STATUS);
 }
+EXPORT_SYMBOL_GPL(ata_sff_irq_clear);
 
 /**
  *	ata_sff_tf_load - send taskfile registers to host controller
@@ -596,6 +609,7 @@ void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 
 	ata_wait_idle(ap);
 }
+EXPORT_SYMBOL_GPL(ata_sff_tf_load);
 
 /**
  *	ata_sff_tf_read - input device's ATA taskfile shadow registers
@@ -636,6 +650,7 @@ void ata_sff_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 			WARN_ON(1);
 	}
 }
+EXPORT_SYMBOL_GPL(ata_sff_tf_read);
 
 /**
  *	ata_sff_exec_command - issue ATA command to host controller
@@ -655,6 +670,7 @@ void ata_sff_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
 	iowrite8(tf->command, ap->ioaddr.command_addr);
 	ata_sff_pause(ap);
 }
+EXPORT_SYMBOL_GPL(ata_sff_exec_command);
 
 /**
  *	ata_tf_to_host - issue ATA taskfile to host controller
@@ -720,6 +736,7 @@ unsigned int ata_sff_data_xfer(struct ata_device *dev, unsigned char *buf,
 
 	return words << 1;
 }
+EXPORT_SYMBOL_GPL(ata_sff_data_xfer);
 
 /**
  *	ata_sff_data_xfer_noirq - Transfer data by PIO
@@ -749,6 +766,7 @@ unsigned int ata_sff_data_xfer_noirq(struct ata_device *dev, unsigned char *buf,
 
 	return consumed;
 }
+EXPORT_SYMBOL_GPL(ata_sff_data_xfer_noirq);
 
 /**
  *	ata_pio_sector - Transfer a sector of data.
@@ -925,13 +943,15 @@ next_sg:
 		buf = kmap_atomic(page, KM_IRQ0);
 
 		/* do the actual data transfer */
-		consumed = ap->ops->sff_data_xfer(dev,  buf + offset, count, rw);
+		consumed = ap->ops->sff_data_xfer(dev,  buf + offset,
+								count, rw);
 
 		kunmap_atomic(buf, KM_IRQ0);
 		local_irq_restore(flags);
 	} else {
 		buf = page_address(page);
-		consumed = ap->ops->sff_data_xfer(dev,  buf + offset, count, rw);
+		consumed = ap->ops->sff_data_xfer(dev,  buf + offset,
+								count, rw);
 	}
 
 	bytes -= min(bytes, consumed);
@@ -1016,18 +1036,19 @@ static void atapi_pio_bytes(struct ata_queued_cmd *qc)
  *	RETURNS:
  *	1 if ok in workqueue, 0 otherwise.
  */
-static inline int ata_hsm_ok_in_wq(struct ata_port *ap, struct ata_queued_cmd *qc)
+static inline int ata_hsm_ok_in_wq(struct ata_port *ap,
+						struct ata_queued_cmd *qc)
 {
 	if (qc->tf.flags & ATA_TFLAG_POLLING)
 		return 1;
 
 	if (ap->hsm_task_state == HSM_ST_FIRST) {
 		if (qc->tf.protocol == ATA_PROT_PIO &&
-		    (qc->tf.flags & ATA_TFLAG_WRITE))
+		   (qc->tf.flags & ATA_TFLAG_WRITE))
 		    return 1;
 
 		if (ata_is_atapi(qc->tf.protocol) &&
-		    !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
+		   !(qc->dev->flags & ATA_DFLAG_CDB_INTR))
 			return 1;
 	}
 
@@ -1341,6 +1362,7 @@ fsm_start:
 
 	return poll_next;
 }
+EXPORT_SYMBOL_GPL(ata_sff_hsm_move);
 
 void ata_pio_task(struct work_struct *work)
 {
@@ -1510,6 +1532,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_sff_qc_issue);
 
 /**
  *	ata_sff_qc_fill_rtf - fill result TF using ->sff_tf_read
@@ -1529,6 +1552,7 @@ bool ata_sff_qc_fill_rtf(struct ata_queued_cmd *qc)
 	qc->ap->ops->sff_tf_read(qc->ap, &qc->result_tf);
 	return true;
 }
+EXPORT_SYMBOL_GPL(ata_sff_qc_fill_rtf);
 
 /**
  *	ata_sff_host_intr - Handle host interrupt for given (port, task)
@@ -1626,6 +1650,7 @@ idle_irq:
 #endif
 	return 0;	/* irq not handled */
 }
+EXPORT_SYMBOL_GPL(ata_sff_host_intr);
 
 /**
  *	ata_sff_interrupt - Default ATA host interrupt handler
@@ -1670,6 +1695,7 @@ irqreturn_t ata_sff_interrupt(int irq, void *dev_instance)
 
 	return IRQ_RETVAL(handled);
 }
+EXPORT_SYMBOL_GPL(ata_sff_interrupt);
 
 /**
  *	ata_sff_lost_interrupt	-	Check for an apparent lost interrupt
@@ -1711,6 +1737,7 @@ void ata_sff_lost_interrupt(struct ata_port *ap)
 	   lost */
 	ata_sff_host_intr(ap, qc);
 }
+EXPORT_SYMBOL_GPL(ata_sff_lost_interrupt);
 
 /**
  *	ata_sff_freeze - Freeze SFF controller port
@@ -1739,6 +1766,7 @@ void ata_sff_freeze(struct ata_port *ap)
 
 	ap->ops->sff_irq_clear(ap);
 }
+EXPORT_SYMBOL_GPL(ata_sff_freeze);
 
 /**
  *	ata_sff_thaw - Thaw SFF controller port
@@ -1756,6 +1784,7 @@ void ata_sff_thaw(struct ata_port *ap)
 	ap->ops->sff_irq_clear(ap);
 	ap->ops->sff_irq_on(ap);
 }
+EXPORT_SYMBOL_GPL(ata_sff_thaw);
 
 /**
  *	ata_sff_prereset - prepare SFF link for reset
@@ -1797,6 +1826,7 @@ int ata_sff_prereset(struct ata_link *link, unsigned long deadline)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_sff_prereset);
 
 /**
  *	ata_devchk - PATA device presence detection
@@ -1909,6 +1939,7 @@ unsigned int ata_sff_dev_classify(struct ata_device *dev, int present,
 
 	return class;
 }
+EXPORT_SYMBOL_GPL(ata_sff_dev_classify);
 
 /**
  *	ata_sff_wait_after_reset - wait for devices to become ready after reset
@@ -1985,6 +2016,7 @@ int ata_sff_wait_after_reset(struct ata_link *link, unsigned int devmask,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ata_sff_wait_after_reset);
 
 static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
 			     unsigned long deadline)
@@ -2057,6 +2089,7 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
 	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_sff_softreset);
 
 /**
  *	sata_sff_hardreset - reset host port via SATA phy reset
@@ -2089,6 +2122,7 @@ int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
 	DPRINTK("EXIT, class=%u\n", *class);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(sata_sff_hardreset);
 
 /**
  *	ata_sff_postreset - SFF postreset callback
@@ -2124,6 +2158,7 @@ void ata_sff_postreset(struct ata_link *link, unsigned int *classes)
 	if (ap->ioaddr.ctl_addr)
 		iowrite8(ap->ctl, ap->ioaddr.ctl_addr);
 }
+EXPORT_SYMBOL_GPL(ata_sff_postreset);
 
 /**
  *	ata_sff_drain_fifo - Stock FIFO drain logic for SFF controllers
@@ -2156,6 +2191,7 @@ void ata_sff_drain_fifo(struct ata_queued_cmd *qc)
 			"drained %d bytes to clear DRQ.\n", count);
 
 }
+EXPORT_SYMBOL_GPL(ata_sff_drain_fifo);
 
 /**
  *	ata_sff_error_handler - Stock error handler for BMDMA controller
@@ -2236,6 +2272,7 @@ void ata_sff_error_handler(struct ata_port *ap)
 	ata_do_eh(ap, ap->ops->prereset, softreset, hardreset,
 		  ap->ops->postreset);
 }
+EXPORT_SYMBOL_GPL(ata_sff_error_handler);
 
 /**
  *	ata_sff_post_internal_cmd - Stock post_internal_cmd for SFF controller
@@ -2258,6 +2295,7 @@ void ata_sff_post_internal_cmd(struct ata_queued_cmd *qc)
 
 	spin_unlock_irqrestore(ap->lock, flags);
 }
+EXPORT_SYMBOL_GPL(ata_sff_post_internal_cmd);
 
 /**
  *	ata_sff_port_start - Set port up for dma.
@@ -2278,6 +2316,7 @@ int ata_sff_port_start(struct ata_port *ap)
 		return ata_port_start(ap);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_sff_port_start);
 
 /**
  *	ata_sff_std_ports - initialize ioaddr with standard port offsets.
@@ -2303,6 +2342,7 @@ void ata_sff_std_ports(struct ata_ioports *ioaddr)
 	ioaddr->status_addr = ioaddr->cmd_addr + ATA_REG_STATUS;
 	ioaddr->command_addr = ioaddr->cmd_addr + ATA_REG_CMD;
 }
+EXPORT_SYMBOL_GPL(ata_sff_std_ports);
 
 unsigned long ata_bmdma_mode_filter(struct ata_device *adev,
 				    unsigned long xfer_mask)
@@ -2314,6 +2354,7 @@ unsigned long ata_bmdma_mode_filter(struct ata_device *adev,
 		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
 	return xfer_mask;
 }
+EXPORT_SYMBOL_GPL(ata_bmdma_mode_filter);
 
 /**
  *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
@@ -2342,6 +2383,7 @@ void ata_bmdma_setup(struct ata_queued_cmd *qc)
 	/* issue r/w command */
 	ap->ops->sff_exec_command(ap, &qc->tf);
 }
+EXPORT_SYMBOL_GPL(ata_bmdma_setup);
 
 /**
  *	ata_bmdma_start - Start a PCI IDE BMDMA transaction
@@ -2374,6 +2416,7 @@ void ata_bmdma_start(struct ata_queued_cmd *qc)
 	 * unneccessarily delayed for MMIO
 	 */
 }
+EXPORT_SYMBOL_GPL(ata_bmdma_start);
 
 /**
  *	ata_bmdma_stop - Stop PCI IDE BMDMA transfer
@@ -2398,6 +2441,7 @@ void ata_bmdma_stop(struct ata_queued_cmd *qc)
 	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
 	ata_sff_dma_pause(ap);
 }
+EXPORT_SYMBOL_GPL(ata_bmdma_stop);
 
 /**
  *	ata_bmdma_status - Read PCI IDE BMDMA status
@@ -2414,6 +2458,7 @@ u8 ata_bmdma_status(struct ata_port *ap)
 {
 	return ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 }
+EXPORT_SYMBOL_GPL(ata_bmdma_status);
 
 /**
  *	ata_bus_reset - reset host port and associated ATA channel
@@ -2506,6 +2551,7 @@ err_out:
 
 	DPRINTK("EXIT\n");
 }
+EXPORT_SYMBOL_GPL(ata_bus_reset);
 
 #ifdef CONFIG_PCI
 
@@ -2533,6 +2579,7 @@ int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev)
 		return -EOPNOTSUPP;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_pci_bmdma_clear_simplex);
 
 /**
  *	ata_pci_bmdma_init - acquire PCI BMDMA resources and init ATA host
@@ -2585,11 +2632,12 @@ int ata_pci_bmdma_init(struct ata_host *host)
 			host->flags |= ATA_HOST_SIMPLEX;
 
 		ata_port_desc(ap, "bmdma 0x%llx",
-			(unsigned long long)pci_resource_start(pdev, 4) + 8 * i);
+		    (unsigned long long)pci_resource_start(pdev, 4) + 8 * i);
 	}
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_pci_bmdma_init);
 
 static int ata_resources_present(struct pci_dev *pdev, int port)
 {
@@ -2597,7 +2645,7 @@ static int ata_resources_present(struct pci_dev *pdev, int port)
 
 	/* Check the PCI resources for this channel are enabled */
 	port = port * 2;
-	for (i = 0; i < 2; i ++) {
+	for (i = 0; i < 2; i++) {
 		if (pci_resource_start(pdev, port + i) == 0 ||
 		    pci_resource_len(pdev, port + i) == 0)
 			return 0;
@@ -2682,6 +2730,7 @@ int ata_pci_sff_init_host(struct ata_host *host)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ata_pci_sff_init_host);
 
 /**
  *	ata_pci_sff_prepare_host - helper to prepare native PCI ATA host
@@ -2699,7 +2748,7 @@ int ata_pci_sff_init_host(struct ata_host *host)
  *	0 on success, -errno otherwise.
  */
 int ata_pci_sff_prepare_host(struct pci_dev *pdev,
-			     const struct ata_port_info * const * ppi,
+			     const struct ata_port_info * const *ppi,
 			     struct ata_host **r_host)
 {
 	struct ata_host *host;
@@ -2729,17 +2778,18 @@ int ata_pci_sff_prepare_host(struct pci_dev *pdev,
 	*r_host = host;
 	return 0;
 
- err_bmdma:
+err_bmdma:
 	/* This is necessary because PCI and iomap resources are
 	 * merged and releasing the top group won't release the
 	 * acquired resources if some of those have been acquired
 	 * before entering this function.
 	 */
 	pcim_iounmap_regions(pdev, 0xf);
- err_out:
+err_out:
 	devres_release_group(&pdev->dev, NULL);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ata_pci_sff_prepare_host);
 
 /**
  *	ata_pci_sff_activate_host - start SFF host, request IRQ and register it
@@ -2825,7 +2875,7 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 	}
 
 	rc = ata_host_register(host, sht);
- out:
+out:
 	if (rc == 0)
 		devres_remove_group(dev, NULL);
 	else
@@ -2833,6 +2883,7 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ata_pci_sff_activate_host);
 
 /**
  *	ata_pci_sff_init_one - Initialize/register PCI IDE host controller
@@ -2860,7 +2911,7 @@ int ata_pci_sff_activate_host(struct ata_host *host,
  *	Zero on success, negative on errno-based value on error.
  */
 int ata_pci_sff_init_one(struct pci_dev *pdev,
-			 const struct ata_port_info * const * ppi,
+			 const struct ata_port_info * const *ppi,
 			 struct scsi_host_template *sht, void *host_priv)
 {
 	struct device *dev = &pdev->dev;
@@ -2899,7 +2950,7 @@ int ata_pci_sff_init_one(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 	rc = ata_pci_sff_activate_host(host, ata_sff_interrupt, sht);
- out:
+out:
 	if (rc == 0)
 		devres_remove_group(&pdev->dev, NULL);
 	else
@@ -2907,56 +2958,7 @@ int ata_pci_sff_init_one(struct pci_dev *pdev,
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ata_pci_sff_init_one);
 
 #endif /* CONFIG_PCI */
 
-EXPORT_SYMBOL_GPL(ata_sff_port_ops);
-EXPORT_SYMBOL_GPL(ata_bmdma_port_ops);
-EXPORT_SYMBOL_GPL(ata_sff_qc_prep);
-EXPORT_SYMBOL_GPL(ata_sff_dumb_qc_prep);
-EXPORT_SYMBOL_GPL(ata_sff_dev_select);
-EXPORT_SYMBOL_GPL(ata_sff_check_status);
-EXPORT_SYMBOL_GPL(ata_sff_dma_pause);
-EXPORT_SYMBOL_GPL(ata_sff_pause);
-EXPORT_SYMBOL_GPL(ata_sff_busy_sleep);
-EXPORT_SYMBOL_GPL(ata_sff_wait_ready);
-EXPORT_SYMBOL_GPL(ata_sff_tf_load);
-EXPORT_SYMBOL_GPL(ata_sff_tf_read);
-EXPORT_SYMBOL_GPL(ata_sff_exec_command);
-EXPORT_SYMBOL_GPL(ata_sff_data_xfer);
-EXPORT_SYMBOL_GPL(ata_sff_data_xfer_noirq);
-EXPORT_SYMBOL_GPL(ata_sff_irq_on);
-EXPORT_SYMBOL_GPL(ata_sff_irq_clear);
-EXPORT_SYMBOL_GPL(ata_sff_hsm_move);
-EXPORT_SYMBOL_GPL(ata_sff_qc_issue);
-EXPORT_SYMBOL_GPL(ata_sff_qc_fill_rtf);
-EXPORT_SYMBOL_GPL(ata_sff_host_intr);
-EXPORT_SYMBOL_GPL(ata_sff_interrupt);
-EXPORT_SYMBOL_GPL(ata_sff_lost_interrupt);
-EXPORT_SYMBOL_GPL(ata_sff_freeze);
-EXPORT_SYMBOL_GPL(ata_sff_thaw);
-EXPORT_SYMBOL_GPL(ata_sff_prereset);
-EXPORT_SYMBOL_GPL(ata_sff_dev_classify);
-EXPORT_SYMBOL_GPL(ata_sff_wait_after_reset);
-EXPORT_SYMBOL_GPL(ata_sff_softreset);
-EXPORT_SYMBOL_GPL(sata_sff_hardreset);
-EXPORT_SYMBOL_GPL(ata_sff_postreset);
-EXPORT_SYMBOL_GPL(ata_sff_drain_fifo);
-EXPORT_SYMBOL_GPL(ata_sff_error_handler);
-EXPORT_SYMBOL_GPL(ata_sff_post_internal_cmd);
-EXPORT_SYMBOL_GPL(ata_sff_port_start);
-EXPORT_SYMBOL_GPL(ata_sff_std_ports);
-EXPORT_SYMBOL_GPL(ata_bmdma_mode_filter);
-EXPORT_SYMBOL_GPL(ata_bmdma_setup);
-EXPORT_SYMBOL_GPL(ata_bmdma_start);
-EXPORT_SYMBOL_GPL(ata_bmdma_stop);
-EXPORT_SYMBOL_GPL(ata_bmdma_status);
-EXPORT_SYMBOL_GPL(ata_bus_reset);
-#ifdef CONFIG_PCI
-EXPORT_SYMBOL_GPL(ata_pci_bmdma_clear_simplex);
-EXPORT_SYMBOL_GPL(ata_pci_bmdma_init);
-EXPORT_SYMBOL_GPL(ata_pci_sff_init_host);
-EXPORT_SYMBOL_GPL(ata_pci_sff_prepare_host);
-EXPORT_SYMBOL_GPL(ata_pci_sff_activate_host);
-EXPORT_SYMBOL_GPL(ata_pci_sff_init_one);
-#endif /* CONFIG_PCI */

