From: Chris Dearman <chris@linux-mips.org>
Subject: [PATCH 1/1] sata_sil: Option to use IO space to access TF registers.
Date: Wed, 22 Oct 2008 11:24:27 -0700
Message-ID: <20081022182339.9471.45405.stgit@linux-chris2.mips.com>
References: <20081022182243.9471.87443.stgit@linux-chris2.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dns1.mips.com ([63.167.95.197]:43837 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbYJVSot (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 14:44:49 -0400
In-Reply-To: <20081022182243.9471.87443.stgit@linux-chris2.mips.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Provide an alternative way to access the TaskFile registers if mmio
doesn't work.

Signed-off-by: Chris Dearman <chris@linux-mips.org>
---

 drivers/ata/Kconfig    |   12 ++++++++++++
 drivers/ata/sata_sil.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index ae84949..28f7b5a 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -169,6 +169,18 @@ config SATA_SIL
 
 	  If unsure, say N.
 
+config SATA_SIL_IO
+	bool "Use IO space to access device registers"
+	depends on SATA_SIL
+	default n
+	help
+	  Some registers on this device require byte accesses. If your
+	  PCI controller promotes byte reads to word reads on the PCI bus
+	  enabling this option makes the driver use IO accesses for these
+	  registers,
+
+	  If unsure, say N.
+
 config SATA_SIS
 	tristate "SiS 964/965/966/180 SATA support"
 	depends on PCI
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 88bf421..94f4895 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -49,6 +49,12 @@
 #define DRV_VERSION	"2.3"
 
 enum {
+#ifdef CONFIG_SATA_SIL_IO
+	SIL_IO_IDE0TF_BAR	= 0,
+	SIL_IO_IDE0CTL_BAR	= 1,
+	SIL_IO_IDE1TF_BAR	= 2,
+	SIL_IO_IDE1CTL_BAR	= 3,
+#endif
 	SIL_MMIO_BAR		= 5,
 
 	/*
@@ -237,6 +243,19 @@ static const struct {
 	{ 0x2C0, 0x2CA, 0x208, 0x218, 0x244, 0x380, 0x3c8, 0x2f4, 0x3cc },
 	/* ... port 3 */
 };
+#ifdef CONFIG_SATA_SIL_IO
+static const struct {
+	unsigned int tfbar;	/* ATA taskfile BAR */
+	unsigned int tf;	/* ATA taskfile register block */
+	unsigned int ctlbar;	/* ATA control/altstatus BAR */
+	unsigned int ctl;	/* ATA control/altstatus register block */
+} sil_ioport[] = {
+	{ SIL_IO_IDE0TF_BAR, 0, SIL_IO_IDE0CTL_BAR, 2 },
+	{ SIL_IO_IDE1TF_BAR, 0, SIL_IO_IDE1CTL_BAR, 2 },
+	{ SIL_IO_IDE0TF_BAR, 0, SIL_IO_IDE0CTL_BAR, 2 },
+	{ SIL_IO_IDE1TF_BAR, 0, SIL_IO_IDE1CTL_BAR, 2 }
+};
+#endif
 
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("low-level driver for Silicon Image SATA controller");
@@ -630,7 +649,17 @@ static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
+#ifdef CONFIG_SATA_SIL_IO
+	rc = pcim_iomap_regions(pdev,
+				(1 << SIL_IO_IDE0TF_BAR) |
+				(1 << SIL_IO_IDE0CTL_BAR) |
+				(1 << SIL_IO_IDE1TF_BAR) |
+				(1 << SIL_IO_IDE1CTL_BAR) |
+				(1 << SIL_MMIO_BAR),
+				DRV_NAME);
+#else
 	rc = pcim_iomap_regions(pdev, 1 << SIL_MMIO_BAR, DRV_NAME);
+#endif
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
@@ -649,7 +678,20 @@ static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 		struct ata_ioports *ioaddr = &ap->ioaddr;
+#ifdef CONFIG_SATA_SIL_IO
+		void __iomem *tf_iobase = host->iomap[sil_ioport[i].tfbar];
+		void __iomem *ctl_iobase = host->iomap[sil_ioport[i].ctlbar];
+		ioaddr->cmd_addr = tf_iobase + sil_ioport[i].tf;
+		ioaddr->altstatus_addr =
+		ioaddr->ctl_addr = ctl_iobase + sil_ioport[i].ctl;
+		ioaddr->bmdma_addr = mmio_base + sil_port[i].bmdma;
+		ioaddr->scr_addr = mmio_base + sil_port[i].scr;
+		ata_sff_std_ports(ioaddr);
 
+		ata_port_pbar_desc(ap, SIL_MMIO_BAR, -1, "mmio");
+		ata_port_pbar_desc(ap, sil_ioport[i].tfbar, -1, "tf");
+		ata_port_pbar_desc(ap, sil_ioport[i].ctlbar, -1, "ctl");
+#else
 		ioaddr->cmd_addr = mmio_base + sil_port[i].tf;
 		ioaddr->altstatus_addr =
 		ioaddr->ctl_addr = mmio_base + sil_port[i].ctl;
@@ -659,6 +701,7 @@ static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 		ata_port_pbar_desc(ap, SIL_MMIO_BAR, -1, "mmio");
 		ata_port_pbar_desc(ap, SIL_MMIO_BAR, sil_port[i].tf, "tf");
+#endif
 	}
 
 	/* initialize and activate */

