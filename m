From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/9] libata: rework legacy handling to remove much of the cruft
Date: Thu, 10 Aug 2006 17:16:29 +0900
Message-ID: <11551977892698-git-send-email-htejun@gmail.com>
References: <11551977882917-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:11311 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751454AbWHJIQk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 04:16:40 -0400
Received: by py-out-1112.google.com with SMTP id z74so730388pyg
        for <linux-ide@vger.kernel.org>; Thu, 10 Aug 2006 01:16:39 -0700 (PDT)
In-Reply-To: <11551977882917-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>, Tejun Heo <htejun@gmail.com>

Kill host_set->next
Fix simplex support
Allow per platform setting of IDE legacy bases

Some of this can be tidied further later on, in particular all the
legacy port gunge belongs as a PCI quirk/PCI header decode to understand
the special legacy IDE rules in the PCI spec.

Longer term Jeff also wants to move the request_irq/free_irq out of core
which will make this even cleaner.

tj: folded in three followup patches - ata_piix-fix, broken-arch-fix
and fix-new-legacy-handling, and separated per-dev xfermask into
separate patch preceding this one.  Folded in fixes are...

* ata_piix-fix: fix build failure due to host_set->next removal
* broken-arch-fix: add missing include/asm-*/libata-portmap.h
* fix-new-legacy-handling:
	* In ata_pci_init_legacy_port(), probe_num was incorrectly
          incremented during initialization of the secondary port and
          probe_ent->n_ports was incorrectly fixed to 1.

	* Both legacy ports ended up having the same hard_port_no.

	* When printing port information, both legacy ports printed
	  the first irq.

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c              |    2 -
 drivers/scsi/libata-bmdma.c          |  135 ++++++++++++++++------------------
 drivers/scsi/libata-core.c           |   59 +++++++++------
 include/asm-alpha/libata-portmap.h   |    1 
 include/asm-generic/libata-portmap.h |   12 +++
 include/asm-i386/libata-portmap.h    |    1 
 include/asm-ia64/libata-portmap.h    |    1 
 include/asm-powerpc/libata-portmap.h |    1 
 include/asm-sparc/libata-portmap.h   |    1 
 include/asm-sparc64/libata-portmap.h |    1 
 include/asm-x86_64/libata-portmap.h  |    1 
 include/linux/libata.h               |    5 +
 12 files changed, 123 insertions(+), 97 deletions(-)
 create mode 100644 include/asm-alpha/libata-portmap.h
 create mode 100644 include/asm-generic/libata-portmap.h
 create mode 100644 include/asm-i386/libata-portmap.h
 create mode 100644 include/asm-ia64/libata-portmap.h
 create mode 100644 include/asm-powerpc/libata-portmap.h
 create mode 100644 include/asm-sparc/libata-portmap.h
 create mode 100644 include/asm-sparc64/libata-portmap.h
 create mode 100644 include/asm-x86_64/libata-portmap.h

2ec7df0457b710d9201f211dbccdbecf0ad38b7e
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 5e8afc8..40ecab5 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -932,8 +932,6 @@ static int piix_init_one (struct pci_dev
 
 static void piix_host_stop(struct ata_host_set *host_set)
 {
-	if (host_set->next == NULL)
-		kfree(host_set->private_data);
 	ata_host_stop(host_set);
 }
 
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 3268cf5..e694f60 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -854,7 +854,7 @@ ata_pci_init_native_mode(struct pci_dev 
 		if (bmdma) {
 			bmdma += 8;
 			if(inb(bmdma + 2) & 0x80)
-			probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
 			probe_ent->port[p].bmdma_addr = bmdma;
 		}
 		ata_std_ports(&probe_ent->port[p]);
@@ -867,44 +867,55 @@ ata_pci_init_native_mode(struct pci_dev 
 
 
 static struct ata_probe_ent *ata_pci_init_legacy_port(struct pci_dev *pdev,
-				struct ata_port_info *port, int port_num)
+				struct ata_port_info **port, int port_mask)
 {
 	struct ata_probe_ent *probe_ent;
-	unsigned long bmdma;
+	unsigned long bmdma = pci_resource_start(pdev, 4);
 
-	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port);
+	int port_num = 0;
+
+	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
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
+	probe_ent->hard_port_no = 0;
+	probe_ent->private_data = port[0]->private_data;
+
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
+	}
+	if (port_mask & ATA_PORT_SECONDARY) {
+		if (port_num == 1)
+			probe_ent->irq2 = 15;
+		else {
+			/* Secondary only. IRQ 15 only and "first" port is port 1 */
 			probe_ent->irq = 15;
-			probe_ent->port[0].cmd_addr = 0x170;
-			probe_ent->port[0].altstatus_addr =
-			probe_ent->port[0].ctl_addr = 0x376;
-			break;
+			probe_ent->hard_port_no = 1;
+		}
+		probe_ent->port[port_num].cmd_addr = ATA_SECONDARY_CMD;
+		probe_ent->port[port_num].altstatus_addr =
+		probe_ent->port[port_num].ctl_addr = ATA_SECONDARY_CTL;
+		if (bmdma) {
+			probe_ent->port[port_num].bmdma_addr = bmdma + 8;
+			if (inb(bmdma + 10) & 0x80)
+				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+		}
+		ata_std_ports(&probe_ent->port[port_num]);
+		port_num ++;
 	}
 
-	bmdma = pci_resource_start(pdev, 4);
-	if (bmdma != 0) {
-		bmdma += 8 * port_num;
-		probe_ent->port[0].bmdma_addr = bmdma;
-		if (inb(bmdma + 2) & 0x80)
-			probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
-	}
-	ata_std_ports(&probe_ent->port[0]);
+	probe_ent->n_ports = port_num;
 
 	return probe_ent;
 }
