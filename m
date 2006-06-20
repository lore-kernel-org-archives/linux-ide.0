From: Unicorn Chang <uchang@tw.ibm.com>
Subject: [PATCH 1/2] libata: make both legacy ports share one host_set , take
 #2
Date: Tue, 20 Jun 2006 12:41:55 +0800
Message-ID: <44977C93.7090001@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:8581 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964925AbWFTElr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jun 2006 00:41:47 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5K4fkNL020605
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Tue, 20 Jun 2006 00:41:46 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5K4fPcR254180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 19 Jun 2006 22:41:25 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5K4fjAS004725
	for <linux-ide@vger.kernel.org>; Mon, 19 Jun 2006 22:41:46 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Patch 1/2: 
- make both legacy ports share one host_set
- host_set->irq is preserved for shared irq case(PCI native mode).
- ap->ioaddr.irq is added for per-port non-shared irq case(legacy mode).

Signed-off-by: Unicorn Chang <uchang@tw.ibm.com>
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
The host_set is shared between the 2 legacy ports for the ATA_HOST_SIMPLEX
to work.
The per-port irq is also freed for the pata_amd unloading to load.
Briefly tested on x86 box.

--- upstream/drivers/scsi/ata_piix.c	2006-06-19 07:49:30.000000000 +0800
+++ upstream.patched/drivers/scsi/ata_piix.c	2006-06-19 07:55:34.000000000 +0800
@@ -249,7 +249,7 @@ static const struct ata_port_operations 
 	.error_handler		= piix_pata_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
-	.irq_handler		= ata_interrupt,
+	.irq_handler		= ata_nonshared_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
 	.port_start		= ata_port_start,
