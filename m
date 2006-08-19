From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 7/20] libata: implement PCI ATA init helpers
Date: Sat, 19 Aug 2006 17:59:31 +0900
Message-ID: <11559779711637-git-send-email-htejun@gmail.com>
References: <11559778241753-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:33797 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751657AbWHSI76 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Aug 2006 04:59:58 -0400
Received: by py-out-1112.google.com with SMTP id d42so1453994pyd
        for <linux-ide@vger.kernel.org>; Sat, 19 Aug 2006 01:59:57 -0700 (PDT)
In-Reply-To: <11559778241753-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement the following PCI ATA init helpers

* ata_pci_legacy_mask()		: obtain legacy mask from PCI header
* ata_pci_set_dma_mask()	: PCI DMA mask set helper
* ata_pci_acquire_resources()	: acquire generic PCI resources
* ata_pci_release_resources()	: release generic PCI resources
* ata_pci_init_ports()		: init native PCI ATA port addresses
* ata_pci_request_irq()		: request ATA PCI IRQ with MSI/INTX handling
* ata_pci_free_irq()		: free ATA PCI IRQ
* ata_pci_request_msix_irqs()	: request ATA PCI MSIX IRQs
* ata_pci_free_msix_irqs()	: free ATA PCI MSIX IRQs
* ata_pci_host_destroy()	: PCI ATA host self-destruct

Legacy handling isn't yet integrated.

These helpers will be used in new LLD init model.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/Kconfig      |   26 +--
 drivers/ata/Makefile     |    4 
 drivers/ata/libata-pci.c |  442 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h   |   35 ++++
 4 files changed, 491 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 1a98559..38a3f79 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -20,9 +20,16 @@ config ATA_LEGACY
 	depends on ATA
 	default n
 
+config ATA_PCI
+	bool
+	depends on ATA && PCI
+	default y
+	select ATA_LEGACY
+
+if ATA_PCI
+
 config SATA_AHCI
 	tristate "AHCI SATA support"
-	depends on ATA && PCI
 	help
 	  This option enables support for AHCI Serial ATA.
 
@@ -30,7 +37,6 @@ config SATA_AHCI
 
 config SATA_SVW
 	tristate "ServerWorks Frodo / Apple K2 SATA support"
-	depends on ATA && PCI
 	help
 	  This option enables support for Broadcom/Serverworks/Apple K2
 	  SATA support.
@@ -39,7 +45,6 @@ config SATA_SVW
 
 config ATA_PIIX
 	tristate "Intel PIIX/ICH SATA support"
-	depends on ATA && PCI
 	help
 	  This option enables support for ICH5/6/7/8 Serial ATA.
 	  If PATA support was enabled previously, this enables
@@ -49,7 +54,6 @@ config ATA_PIIX
 
 config SATA_MV
 	tristate "Marvell SATA support (HIGHLY EXPERIMENTAL)"
-	depends on ATA && PCI && EXPERIMENTAL
 	help
 	  This option enables support for the Marvell Serial ATA family.
 	  Currently supports 88SX[56]0[48][01] chips.
@@ -58,7 +62,6 @@ config SATA_MV
 
 config SATA_NV
 	tristate "NVIDIA SATA support"
-	depends on ATA && PCI
 	help
 	  This option enables support for NVIDIA Serial ATA.
 
@@ -66,7 +69,6 @@ config SATA_NV
 
 config PDC_ADMA
 	tristate "Pacific Digital ADMA support"
-	depends on ATA && PCI
 	help
 	  This option enables support for Pacific Digital ADMA controllers
 
@@ -74,7 +76,6 @@ config PDC_ADMA
 
 config SATA_QSTOR
 	tristate "Pacific Digital SATA QStor support"
-	depends on ATA && PCI
 	help
 	  This option enables support for Pacific Digital Serial ATA QStor.
 
@@ -82,7 +83,6 @@ config SATA_QSTOR
 
 config SATA_PROMISE
 	tristate "Promise SATA TX2/TX4 support"
-	depends on ATA && PCI
 	help
 	  This option enables support for Promise Serial ATA TX2/TX4.
 
@@ -90,7 +90,6 @@ config SATA_PROMISE
 
 config SATA_SX4
 	tristate "Promise SATA SX4 support"
-	depends on ATA && PCI && EXPERIMENTAL
 	help
 	  This option enables support for Promise Serial ATA SX4.
 
@@ -98,7 +97,6 @@ config SATA_SX4
 
 config SATA_SIL
 	tristate "Silicon Image SATA support"
