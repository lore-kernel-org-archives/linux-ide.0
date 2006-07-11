From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: Rework legacy handling to remove much of the cruft
Date: Tue, 11 Jul 2006 11:59:51 +0100
Message-ID: <1152615591.18028.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34275 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750990AbWGKKmQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Jul 2006 06:42:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Kill host_set->next
Fix simplex support
Allow per platform setting of IDE legacy bases
Turn per device tuning on so that PATA timings are fully enabled

Some of this can be tidied further later on, in particular all the
legacy port gunge belongs as a PCI quirk/PCI header decode to understand
the special legacy IDE rules in the PCI spec.

Longer term Jeff also wants to move the request_irq/free_irq out of core
which will make this even cleaner.


Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/scsi/libata-bmdma.c          |  134 ++++++++++++++++------------------
 drivers/scsi/libata-core.c           |   88 ++++++++++++----------
 include/asm-alpha/libata-portmap.h   |    1 
 include/asm-generic/libata-portmap.h |   12 +++
 include/asm-i386/libata-portmap.h    |    1 
 include/asm-x86_64/libata-portmap.h  |    1 
 include/linux/libata.h               |    5 +
 7 files changed, 128 insertions(+), 114 deletions(-)
 create mode 100644 include/asm-alpha/libata-portmap.h
 create mode 100644 include/asm-generic/libata-portmap.h
 create mode 100644 include/asm-i386/libata-portmap.h
 create mode 100644 include/asm-x86_64/libata-portmap.h