--- upstream/drivers/scsi/libata-bmdma.c	2006-06-19 07:45:57.000000000 +0800
+++ upstream.patched/drivers/scsi/libata-bmdma.c	2006-06-19 08:05:11.000000000 +0800
@@ -882,7 +882,7 @@ ata_pci_init_native_mode(struct pci_dev 
 		if (bmdma) {
 			bmdma += 8;
 			if(inb(bmdma + 2) & 0x80)
-			probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
 			probe_ent->port[p].bmdma_addr = bmdma;
 		}
 		ata_std_ports(&probe_ent->port[p]);
@@ -895,9 +895,11 @@ ata_pci_init_native_mode(struct pci_dev 
 
 
 static struct ata_probe_ent *ata_pci_init_legacy_port(struct pci_dev *pdev,
-				struct ata_port_info *port, int port_num)
+				struct ata_port_info **port, int ports)
 {
-	struct ata_probe_ent *probe_ent;
+	struct ata_probe_ent *probe_ent =
+		ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
+	int p = 0;
 	unsigned long bmdma;
 
 	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port);
@@ -905,35 +907,43 @@ static struct ata_probe_ent *ata_pci_ini
 		return NULL;
 
 	probe_ent->legacy_mode = 1;
-	probe_ent->n_ports = 1;
-	probe_ent->hard_port_no = port_num;
-	probe_ent->private_data = port->private_data;
-
-	switch(port_num)
-	{
-		case 0:
-			probe_ent->irq = 14;
-			probe_ent->port[0].cmd_addr = 0x1f0;
-			probe_ent->port[0].altstatus_addr =
-			probe_ent->port[0].ctl_addr = 0x3f6;
-			break;
-		case 1:
-			probe_ent->irq = 15;
-			probe_ent->port[0].cmd_addr = 0x170;
-			probe_ent->port[0].altstatus_addr =
-			probe_ent->port[0].ctl_addr = 0x376;
-			break;
+	probe_ent->irq = 0;
+	probe_ent->private_data = port[0]->private_data;
+
+	if (ports & ATA_PORT_PRIMARY) {
+		probe_ent->port[p].irq = 14;
+		probe_ent->port[p].cmd_addr = 0x1f0;
+		probe_ent->port[p].altstatus_addr =
+			probe_ent->port[p].ctl_addr = 0x3f6;
+
+		bmdma = pci_resource_start(pdev, 4);
+		if (bmdma) {
+			probe_ent->port[p].bmdma_addr = bmdma;
+			if (inb(bmdma + 2) & 0x80)
+				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+		}
+		ata_std_ports(&probe_ent->port[p]);
+		p++;
 	}
 
-	bmdma = pci_resource_start(pdev, 4);
-	if (bmdma != 0) {
-		bmdma += 8 * port_num;
-		probe_ent->port[0].bmdma_addr = bmdma;
-		if (inb(bmdma + 2) & 0x80)
-			probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+	if (ports & ATA_PORT_SECONDARY) {
+		probe_ent->port[p].irq = 15;
+		probe_ent->port[p].cmd_addr = 0x170;
+		probe_ent->port[p].altstatus_addr =
+			probe_ent->port[p].ctl_addr = 0x376;
+
+		bmdma = pci_resource_start(pdev, 4);
+		if (bmdma) {
+			bmdma += 8;
+			probe_ent->port[p].bmdma_addr = bmdma;
+			if(inb(bmdma + 2) & 0x80)
+				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+		}
+		ata_std_ports(&probe_ent->port[p]);
+		p++;
 	}
-	ata_std_ports(&probe_ent->port[0]);
 
+	probe_ent->n_ports = p;
 	return probe_ent;
 }
 
@@ -962,10 +972,10 @@ static struct ata_probe_ent *ata_pci_ini
 int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 		      unsigned int n_ports)
 {
-	struct ata_probe_ent *probe_ent = NULL, *probe_ent2 = NULL;
+	struct ata_probe_ent *probe_ent = NULL;
 	struct ata_port_info *port[2];
 	u8 tmp8, mask;
-	unsigned int legacy_mode = 0;
+	int legacy_mode = 0;
 	int disable_dev_on_err = 1;
 	int rc;
 
@@ -1057,17 +1067,14 @@ int ata_pci_init_one (struct pci_dev *pd
 		goto err_out_regions;
 
 	if (legacy_mode) {
-		if (legacy_mode & (1 << 0))
-			probe_ent = ata_pci_init_legacy_port(pdev, port[0], 0);
-		if (legacy_mode & (1 << 1))
-			probe_ent2 = ata_pci_init_legacy_port(pdev, port[1], 1);
+		probe_ent = ata_pci_init_legacy_mode(pdev, port, legacy_mode);
 	} else {
 		if (n_ports == 2)
 			probe_ent = ata_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 		else
 			probe_ent = ata_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY);
 	}
-	if (!probe_ent && !probe_ent2) {
+	if (!probe_ent) {
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
@@ -1075,27 +1082,9 @@ int ata_pci_init_one (struct pci_dev *pd
 	pci_set_master(pdev);
 
 	/* FIXME: check ata_device_add return */
-	if (legacy_mode) {
-		struct device *dev = &pdev->dev;
-		struct ata_host_set *host_set = NULL;
-
-		if (legacy_mode & (1 << 0)) {
-			ata_device_add(probe_ent);
-			host_set = dev_get_drvdata(dev);
-		}
-
-		if (legacy_mode & (1 << 1)) {
-			ata_device_add(probe_ent2);
-			if (host_set) {
-				host_set->next = dev_get_drvdata(dev);
-				dev_set_drvdata(dev, host_set);
-			}
-		}
-	} else
-		ata_device_add(probe_ent);
+	ata_device_add(probe_ent);
 
 	kfree(probe_ent);
-	kfree(probe_ent2);
 
 	return 0;
 
--- upstream/drivers/scsi/libata-core.c	2006-06-19 07:46:08.000000000 +0800
+++ upstream.patched/drivers/scsi/libata-core.c	2006-06-19 08:45:42.000000000 +0800
@@ -4773,6 +4773,7 @@ irqreturn_t ata_interrupt (int irq, void
 
 		ap = host_set->ports[i];
 		if (ap &&
+		    !ap->ioaddr.irq &&	/* skip port which used nonshared irq */
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
@@ -4786,6 +4787,47 @@ irqreturn_t ata_interrupt (int irq, void
 	spin_unlock_irqrestore(&host_set->lock, flags);
 
 	return IRQ_RETVAL(handled);
+} 
+
+/**
+ *	ata_nonshared interrupt - Default ATA host interrupt handler (legacy mode)
+ *	@irq: irq line (unused)
+ *	@dev_instance: pointer to our ata_port information structure
+ *	@regs: unused
+ *
+ *	Default legacy mode interrupt handler for PCI IDE devices.  Calls
+ *	ata_host_intr() for each port that is not disabled.
+ *
+ *	LOCKING:
+ *	Obtains host_set lock during operation.
+ *
+ *	RETURNS:
+ *	IRQ_NONE or IRQ_HANDLED.
+ */
+
+irqreturn_t ata_nonshared_interrupt (int irq, void *dev_instance,
+					struct pt_regs *regs)
+{
+	struct ata_port *ap = dev_instance;
+	unsigned int handled = 0;
+	unsigned long flags;
+
+	/* TODO: make _irqsave conditional on x86 PCI IDE legacy mode */
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+
+	if (ap &&
+	    !(ap->flags & ATA_FLAG_DISABLED)) {
+		struct ata_queued_cmd *qc;
+
+		qc = ata_qc_from_tag(ap, ap->active_tag);
+		if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
+		    (qc->flags & ATA_QCFLAG_ACTIVE))
+			handled |= ata_host_intr(ap, qc);
+	}
+
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	return IRQ_RETVAL(handled);
 }
 
 /**
@@ -5174,8 +5216,7 @@ static void ata_host_init(struct ata_por
 	ap->host_set = host_set;
 	ap->dev = ent->dev;
 	ap->port_no = port_no;
-	ap->hard_port_no =
-		ent->legacy_mode ? ent->hard_port_no : port_no;
+	ap->hard_port_no = port_no;
 	ap->pio_mask = ent->pio_mask;
 	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
@@ -5318,6 +5359,7 @@ int ata_device_add(const struct ata_prob
 	for (i = 0; i < ent->n_ports; i++) {
 		struct ata_port *ap;
 		unsigned long xfer_mode_mask;
+		unsigned long irq;
 
 		ap = ata_host_add(ent, host_set, i);
 		if (!ap)
@@ -5328,6 +5370,11 @@ int ata_device_add(const struct ata_prob
 				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
 				(ap->pio_mask << ATA_SHIFT_PIO);
 
+		if (ap->ioaddr.irq) {
+			irq = ap->ioaddr.irq;
+		} else
+			irq = ent->irq;
+
 		/* print per-port info to dmesg */
 		ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%lX "
 				"ctl 0x%lX bmdma 0x%lX irq %lu\n",
@@ -5336,11 +5383,21 @@ int ata_device_add(const struct ata_prob
 				ap->ioaddr.cmd_addr,
 				ap->ioaddr.ctl_addr,
 				ap->ioaddr.bmdma_addr,
-				ent->irq);
+				irq);
 
 		ata_chk_status(ap);
 		host_set->ops->irq_clear(ap);
 		ata_eh_freeze_port(ap);	/* freeze port before requesting IRQ */
+
+		if (ap->ioaddr.irq){
+			/* obtain nonshared per-port irq */
+			rc = request_irq(irq, ent->port_ops->irq_handler, 0, DRV_NAME, ap);
+			if (rc) {
+				dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
+						irq, rc);
+				goto err_out;
+			}
+		}
 		count++;
 	}
 
@@ -5348,12 +5405,14 @@ int ata_device_add(const struct ata_prob
 		goto err_free_ret;
 
 	/* obtain irq, that is shared between channels */
-	rc = request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
-			 DRV_NAME, host_set);
-	if (rc) {
-		dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
-			   ent->irq, rc);
-		goto err_out;
+	if (ent->irq){
+		rc = request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
+				 DRV_NAME, host_set);
+		if (rc) {
+			dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
+				   ent->irq, rc);
+			goto err_out;
+		}
 	}
 
 	/* perform each probe synchronously */
@@ -5511,11 +5570,12 @@ void ata_port_detach(struct ata_port *ap
 void ata_host_set_remove(struct ata_host_set *host_set)
 {
 	unsigned int i;
+	int native = 0;
 
 	for (i = 0; i < host_set->n_ports; i++)
 		ata_port_detach(host_set->ports[i]);
 
-	free_irq(host_set->irq, host_set);
+
 
 	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
@@ -5525,15 +5585,20 @@ void ata_host_set_remove(struct ata_host
 		if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
 			struct ata_ioports *ioaddr = &ap->ioaddr;
 
-			if (ioaddr->cmd_addr == 0x1f0)
-				release_region(0x1f0, 8);
-			else if (ioaddr->cmd_addr == 0x170)
-				release_region(0x170, 8);
-		}
+			WARN_ON(!(ioaddr->cmd_addr == 0x1f0 ||
+				  ioaddr->cmd_addr == 0x170));
+
+			release_region(ioaddr->cmd_addr, 8);
+			free_irq(ioaddr->irq, ap);
+		} else
+			native++;
 
 		scsi_host_put(ap->host);
 	}
 
+	if (native)
+		free_irq(host_set->irq, host_set);
+
 	if (host_set->ops->host_stop)
 		host_set->ops->host_stop(host_set);
 
@@ -5621,12 +5686,8 @@ void ata_pci_remove_one (struct pci_dev 
 {
 	struct device *dev = pci_dev_to_dev(pdev);
 	struct ata_host_set *host_set = dev_get_drvdata(dev);
-	struct ata_host_set *host_set2 = host_set->next;
 
 	ata_host_set_remove(host_set);
-	if (host_set2)
-		ata_host_set_remove(host_set2);
-
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	dev_set_drvdata(dev, NULL);
@@ -5810,6 +5871,7 @@ EXPORT_SYMBOL_GPL(ata_exec_command);
 EXPORT_SYMBOL_GPL(ata_port_start);
 EXPORT_SYMBOL_GPL(ata_port_stop);
 EXPORT_SYMBOL_GPL(ata_host_stop);
+EXPORT_SYMBOL_GPL(ata_nonshared_interrupt);
 EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_mmio_data_xfer);
 EXPORT_SYMBOL_GPL(ata_pio_data_xfer);
--- upstream/include/linux/libata.h	2006-06-19 07:47:53.000000000 +0800
+++ upstream.patched/include/linux/libata.h	2006-06-19 08:14:34.000000000 +0800
@@ -323,6 +323,7 @@ struct ata_ioports {
 	unsigned long		ctl_addr;
 	unsigned long		bmdma_addr;
 	unsigned long		scr_addr;
+	unsigned long		irq;
 };
 
 struct ata_probe_ent {
@@ -356,7 +357,6 @@ struct ata_host_set {
 	unsigned long		flags;
 	int			simplex_claimed;	/* Keep seperate in case we
 							   ever need to do this locked */
-	struct ata_host_set	*next;		/* for legacy mode */
 	struct ata_port		*ports[0];
 };
 
@@ -688,6 +688,8 @@ extern int ata_port_start (struct ata_po
 extern void ata_port_stop (struct ata_port *ap);
 extern void ata_host_stop (struct ata_host_set *host_set);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
+extern irqreturn_t ata_nonshared_interrupt (int irq, void *dev_instance,
+				 struct pt_regs *regs);
 extern void ata_mmio_data_xfer(struct ata_device *adev, unsigned char *buf,
 			       unsigned int buflen, int write_data);
 extern void ata_pio_data_xfer(struct ata_device *adev, unsigned char *buf, 