-	depends on ATA && PCI
 	help
 	  This option enables support for Silicon Image Serial ATA.
 
@@ -106,7 +104,6 @@ config SATA_SIL
 
 config SATA_SIL24
 	tristate "Silicon Image 3124/3132 SATA support"
-	depends on ATA && PCI
 	help
 	  This option enables support for Silicon Image 3124/3132 Serial ATA.
 
@@ -114,7 +111,6 @@ config SATA_SIL24
 
 config SATA_SIS
 	tristate "SiS 964/180 SATA support"
-	depends on ATA && PCI
 	help
 	  This option enables support for SiS Serial ATA 964/180.
 
@@ -122,7 +118,6 @@ config SATA_SIS
 
 config SATA_ULI
 	tristate "ULi Electronics SATA support"
-	depends on ATA && PCI
 	help
 	  This option enables support for ULi Electronics SATA.
 
@@ -130,7 +125,6 @@ config SATA_ULI
 
 config SATA_VIA
 	tristate "VIA SATA support"
-	depends on ATA && PCI
 	help
 	  This option enables support for VIA Serial ATA.
 
@@ -138,7 +132,6 @@ config SATA_VIA
 
 config SATA_VITESSE
 	tristate "VITESSE VSC-7174 / INTEL 31244 SATA support"
-	depends on ATA && PCI
 	help
 	  This option enables support for Vitesse VSC7174 and Intel 31244 Serial ATA.
 
@@ -149,5 +142,6 @@ config SATA_INTEL_COMBINED
 	depends on IDE=y && !BLK_DEV_IDE_SATA && (SATA_AHCI || ATA_PIIX)
 	default y
 
-endmenu
+endif
 
+endmenu
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 61d3e76..72ce589 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -22,3 +22,7 @@ libata-objs	:= libata-core.o libata-scsi
 ifeq ($(CONFIG_ATA_LEGACY),y)
 libata-objs	+= libata-legacy.o
 endif