@@ -924,6 +935,10 @@ static struct ata_probe_ent *ata_pci_ini
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
@@ -934,7 +949,7 @@ static struct ata_probe_ent *ata_pci_ini
 int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 		      unsigned int n_ports)
 {
-	struct ata_probe_ent *probe_ent = NULL, *probe_ent2 = NULL;
+	struct ata_probe_ent *probe_ent = NULL;
 	struct ata_port_info *port[2];
 	u8 tmp8, mask;
 	unsigned int legacy_mode = 0;
@@ -983,35 +998,34 @@ int ata_pci_init_one (struct pci_dev *pd
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
@@ -1029,17 +1043,14 @@ int ata_pci_init_one (struct pci_dev *pd
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
@@ -1047,35 +1058,17 @@ int ata_pci_init_one (struct pci_dev *pd
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
index 4e6c2e8..3634279 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5223,8 +5223,9 @@ void ata_port_init(struct ata_port *ap, 
 	ap->host_set = host_set;
 	ap->dev = ent->dev;
 	ap->port_no = port_no;
-	ap->hard_port_no =
-		ent->legacy_mode ? ent->hard_port_no : port_no;
+	ap->hard_port_no = port_no;
+	if (ent->legacy_mode)
+		ap->hard_port_no += ent->hard_port_no;
 	ap->pio_mask = ent->pio_mask;
 	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
@@ -5400,6 +5401,7 @@ int ata_device_add(const struct ata_prob
 	ata_host_set_init(host_set, dev, ent->host_set_flags, ent->port_ops);
 	host_set->n_ports = ent->n_ports;
 	host_set->irq = ent->irq;
+	host_set->irq2 = ent->irq2;
 	host_set->mmio_base = ent->mmio_base;
 	host_set->private_data = ent->private_data;
 
@@ -5407,11 +5409,16 @@ int ata_device_add(const struct ata_prob
 	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap;
 		unsigned long xfer_mode_mask;
+		int irq_line = ent->irq;
 
 		ap = ata_port_add(ent, host_set, i);
 		if (!ap)
 			goto err_out;
 
+		/* Report the secondary IRQ for second channel legacy */
+		if (i == 1 && ent->irq2)
+			irq_line = ent->irq2;
+
 		host_set->ports[i] = ap;
 		xfer_mode_mask =(ap->udma_mask << ATA_SHIFT_UDMA) |
 				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
@@ -5419,20 +5426,20 @@ int ata_device_add(const struct ata_prob
 
 		/* print per-port info to dmesg */
 		ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%lX "
-				"ctl 0x%lX bmdma 0x%lX irq %lu\n",
+				"ctl 0x%lX bmdma 0x%lX irq %d\n",
 				ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
 				ata_mode_string(xfer_mode_mask),
 				ap->ioaddr.cmd_addr,
 				ap->ioaddr.ctl_addr,
 				ap->ioaddr.bmdma_addr,
-				ent->irq);
+				irq_line);
 
 		ata_chk_status(ap);
 		host_set->ops->irq_clear(ap);
 		ata_eh_freeze_port(ap);	/* freeze port before requesting IRQ */
 	}
 
-	/* obtain irq, that is shared between channels */
+	/* obtain irq, that may be shared between channels */
 	rc = request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
 			 DRV_NAME, host_set);
 	if (rc) {
@@ -5441,6 +5448,21 @@ int ata_device_add(const struct ata_prob
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
+			goto err_out_free_irq;
+		}
+	}
+
 	/* perform each probe synchronously */
 	DPRINTK("probe begin\n");
 	for (i = 0; i < host_set->n_ports; i++) {
@@ -5514,6 +5536,8 @@ int ata_device_add(const struct ata_prob
 	VPRINTK("EXIT, returning %u\n", ent->n_ports);
 	return ent->n_ports; /* success */
 
+err_out_free_irq:
+	free_irq(ent->irq, host_set);
 err_out:
 	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
@@ -5605,6 +5629,8 @@ void ata_host_set_remove(struct ata_host
 		ata_port_detach(host_set->ports[i]);
 
 	free_irq(host_set->irq, host_set);
+	if (host_set->irq2)
+		free_irq(host_set->irq2, host_set);
 
 	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap = host_set->ports[i];
@@ -5614,10 +5640,11 @@ void ata_host_set_remove(struct ata_host
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
@@ -5735,11 +5762,8 @@ void ata_pci_remove_one (struct pci_dev 
 {
 	struct device *dev = pci_dev_to_dev(pdev);
 	struct ata_host_set *host_set = dev_get_drvdata(dev);
-	struct ata_host_set *host_set2 = host_set->next;
 
 	ata_host_set_remove(host_set);
-	if (host_set2)
-		ata_host_set_remove(host_set2);
 
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
@@ -5807,14 +5831,6 @@ int ata_pci_device_suspend(struct pci_de
 	if (rc)
 		return rc;
 
-	if (host_set->next) {
-		rc = ata_host_set_suspend(host_set->next, mesg);
-		if (rc) {
-			ata_host_set_resume(host_set);
-			return rc;
-		}
-	}
-
 	ata_pci_device_do_suspend(pdev, mesg);
 
 	return 0;
@@ -5826,9 +5842,6 @@ int ata_pci_device_resume(struct pci_dev
 
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
diff --git a/include/asm-ia64/libata-portmap.h b/include/asm-ia64/libata-portmap.h
new file mode 100644
index 0000000..75484ef
--- /dev/null
+++ b/include/asm-ia64/libata-portmap.h
@@ -0,0 +1 @@
+#include <asm-generic/libata-portmap.h>
diff --git a/include/asm-powerpc/libata-portmap.h b/include/asm-powerpc/libata-portmap.h
new file mode 100644
index 0000000..75484ef
--- /dev/null
+++ b/include/asm-powerpc/libata-portmap.h
@@ -0,0 +1 @@
+#include <asm-generic/libata-portmap.h>
diff --git a/include/asm-sparc/libata-portmap.h b/include/asm-sparc/libata-portmap.h
new file mode 100644
index 0000000..75484ef
--- /dev/null
+++ b/include/asm-sparc/libata-portmap.h
@@ -0,0 +1 @@
+#include <asm-generic/libata-portmap.h>
diff --git a/include/asm-sparc64/libata-portmap.h b/include/asm-sparc64/libata-portmap.h
new file mode 100644
index 0000000..75484ef
--- /dev/null
+++ b/include/asm-sparc64/libata-portmap.h
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
index cf5eb1d..4504776 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -36,6 +36,8 @@ #include <linux/ata.h>
 #include <linux/workqueue.h>
 #include <scsi/scsi_host.h>
 
+#include <asm/libata-portmap.h>
+
 /*
  * compile-time options: to be removed as soon as all the drivers are
  * converted to the new debugging mechanism
@@ -356,6 +358,7 @@ struct ata_probe_ent {
 	unsigned int		udma_mask;
 	unsigned int		legacy_mode;
 	unsigned long		irq;
+	unsigned long		irq2;
 	unsigned int		irq_flags;
 	unsigned long		host_flags;
 	unsigned long		host_set_flags;
@@ -367,6 +370,7 @@ struct ata_host_set {
 	spinlock_t		lock;
 	struct device 		*dev;
 	unsigned long		irq;
+	unsigned long		irq2;
 	void __iomem		*mmio_base;
 	unsigned int		n_ports;
 	void			*private_data;
@@ -374,7 +378,6 @@ struct ata_host_set {
 	unsigned long		flags;
 	int			simplex_claimed;	/* Keep seperate in case we
 							   ever need to do this locked */
-	struct ata_host_set	*next;		/* for legacy mode */
 	struct ata_port		*ports[0];
 };
 
-- 
1.3.2