2bea3ab0ecb144b66173c79c06974fbe74d87630
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 9ce221f..34343e5 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -880,7 +880,7 @@ ata_pci_init_native_mode(struct pci_dev 
 		if (bmdma) {
 			bmdma += 8;
 			if(inb(bmdma + 2) & 0x80)
-			probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
 			probe_ent->port[p].bmdma_addr = bmdma;
 		}
 		ata_std_ports(&probe_ent->port[p]);
@@ -893,45 +893,55 @@ ata_pci_init_native_mode(struct pci_dev 
 
 
 static struct ata_probe_ent *ata_pci_init_legacy_port(struct pci_dev *pdev,
-				struct ata_port_info *port, int port_num)
+				struct ata_port_info **port, int port_mask)
 {
 	struct ata_probe_ent *probe_ent;
-	unsigned long bmdma;
+	unsigned long bmdma = pci_resource_start(pdev, 4);
+
+	int port_num = 0;
 
-	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port);
+	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
 	if (!probe_ent)
 		return NULL;
 
 	probe_ent->legacy_mode = 1;
 	probe_ent->n_ports = 1;
-	probe_ent->hard_port_no = port_num;
-	probe_ent->private_data = port->private_data;
+	probe_ent->hard_port_no = 0;
+	probe_ent->private_data = port[0]->private_data;
 
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
+	if (port_mask & ATA_PORT_PRIMARY) {
+		probe_ent->irq = 14;
+		probe_ent->port[port_num].cmd_addr = ATA_PRIMARY_CMD;
+		probe_ent->port[port_num].altstatus_addr =
+		probe_ent->port[port_num].ctl_addr = ATA_PRIMARY_CTL;
+		if (bmdma) {
+			probe_ent->port[0].bmdma_addr = bmdma;
+			if (inb(bmdma + 2) & 0x80)
+				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+		}
+		ata_std_ports(&probe_ent->port[port_num]);
+		port_num ++;
 	}
-
-	bmdma = pci_resource_start(pdev, 4);
-	if (bmdma != 0) {
-		bmdma += 8 * port_num;
-		probe_ent->port[0].bmdma_addr = bmdma;
-		if (inb(bmdma + 2) & 0x80)
-			probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+	if (port_mask & ATA_PORT_SECONDARY) {
+		if (port_num == 1)
+			probe_ent->irq2 = 15;
+		else {
+			/* Secondary only. IRQ 15 only and "first" port is port 1 */
+			probe_ent->irq = 15;
+			probe_ent->hard_port_no = 1;
+		}
+		probe_ent->port[port_num].cmd_addr = ATA_SECONDARY_CMD;
+		probe_ent->port[port_num].altstatus_addr =
+		probe_ent->port[port_num].ctl_addr = ATA_SECONDARY_CTL;
+		port_num ++;
+		if (bmdma) {
+			probe_ent->port[port_num].bmdma_addr = bmdma + 8;
+			if (inb(bmdma + 10) & 0x80)
+				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+		}
+		ata_std_ports(&probe_ent->port[port_num]);
+		port_num ++;
 	}
-	ata_std_ports(&probe_ent->port[0]);
-
 	return probe_ent;
 }
 
@@ -950,6 +960,10 @@ static struct ata_probe_ent *ata_pci_ini
  *	regions, sets the dma mask, enables bus master mode, and calls
  *	ata_device_add()
  *
+ *	ASSUMPTION:
+ *	Nobody makes a single channel controller that appears solely as
+ *	the secondary legacy port on PCI.
+ *
  *	LOCKING:
  *	Inherited from PCI layer (may sleep).
  *
@@ -960,7 +974,7 @@ static struct ata_probe_ent *ata_pci_ini
 int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 		      unsigned int n_ports)
 {
-	struct ata_probe_ent *probe_ent = NULL, *probe_ent2 = NULL;
+	struct ata_probe_ent *probe_ent = NULL;
 	struct ata_port_info *port[2];
 	u8 tmp8, mask;
 	unsigned int legacy_mode = 0;
@@ -1009,35 +1023,34 @@ int ata_pci_init_one (struct pci_dev *pd
 		goto err_out;
 	}
 
-	/* FIXME: Should use platform specific mappers for legacy port ranges */
 	if (legacy_mode) {
-		if (!request_region(0x1f0, 8, "libata")) {
+		if (!request_region(ATA_PRIMARY_CMD, 8, "libata")) {
 			struct resource *conflict, res;
-			res.start = 0x1f0;
-			res.end = 0x1f0 + 8 - 1;
+			res.start = ATA_PRIMARY_CMD;
+			res.end = ATA_PRIMARY_CMD + 8 - 1;
 			conflict = ____request_resource(&ioport_resource, &res);
 			if (!strcmp(conflict->name, "libata"))
-				legacy_mode |= (1 << 0);
+				legacy_mode |= ATA_PORT_PRIMARY;
 			else {
 				disable_dev_on_err = 0;
-				printk(KERN_WARNING "ata: 0x1f0 IDE port busy\n");
+				printk(KERN_WARNING "ata: 0x%0X IDE port busy\n", ATA_PRIMARY_CMD);
 			}
 		} else
-			legacy_mode |= (1 << 0);
+			legacy_mode |= ATA_PORT_PRIMARY;
 
-		if (!request_region(0x170, 8, "libata")) {
+		if (!request_region(ATA_SECONDARY_CMD, 8, "libata")) {
 			struct resource *conflict, res;
-			res.start = 0x170;
-			res.end = 0x170 + 8 - 1;
+			res.start = ATA_SECONDARY_CMD;
+			res.end = ATA_SECONDARY_CMD + 8 - 1;
 			conflict = ____request_resource(&ioport_resource, &res);
 			if (!strcmp(conflict->name, "libata"))
-				legacy_mode |= (1 << 1);
+				legacy_mode |= ATA_PORT_SECONDARY;
 			else {
 				disable_dev_on_err = 0;
-				printk(KERN_WARNING "ata: 0x170 IDE port busy\n");
+				printk(KERN_WARNING "ata: 0x%X IDE port busy\n", ATA_SECONDARY_CMD);
 			}
 		} else
-			legacy_mode |= (1 << 1);
+			legacy_mode |= ATA_PORT_SECONDARY;
 	}
 
 	/* we have legacy mode, but all ports are unavailable */
@@ -1055,17 +1068,14 @@ int ata_pci_init_one (struct pci_dev *pd
 		goto err_out_regions;
 
 	if (legacy_mode) {
-		if (legacy_mode & (1 << 0))
-			probe_ent = ata_pci_init_legacy_port(pdev, port[0], 0);
-		if (legacy_mode & (1 << 1))
-			probe_ent2 = ata_pci_init_legacy_port(pdev, port[1], 1);
+		probe_ent = ata_pci_init_legacy_port(pdev, port, legacy_mode);
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
@@ -1073,35 +1083,17 @@ int ata_pci_init_one (struct pci_dev *pd
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
 
 err_out_regions:
-	if (legacy_mode & (1 << 0))
-		release_region(0x1f0, 8);
-	if (legacy_mode & (1 << 1))
-		release_region(0x170, 8);
+	if (legacy_mode & ATA_PORT_PRIMARY)
+		release_region(ATA_PRIMARY_CMD, 8);
+	if (legacy_mode & ATA_PORT_SECONDARY)
+		release_region(ATA_SECONDARY_CMD, 8);
 	pci_release_regions(pdev);
 err_out:
 	if (disable_dev_on_err)
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 386e5f2..7b711a6 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3052,8 +3052,8 @@ static void ata_dev_xfermask(struct ata_
 	struct ata_port *ap = dev->ap;
 	struct ata_host_set *hs = ap->host_set;
 	unsigned long xfer_mask;
-	int i;
 
+	/* Controller modes available */
 	xfer_mask = ata_pack_xfermask(ap->pio_mask,
 				      ap->mwdma_mask, ap->udma_mask);
 
@@ -3063,30 +3063,21 @@ static void ata_dev_xfermask(struct ata_
 	if (ap->cbl == ATA_CBL_PATA40)
 		xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
 
-	/* FIXME: Use port-wide xfermask for now */
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *d = &ap->device[i];
-
-		if (ata_dev_absent(d))
-			continue;
-
-		if (ata_dev_disabled(d)) {
-			/* to avoid violating device selection timing */
-			xfer_mask &= ata_pack_xfermask(d->pio_mask,
-						       UINT_MAX, UINT_MAX);
-			continue;
-		}
-
-		xfer_mask &= ata_pack_xfermask(d->pio_mask,
-					       d->mwdma_mask, d->udma_mask);
-		xfer_mask &= ata_id_xfermask(d->id);
-		if (ata_dma_blacklisted(d))
-			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
-	}
+	if (ata_dev_disabled(dev)) {
+		/* to avoid violating device selection timing */
+		xfer_mask &= ata_pack_xfermask(dev->pio_mask,
+					       UINT_MAX, UINT_MAX);
+		goto out;
+	}
+	xfer_mask &= ata_pack_xfermask(dev->pio_mask, 
+					dev->mwdma_mask, dev->udma_mask);
+	xfer_mask &= ata_id_xfermask(dev->id);
 
-	if (ata_dma_blacklisted(dev))
+	if (ata_dma_blacklisted(dev)) {
+		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
 		ata_dev_printk(dev, KERN_WARNING,
 			       "device is on DMA blacklist, disabling DMA\n");
+	}
 
 	if (hs->flags & ATA_HOST_SIMPLEX) {
 		if (hs->simplex_claimed)
@@ -3095,7 +3086,7 @@ static void ata_dev_xfermask(struct ata_
 
 	if (ap->ops->mode_filter)
 		xfer_mask = ap->ops->mode_filter(ap, dev, xfer_mask);
-
+out:
 	ata_unpack_xfermask(xfer_mask, &dev->pio_mask,
 			    &dev->mwdma_mask, &dev->udma_mask);
 }
@@ -5273,6 +5264,7 @@ static void ata_host_init(struct ata_por
 	ap->host_set = host_set;
 	ap->dev = ent->dev;
 	ap->port_no = port_no;
+
 	ap->hard_port_no =
 		ent->legacy_mode ? ent->hard_port_no : port_no;
 	ap->pio_mask = ent->pio_mask;
@@ -5408,6 +5400,7 @@ int ata_device_add(const struct ata_prob
 	host_set->dev = dev;
 	host_set->n_ports = ent->n_ports;
 	host_set->irq = ent->irq;
+	host_set->irq2 = ent->irq2;
 	host_set->mmio_base = ent->mmio_base;
 	host_set->private_data = ent->private_data;
 	host_set->ops = ent->port_ops;
@@ -5417,16 +5410,23 @@ int ata_device_add(const struct ata_prob
 	for (i = 0; i < ent->n_ports; i++) {
 		struct ata_port *ap;
 		unsigned long xfer_mode_mask;
+		int irq_line = ent->irq;
+
 
 		ap = ata_host_add(ent, host_set, i);
 		if (!ap)
 			goto err_out;
 
+		/* Report the secondary IRQ for second channel legacy */
+		if (i == 1 && ent->irq2)
+			irq_line = ent->irq2;
+
 		host_set->ports[i] = ap;
 		xfer_mode_mask =(ap->udma_mask << ATA_SHIFT_UDMA) |
 				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
 				(ap->pio_mask << ATA_SHIFT_PIO);
 
+		/* FIXME: maybe print both IRQ lines ? */
 		/* print per-port info to dmesg */
 		ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%lX "
 				"ctl 0x%lX bmdma 0x%lX irq %lu\n",
@@ -5446,7 +5446,7 @@ int ata_device_add(const struct ata_prob
 	if (!count)
 		goto err_free_ret;
 
-	/* obtain irq, that is shared between channels */
+	/* obtain irq, that may be shared between channels */
 	rc = request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
 			 DRV_NAME, host_set);
 	if (rc) {
@@ -5455,6 +5455,21 @@ int ata_device_add(const struct ata_prob
 		goto err_out;
 	}
 
+	/* do we have a second IRQ for the other channel, eg legacy mode */
+	if (ent->irq2) {
+		/* We will get weird core code crashes later if this is true 
+		   so trap it now */
+		BUG_ON(ent->irq == ent->irq2);
+
+		rc = request_irq(ent->irq2, ent->port_ops->irq_handler, ent->irq_flags,
+			 DRV_NAME, host_set);
+		if (rc) {
+			dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
+				   ent->irq2, rc);
+			goto err_out;
+		}
+	}
+
 	/* perform each probe synchronously */
 	DPRINTK("probe begin\n");
 	for (i = 0; i < count; i++) {
@@ -5617,6 +5632,8 @@ void ata_host_set_remove(struct ata_host
 		ata_port_detach(host_set->ports[i]);
 
 	free_irq(host_set->irq, host_set);
+	if (host_set->irq2)
+		free_irq(host_set->irq2, host_set);
 
 	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
@@ -5626,10 +5643,11 @@ void ata_host_set_remove(struct ata_host
 		if ((ap->flags & ATA_FLAG_NO_LEGACY) == 0) {
 			struct ata_ioports *ioaddr = &ap->ioaddr;
 
-			if (ioaddr->cmd_addr == 0x1f0)
-				release_region(0x1f0, 8);
-			else if (ioaddr->cmd_addr == 0x170)
-				release_region(0x170, 8);
+			/* FIXME: Add -ac IDE pci mods to remove these special cases */
+			if (ioaddr->cmd_addr == ATA_PRIMARY_CMD)
+				release_region(ATA_PRIMARY_CMD, 8);
+			else if (ioaddr->cmd_addr == ATA_SECONDARY_CMD)
+				release_region(ATA_SECONDARY_CMD, 8);
 		}
 
 		scsi_host_put(ap->host);
@@ -5722,11 +5740,8 @@ void ata_pci_remove_one (struct pci_dev 
 {
 	struct device *dev = pci_dev_to_dev(pdev);
 	struct ata_host_set *host_set = dev_get_drvdata(dev);
-	struct ata_host_set *host_set2 = host_set->next;
 
 	ata_host_set_remove(host_set);
-	if (host_set2)
-		ata_host_set_remove(host_set2);
 
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
@@ -5794,14 +5809,6 @@ int ata_pci_device_suspend(struct pci_de
 	if (rc)
 		return rc;
 
-	if (host_set->next) {
-		rc = ata_host_set_suspend(host_set->next, state);
-		if (rc) {
-			ata_host_set_resume(host_set);
-			return rc;
-		}
-	}
-
 	ata_pci_device_do_suspend(pdev, state);
 
 	return 0;
@@ -5813,9 +5820,6 @@ int ata_pci_device_resume(struct pci_dev
 
 	ata_pci_device_do_resume(pdev);
 	ata_host_set_resume(host_set);
-	if (host_set->next)
-		ata_host_set_resume(host_set->next);
-
 	return 0;
 }
 #endif /* CONFIG_PCI */
diff --git a/include/asm-alpha/libata-portmap.h b/include/asm-alpha/libata-portmap.h
new file mode 100644
index 0000000..75484ef
--- /dev/null
+++ b/include/asm-alpha/libata-portmap.h
@@ -0,0 +1 @@
+#include <asm-generic/libata-portmap.h>
diff --git a/include/asm-generic/libata-portmap.h b/include/asm-generic/libata-portmap.h
new file mode 100644
index 0000000..9202fd0
--- /dev/null
+++ b/include/asm-generic/libata-portmap.h
@@ -0,0 +1,12 @@
+#ifndef __ASM_GENERIC_LIBATA_PORTMAP_H
+#define __ASM_GENERIC_LIBATA_PORTMAP_H
+
+#define ATA_PRIMARY_CMD		0x1F0
+#define ATA_PRIMARY_CTL		0x3F6
+#define ATA_PRIMARY_IRQ		14
+
+#define ATA_SECONDARY_CMD	0x170
+#define ATA_SECONDARY_CTL	0x376
+#define ATA_SECONDARY_IRQ	15
+
+#endif
diff --git a/include/asm-i386/libata-portmap.h b/include/asm-i386/libata-portmap.h
new file mode 100644
index 0000000..75484ef
--- /dev/null
+++ b/include/asm-i386/libata-portmap.h
@@ -0,0 +1 @@
+#include <asm-generic/libata-portmap.h>
diff --git a/include/asm-x86_64/libata-portmap.h b/include/asm-x86_64/libata-portmap.h
new file mode 100644
index 0000000..75484ef
--- /dev/null
+++ b/include/asm-x86_64/libata-portmap.h
@@ -0,0 +1 @@
+#include <asm-generic/libata-portmap.h>
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 307659e..012d3c5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -36,6 +36,8 @@
 #include <linux/workqueue.h>
 #include <scsi/scsi_host.h>
 
+#include <asm/libata-portmap.h>
+
 /*
  * compile-time options: to be removed as soon as all the drivers are
  * converted to the new debugging mechanism
@@ -354,6 +356,7 @@ struct ata_probe_ent {
 	unsigned int		udma_mask;
 	unsigned int		legacy_mode;
 	unsigned long		irq;
+	unsigned long		irq2;
 	unsigned int		irq_flags;
 	unsigned long		host_flags;
 	unsigned long		host_set_flags;
@@ -365,6 +368,7 @@ struct ata_host_set {
 	spinlock_t		lock;
 	struct device 		*dev;
 	unsigned long		irq;
+	unsigned long		irq2;
 	void __iomem		*mmio_base;
 	unsigned int		n_ports;
 	void			*private_data;
@@ -372,7 +376,6 @@ struct ata_host_set {
 	unsigned long		flags;
 	int			simplex_claimed;	/* Keep seperate in case we
 							   ever need to do this locked */
-	struct ata_host_set	*next;		/* for legacy mode */
 	struct ata_port		*ports[0];
 };
 
-- 
1.2.GIT