+
+ifeq ($(CONFIG_ATA_PCI),y)
+libata-objs	+= libata-pci.o
+endif
diff --git a/drivers/ata/libata-pci.c b/drivers/ata/libata-pci.c
new file mode 100644
index 0000000..d1e4194
--- /dev/null
+++ b/drivers/ata/libata-pci.c
@@ -0,0 +1,442 @@
+/*
+ *  libata-pci.c - helper library for PCI ATA
+ *
+ *  Maintained by:  Jeff Garzik <jgarzik@pobox.com>
+ *    		    Please ALWAYS copy linux-ide@vger.kernel.org
+ *		    on emails.
+ *
+ *  Copyright 2006 Tejun Heo <htejun@gmail.com>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License as
+ *  published by the Free Software Foundation; either version 2, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,
+ *  USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
+ *  Hardware documentation available from http://www.t13.org/ and
+ *  http://www.sata-io.org/
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/libata.h>
+
+#include "libata.h"
+
+/**
+ *	ata_pci_legacy_mask - obatin legacy mask from PCI IDE device
+ *	@pdev: target PCI device
+ *
+ *	Obtain legacy mask from @pdev.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Obtained legacy mask.
+ */
+unsigned int ata_pci_legacy_mask(struct pci_dev *pdev)
+{
+	unsigned int mask = 0;
+	u8 tmp8;
+
+	if (pdev->class >> 8 != PCI_CLASS_STORAGE_IDE)
+		return 0;
+
+	pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
+
+	if (!(tmp8 & (1 << 0)))
+		mask |= ATA_PORT_PRIMARY;
+
+	if (!(tmp8 & (1 << 2)))
+		mask |= ATA_PORT_SECONDARY;
+
+	return mask;
+}
+
+/**
+ *	ata_pci_set_dma_mask - PCI DMA mask set helper
+ *	@pdev: target PCI device
+ *	@dma_mask: DMA mask
+ *	@p_reason: out arg for error message (can be NULL)
+ *
+ *	Helper to set PCI DMA mask.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_pci_set_dma_mask(struct pci_dev *pdev, u64 dma_mask,
+			 const char **p_reason)
+{
+	const char *reason;
+	int rc = 0;
+
+	if (dma_mask == DMA_64BIT_MASK) {
+		if (pci_set_dma_mask(pdev, DMA_64BIT_MASK) == 0) {
+			rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
+			if (rc) {
+				rc = pci_set_consistent_dma_mask(pdev,
+							DMA_32BIT_MASK);
+				if (rc) {
+					reason = "64-bit DMA enable failed";
+					goto err;
+				}
+			}
+		} else {
+			rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
+			if (rc) {
+				reason = "32-bit DMA enable failed";
+				goto err;
+			}
+			rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
+			if (rc) {
+				reason = "32-bit consistent DMA enable failed";
+				goto err;
+			}
+		}
+	} else if (dma_mask) {
+		reason = "failed to set DMA mask";
+		rc = pci_set_dma_mask(pdev, dma_mask);
+		if (rc)
+			goto err;
+		rc = pci_set_consistent_dma_mask(pdev, dma_mask);
+		if (rc)
+			goto err;
+	}
+
+	return 0;
+
+ err:
+	if (p_reason)
+		*p_reason = reason;
+	return rc;
+}
+
+/**
+ *	ata_pci_acquire_resources - acquire default PCI resources
+ *	@host: target ATA host to acquire PCI resources for
+ *	@dma_mask: DMA mask
+ *	@p_reason: out arg for error message (can be NULL)
+ *
+ *	Acquire default ATA PCI resources.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_pci_acquire_resources(struct ata_host *host, u64 dma_mask,
+			      const char **p_reason)
+{
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+	const char *reason;
+	int rc;
+
+	/* acquire generic resources */
+
+	/* FIXME: Really for ATA it isn't safe because the device may
+	 * be multi-purpose and we want to leave it alone if it was
+	 * already enabled. Secondly for shared use as Arjan says we
+	 * want refcounting
+	 *
+	 * Checking dev->is_enabled is insufficient as this is not set
+	 * at boot for the primary video which is BIOS enabled
+         */
+	rc = pci_enable_device(pdev);
+	if (rc) {
+		reason = "failed to enable PCI device";
+		goto err;
+	}
+
+	rc = pci_request_regions(pdev, DRV_NAME);
+	if (rc) {
+		host->flags |= ATA_HOST_DEV_BUSY;
+		reason = "failed to request PCI regions";
+		goto err;
+	}
+
+	host->pci_flags |= ATA_PCI_RES_GEN;
+
+	/* set DMA mask */
+	/* FIXME: If we get no DMA mask we should fall back to PIO */
+	rc = ata_pci_set_dma_mask(pdev, dma_mask, &reason);
+	if (rc)
+		goto err;
+
+	return 0;
+
+ err:
+	ata_pci_release_resources(host);
+	if (p_reason)
+		*p_reason = reason;
+	return rc;
+}
+
+/**
+ *	ata_pci_release_resources - release default PCI resources
+ *	@host: target ATA host to release PCI resources for
+ *
+ *	Release default ATA PCI resources.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+void ata_pci_release_resources(struct ata_host *host)
+{
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+
+	if (host->pci_flags & ATA_PCI_RES_GEN) {
+		pci_release_regions(pdev);
+
+		if (!(host->flags & ATA_HOST_DEV_BUSY))
+			pci_disable_device(pdev);
+
+		host->pci_flags &= ~ATA_PCI_RES_GEN;
+	}
+}
+
+/**
+ *	ata_pci_init_ports - initialize PCI ATA port addresses
+ *	@host: target ATA host
+ *
+ *	Initialize native ATA port TF addresses and PCI BMDMA
+ *	addresses for both legacy and native ports.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer.
+ */
+void ata_pci_init_ports(struct ata_host *host)
+{
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+	int i;
+
+	/* initialize native TF and BMDMA */
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+		struct ata_ioports *ioaddr = &ap->ioaddr;
+		unsigned long cmd_addr, ctl_addr, bmdma_addr;
+
+		cmd_addr = pci_resource_start(pdev, ap->port_no * 2);
+		ctl_addr = pci_resource_start(pdev, ap->port_no * 2 + 1) |
+			ATA_PCI_CTL_OFS;
+		bmdma_addr = pci_resource_start(pdev, 4);
+
+		if (!((host->legacy_flags & ATA_LEGACY_MASK) & (1 << i))) {
+			ioaddr->cmd_addr = cmd_addr;
+			ioaddr->altstatus_addr = ctl_addr;
+			ioaddr->ctl_addr = ctl_addr;
+			ata_std_ports(ioaddr);
+		}
+
+		if (bmdma_addr) {
+			bmdma_addr += ap->port_no * 8;
+			if (inb(bmdma_addr + 2) & 0x80)
+				host->flags |= ATA_HOST_SIMPLEX;
+			ioaddr->bmdma_addr = bmdma_addr;
+		}
+	}
+}
+
+/**
+ *	ata_pci_request_irq - request PCI IRQ for ATA host
+ *	@host: target ATA host
+ *	@handler: IRQ handler
+ *	@irq_flags: IRQ flags
+ *	@dev_id: IRQ dev_id
+ *	@p_reason: output arg for error message (can be NULL)
+ *
+ *	Request PCI IRQ for @host.  This function also handles MSI and
+ *	INTX settings.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_pci_request_irq(struct ata_host *host,
+			irqreturn_t (*handler)(int, void *, struct pt_regs *),
+			unsigned int irq_flags, void *dev_id,
+			const char **p_reason)
+{
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+
+	if (host->pci_flags & ATA_PCI_MSI)
+		if (pci_enable_msi(pdev) == 0)
+			host->pci_flags |= ATA_PCI_RES_MSI;
+
+	if (host->pci_flags & ATA_PCI_INTX) {
+		if (host->pci_flags & ATA_PCI_RES_MSI) {
+			pci_intx(pdev, 0);
+			host->pci_flags |= ATA_PCI_RES_INTX;
+		} else
+			pci_intx(pdev, 1);
+	}
+
+	return ata_host_request_irq_marker(host, pdev->irq, handler, irq_flags,
+					   dev_id, ata_pci_request_irq,
+					   p_reason);
+}
+
+/**
+ *	ata_pci_free_irq - free PCI IRQ for ATA host
+ *	@host: target ATA host
+ *
+ *	Free PCI IRQ for @host and restore MSI and INTX settings.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+void ata_pci_free_irq(struct ata_host *host)
+{
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+
+	ata_host_free_irqs_marker(host, ata_pci_request_irq);
+
+	/* leave INTX set for other MSI/INTX incapable driver */
+	if (host->pci_flags & ATA_PCI_RES_INTX) {
+		pci_intx(pdev, 1);
+		host->pci_flags &= ~ATA_PCI_RES_INTX;
+	}
+
+	if (host->pci_flags & ATA_PCI_RES_MSI) {
+		pci_disable_msi(pdev);
+		host->pci_flags &= ~ATA_PCI_RES_MSI;
+	}
+}
+
+/**
+ *	ata_pci_request_msix_irqs - request PCI MSIX IRQs for ATA host
+ *	@host: target ATA host
+ *	@ata_msix_tbl: table of ATA IRQ requests (in/out arg)
+ *	@nr_irqs: number of IRQs to request, length of @ata_msix_tbl
+ *	@p_reason: output arg for error message (can be NULL)
+ *
+ *	Request PCI MSIX IRQs for @host.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_pci_request_msix_irqs(struct ata_host *host,
+			      struct ata_msix_entry *ata_msix_tbl, int nr_irqs,
+			      const char **p_reason)
+{
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+	struct msix_entry *msix_tbl = NULL;
+	const char *reason;
+	int i, rc;
+
+	msix_tbl = kzalloc(sizeof(msix_tbl[0]) * nr_irqs, GFP_KERNEL);
+	for (i = 0; i < nr_irqs; i++)
+		msix_tbl[i].entry = ata_msix_tbl[i].entry;
+
+	rc = pci_enable_msix(pdev, msix_tbl, nr_irqs);
+	if (rc) {
+		reason = "failed to enable MSIX";
+		goto err;
+	}
+
+	pci_intx(pdev, 0);
+
+	host->pci_flags |= ATA_PCI_RES_MSIX;
+
+	for (i = 0; i < nr_irqs; i++) {
+		struct ata_msix_entry *ent = &ata_msix_tbl[i];
+
+		ent->vector = msix_tbl[i].vector;
+
+		rc = ata_host_request_irq_marker(host, ent->vector,
+					ent->handler, ent->flags, ent->dev_id,
+					ata_pci_request_msix_irqs, p_reason);
+		if (rc)
+			goto err;
+	}
+
+	kfree(msix_tbl);
+	return 0;
+
+ err:
+	ata_pci_free_msix_irqs(host);
+	kfree(msix_tbl);
+	if (p_reason)
+		*p_reason = reason;
+	return rc;
+}
+
+/**
+ *	ata_pci_free_msix_irqs - free PCI MSIX IRQs for ATA host
+ *	@host: target ATA host
+ *
+ *	Free all PCI MSIX IRQs for @host.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+void ata_pci_free_msix_irqs(struct ata_host *host)
+{
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+
+	ata_host_free_irqs_marker(host, ata_pci_request_msix_irqs);
+
+	if (host->pci_flags & ATA_PCI_RES_MSIX) {
+		pci_disable_msix(pdev);
+		pci_intx(pdev, 1);
+		host->pci_flags &= ~ATA_PCI_RES_MSIX;
+	}
+}
+
+/**
+ *	ata_pci_host_destroy - destroy PCI ATA host
+ *	@host: target ATA host
+ *
+ *	Release all IRQs and resources @host is holding and free
+ *	@host.
+ *
+ *	LOCKING:
+ *	Inherited from calling layer (may sleep).
+ */
+void ata_pci_host_destroy(struct ata_host *host)
+{
+	/* free IRQs */
+	ata_pci_free_msix_irqs(host);
+	ata_pci_free_irq(host);
+
+	/* stop host */
+	ata_host_stop(host);
+
+	/* release resources */
+	ata_pci_release_resources(host);
+	ata_host_free(host);
+}
+
+EXPORT_SYMBOL_GPL(ata_pci_legacy_mask);
+EXPORT_SYMBOL_GPL(ata_pci_set_dma_mask);
+EXPORT_SYMBOL_GPL(ata_pci_acquire_resources);
+EXPORT_SYMBOL_GPL(ata_pci_release_resources);
+EXPORT_SYMBOL_GPL(ata_pci_init_ports);
+EXPORT_SYMBOL_GPL(ata_pci_request_irq);
+EXPORT_SYMBOL_GPL(ata_pci_free_irq);
+EXPORT_SYMBOL_GPL(ata_pci_request_msix_irqs);
+EXPORT_SYMBOL_GPL(ata_pci_free_msix_irqs);
+EXPORT_SYMBOL_GPL(ata_pci_host_destroy);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9535f54..f25fc53 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -210,6 +210,15 @@ enum {
 	ATA_LEGACY_RES_PRI	= (1 << 8),
 	ATA_LEGACY_RES_SEC	= (1 << 9),
 
+	/* PCI flags */
+	ATA_PCI_INTX		= (1 << 0), /* do INTX */
+	ATA_PCI_MSI		= (1 << 1), /* PCI IRQ via MSI */
+
+	ATA_PCI_RES_GEN		= (1 << 8), /* generic PCI resources */
+	ATA_PCI_RES_INTX	= (1 << 9), /* did INTX */
+	ATA_PCI_RES_MSI		= (1 << 10), /* is MSI */
+	ATA_PCI_RES_MSIX	= (1 << 11), /* is MSIX, INTX is implied */
+
 	/* various lengths of time */
 	ATA_TMOUT_BOOT		= 30 * HZ,	/* heuristic */
 	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* heuristic */
@@ -374,6 +383,14 @@ struct ata_probe_ent {
 	void			*private_data;
 };
 
+struct ata_msix_entry {
+	u16			entry;		/* in arg, msix table index */
+	u16			vector;		/* out arg, mapped vector */
+	irqreturn_t		(*handler)(int, void *, struct pt_regs *);
+	unsigned int		flags;
+	void			*dev_id;
+};
+
 struct ata_host {
 	spinlock_t		lock;
 	struct device 		*dev;
@@ -388,6 +405,7 @@ struct ata_host {
 	int			simplex_claimed;	/* Keep seperate in case we
 							   ever need to do this locked */
 	unsigned int		legacy_flags;
+	unsigned int		pci_flags;
 
 	struct list_head	irq_list;	/* list of acquired irqs */
 	struct ata_port		*ports[0];
@@ -694,6 +712,23 @@ extern int ata_dev_revalidate(struct ata
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
 #ifdef CONFIG_PCI
+extern unsigned int ata_pci_legacy_mask(struct pci_dev *pdev);
+extern int ata_pci_set_dma_mask(struct pci_dev *pdev, u64 dma_mask,
+				const char **p_reason);
+extern int ata_pci_acquire_resources(struct ata_host *host, u64 dma_mask,
+				     const char **p_reason);
+extern void ata_pci_release_resources(struct ata_host *host);
+extern void ata_pci_init_ports(struct ata_host *host);
+extern int ata_pci_request_irq(struct ata_host *host,
+			irqreturn_t (*handler)(int, void *, struct pt_regs *),
+			unsigned int irq_flags, void *dev_id,
+			const char **p_reason);
+extern void ata_pci_free_irq(struct ata_host *host);
+extern int ata_pci_request_msix_irqs(struct ata_host *host,
+			      struct ata_msix_entry *ata_msix_tbl, int nr_irqs,
+			      const char **p_reason);
+extern void ata_pci_free_msix_irqs(struct ata_host *host);
+extern void ata_pci_host_destroy(struct ata_host *host);
 extern int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 			     unsigned int n_ports);
 extern void ata_pci_remove_one (struct pci_dev *pdev);
-- 
1.4.1.1


