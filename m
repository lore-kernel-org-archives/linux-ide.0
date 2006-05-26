From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 1/2] libata: make both legacy ports share one host_set
Date: Fri, 26 May 2006 14:28:57 +0800
Message-ID: <4476A029.8060303@tw.ibm.com>
References: <20060524165006.GC12022@harddisk-recovery.com> <4476947A.3020003@tw.ibm.com> <4476991E.5060506@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:3002 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751289AbWEZG3D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 May 2006 02:29:03 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4Q6T0o9012013
	for <linux-ide@vger.kernel.org>; Fri, 26 May 2006 02:29:00 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4Q6T0jP267350
	for <linux-ide@vger.kernel.org>; Fri, 26 May 2006 00:29:00 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k4Q6Sx8F022663
	for <linux-ide@vger.kernel.org>; Fri, 26 May 2006 00:29:00 -0600
In-Reply-To: <4476991E.5060506@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, rene.herman@keyaccess.nl, Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Patch 1/2: 
- make both legacy ports share one host_set
- use signed irq (-1) if variable not used
- host_set->irq is preserved for shared irq case(PCI native mode).
- ap->ioaddr.irq is added for per-port non-shared irq case(legacy mode).
- ATA_FLAG_LEGACY added to flag the legacy ports

Signed-off-by: Unicorn Chang <uchang@tw.ibm.com>
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
The host_set is shared between the 2 legacy ports
for the ATA_HOST_SIMPLEX to work.
The per-port irq is also freed for the pata_amd unloading to load.
Briefly tested on x86 box.

For your review, thanks.

--- upstream0/include/linux/libata.h	2006-05-25 10:45:36.000000000 +0800
+++ 1_legacy_irq/include/linux/libata.h	2006-05-26 09:19:40.000000000 +0800
@@ -149,8 +149,9 @@ enum {
 	ATA_FLAG_NO_ATAPI	= (1 << 6), /* No ATAPI support */
 	ATA_FLAG_PIO_DMA	= (1 << 7), /* PIO cmds via DMA */
 	ATA_FLAG_PIO_LBA48	= (1 << 8), /* Host DMA engine is LBA28 only */
-	ATA_FLAG_PIO_POLLING	= (1 << 10), /* use polling PIO if LLD
+	ATA_FLAG_PIO_POLLING	= (1 << 9), /* use polling PIO if LLD
 					      * doesn't handle PIO interrupts */
+	ATA_FLAG_LEGACY		= (1 << 10), /* port is legacy */
 	ATA_FLAG_NCQ		= (1 << 11), /* host supports NCQ */
 
 	ATA_FLAG_DEBUGMSG	= (1 << 14),
@@ -301,6 +302,7 @@ struct ata_ioports {
 	unsigned long		ctl_addr;
 	unsigned long		bmdma_addr;
 	unsigned long		scr_addr;
+	long			irq;
 };
 
 struct ata_probe_ent {
@@ -310,12 +312,11 @@ struct ata_probe_ent {
 	struct scsi_host_template *sht;
 	struct ata_ioports	port[ATA_MAX_PORTS];
 	unsigned int		n_ports;
-	unsigned int		hard_port_no;
 	unsigned int		pio_mask;
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		legacy_mode;
-	unsigned long		irq;
+	long			irq;
 	unsigned int		irq_flags;
 	unsigned long		host_flags;
 	unsigned long		host_set_flags;
@@ -326,7 +327,7 @@ struct ata_probe_ent {
 struct ata_host_set {
 	spinlock_t		lock;
 	struct device 		*dev;
-	unsigned long		irq;
+	long			irq;
 	void __iomem		*mmio_base;
 	unsigned int		n_ports;
 	void			*private_data;
--- upstream0/drivers/scsi/libata-core.c	2006-05-25 10:45:21.000000000 +0800
+++ 1_legacy_irq/drivers/scsi/libata-core.c	2006-05-26 09:19:40.000000000 +0800
@@ -4776,11 +4776,36 @@ irqreturn_t ata_interrupt (int irq, void
 	/* TODO: make _irqsave conditional on x86 PCI IDE legacy mode */
 	spin_lock_irqsave(&host_set->lock, flags);
 
+	if (irq != host_set->irq) {
+		/* per-port irq */
+		for (i = 0; i < host_set->n_ports; i++) {
+			struct ata_port *ap = host_set->ports[i];
+
+			if (ap && (ap->flags & ATA_FLAG_LEGACY) &&
+			    (ap->ioaddr.irq == irq) &&
+			    !(ap->flags & ATA_FLAG_DISABLED)) {
+				struct ata_queued_cmd *qc;
+
+				qc = ata_qc_from_tag(ap, ap->active_tag);
+				if (qc &&
+				    (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
+				    (qc->flags & ATA_QCFLAG_ACTIVE))
+					handled |= ata_host_intr(ap, qc);
+				break;
+			}
+		}
+
+		spin_unlock_irqrestore(&host_set->lock, flags);
+
+		return IRQ_RETVAL(handled);
+	}
+
+	/* shared irq */
 	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap;
 
 		ap = host_set->ports[i];
-		if (ap &&
+		if (ap && !(ap->flags & ATA_FLAG_LEGACY) &&
 		    !(ap->flags & ATA_FLAG_DISABLED)) {
 			struct ata_queued_cmd *qc;
 
@@ -5148,8 +5173,7 @@ static void ata_host_init(struct ata_por
 	ap->host_set = host_set;
 	ap->dev = ent->dev;
 	ap->port_no = port_no;
-	ap->hard_port_no =
-		ent->legacy_mode ? ent->hard_port_no : port_no;
+	ap->hard_port_no = port_no;
 	ap->pio_mask = ent->pio_mask;
 	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
@@ -5282,6 +5306,7 @@ int ata_device_add(const struct ata_prob
 	for (i = 0; i < ent->n_ports; i++) {
 		struct ata_port *ap;
 		unsigned long xfer_mode_mask;
+		unsigned long irq;
 
 		ap = ata_host_add(ent, host_set, i);
 		if (!ap)
@@ -5292,6 +5317,12 @@ int ata_device_add(const struct ata_prob
 				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
 				(ap->pio_mask << ATA_SHIFT_PIO);
 
+		if (ent->legacy_mode) {
+			irq = ap->ioaddr.irq;
+			ap->flags |= ATA_FLAG_LEGACY;
+		} else
+			irq = ent->irq;
+
 		/* print per-port info to dmesg */
 		ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%lX "
 				"ctl 0x%lX bmdma 0x%lX irq %lu\n",
@@ -5300,21 +5331,28 @@ int ata_device_add(const struct ata_prob
 				ap->ioaddr.cmd_addr,
 				ap->ioaddr.ctl_addr,
 				ap->ioaddr.bmdma_addr,
-				ent->irq);
+				irq);
 
 		ata_chk_status(ap);
 		host_set->ops->irq_clear(ap);
 		ata_eh_freeze_port(ap);	/* freeze port before requesting IRQ */
+
+		if (ap->flags & ATA_FLAG_LEGACY)
+			/* obtain legacy per-port irq */
+			if (request_irq(irq, ent->port_ops->irq_handler, 0,
+				DRV_NAME, host_set))
+				goto err_out;
 		count++;
 	}
 
 	if (!count)
 		goto err_free_ret;
 
-	/* obtain irq, that is shared between channels */
-	if (request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
-			DRV_NAME, host_set))
-		goto err_out;
+	if (!ent->legacy_mode)
+		/* obtain irq, that is shared between channels */
+		if (request_irq(ent->irq, ent->port_ops->irq_handler,
+				ent->irq_flags, DRV_NAME, host_set))
+			goto err_out;
 
 	/* perform each probe synchronously */
 	DPRINTK("probe begin\n");
@@ -5387,31 +5425,35 @@ void ata_host_set_remove(struct ata_host
 {
 	struct ata_port *ap;
 	unsigned int i;
+	int native = 0;
 
 	for (i = 0; i < host_set->n_ports; i++) {
 		ap = host_set->ports[i];
 		scsi_remove_host(ap->host);
 	}
 
-	free_irq(host_set->irq, host_set);
-
 	for (i = 0; i < host_set->n_ports; i++) {
 		ap = host_set->ports[i];
 
 		ata_scsi_release(ap->host);
 
-		if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
+		if (ap->flags & ATA_FLAG_LEGACY) {
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
+			free_irq(ioaddr->irq, host_set);
+		} else
+			native++;
 
 		scsi_host_put(ap->host);
 	}
 
+	if (native)
+		free_irq(host_set->irq, host_set);
+
 	if (host_set->ops->host_stop)
 		host_set->ops->host_stop(host_set);
 
--- upstream0/drivers/scsi/libata-bmdma.c	2006-05-25 10:45:21.000000000 +0800
+++ 1_legacy_irq/drivers/scsi/libata-bmdma.c	2006-05-26 09:19:40.000000000 +0800
@@ -879,7 +879,7 @@ ata_pci_init_native_mode(struct pci_dev 
 		if (bmdma) {
 			bmdma += 8;
 			if(inb(bmdma + 2) & 0x80)
-			probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
 			probe_ent->port[p].bmdma_addr = bmdma;
 		}
 		ata_std_ports(&probe_ent->port[p]);
@@ -891,46 +891,67 @@ ata_pci_init_native_mode(struct pci_dev 
 }
 
 
-static struct ata_probe_ent *ata_pci_init_legacy_port(struct pci_dev *pdev,
-				struct ata_port_info *port, int port_num)
+/**
+ *	ata_pci_init_legacy_mode - Initialize legacy-mode driver
+ *	@pdev:  pci device to be initialized
+ *	@port:  array[2] of pointers to port info structures.
+ *	@ports: bitmap of ports present
+ *
+ *	Utility function which allocates and initializes an
+ *	ata_probe_ent structure for a standard dual-port
+ *	PIO-based IDE controller.  The returned ata_probe_ent
+ *	structure can be passed to ata_device_add().  The returned
+ *	ata_probe_ent structure should then be freed with kfree().
+ */
+static struct ata_probe_ent *ata_pci_init_legacy_mode(struct pci_dev *pdev,
+				struct ata_port_info **port, int ports)
 {
-	struct ata_probe_ent *probe_ent;
+	struct ata_probe_ent *probe_ent =
+		ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
+	int p = 0;
 	unsigned long bmdma;
 
-	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port);
 	if (!probe_ent)
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
+	probe_ent->irq = -1;
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
 
@@ -959,10 +980,10 @@ static struct ata_probe_ent *ata_pci_ini
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
 
@@ -1054,17 +1075,14 @@ int ata_pci_init_one (struct pci_dev *pd
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
@@ -1072,16 +1090,9 @@ int ata_pci_init_one (struct pci_dev *pd
 	pci_set_master(pdev);
 
 	/* FIXME: check ata_device_add return */
-	if (legacy_mode) {
-		if (legacy_mode & (1 << 0))
-			ata_device_add(probe_ent);
-		if (legacy_mode & (1 << 1))
-			ata_device_add(probe_ent2);
-	} else
-		ata_device_add(probe_ent);
+	ata_device_add(probe_ent);
 
 	kfree(probe_ent);
-	kfree(probe_ent2);
 
 	return 0;
 


