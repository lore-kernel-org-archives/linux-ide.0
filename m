From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.4.x libata updates
Date: Wed, 27 Apr 2005 16:55:13 -0400
Message-ID: <20050427205513.GA26542@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:42383 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S262009AbVD0Uzg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Apr 2005 16:55:36 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ide@vger.kernel.org


I'm hoping you haven't erased BitKeeper just yet...  here is what I have
pending for you, for 2.4.x.  My next submission to you, presumably, will
be using git.

Please do a

	bk pull bk://kernel.bkbits.net/jgarzik/libata-upstream-2.4

This will update the following files:

 drivers/scsi/ahci.c        |   17 +++++++++++++----
 drivers/scsi/libata-scsi.c |    7 ++++++-
 drivers/scsi/sata_sil.c    |   32 +++++++++++++++++++++++++++++++-
 drivers/scsi/sata_svw.c    |    2 +-
 4 files changed, 51 insertions(+), 7 deletions(-)

through these ChangeSets:

<eike-kernel@sf-tec.de> (05/03/30 1.1448.129.7)
   [PATCH] typo fix in drivers/scsi/sata_svw.c comment
   
   Add missing brace.
   
   Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

<jgarzik@pobox.com> (05/03/29 1.1448.129.6)
   [libata sata_sil] Don't presume PCI cache-line-size reg is > 0
   
   Some BIOSen are known to screw up the PCI cache-line-size register,
   so add a paranoia check.

<Carlos.Pardo@siliconimage.com> (05/03/24 1.1448.129.5)
   [PATCH] sata_sil: Fix FIFO PCI Bus Arbitration
   
   This patch set default values for the FIFO PCI Bus Arbitration to avoid
   data corruption. The root cause is due to our PCI bus master handling
   mismatch with the chipset PCI bridge during DMA xfer (write data to the
   device). The patch is to setup the DMA fifo threshold so that there is
   no chance for the DMA engine to change protocol. We have seen this
   problem only on one motherboard.
   
   Signed-off-by: Silicon Image Corporation <cpardo@siliconimage.com>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

<russb@emc.com> (05/03/22 1.1448.129.4)
   [PATCH] libata: support descriptor sense in ctrl page
   
   libata must support the descriptor format sense blocks as they
   are required to properly report results of ATA pass through
   commands as well as other SCSI commands reporting 48b LBAs.
   This patch adjusts the control mode page to properly report
   this.
   
   Signed-off-by: Brett Russ <russb@emc.com>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

<jason.d.gaston@intel.com> (05/03/22 1.1448.129.3)
   [PATCH] SATA AHCI correction Intel ICH7R
   
   This patch removes an invalid DID for Intel ICH7R from the ahci.c
   SATA AHCI driver.
   
   Signed-off-by: Jason Gaston <Jason.d.gaston@intel.com>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

<jgarzik@pobox.com> (05/03/10 1.1448.129.2)
   [libata ahci] support ->tf_read hook

<russb@emc.com> (05/03/10 1.1448.128.2)
   [PATCH] AHCI: fix fatal error int handling
   
   I noticed that the AHCI CI (cmd issue) reg wasn't getting cleared
   after error ints resulting in no further commands being successfully
   issued to the port.  This patch fixes.  All that's really needed is
   the 1's complement but I also removed the disabling/enabling of the
   FIS_RX b/c this isn't spec'd as necessary when handling error ints.
   
   Signed-off-by: Brett Russ <russb@emc.com>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c	2005-04-27 16:53:06 -04:00
+++ b/drivers/scsi/ahci.c	2005-04-27 16:53:06 -04:00
@@ -176,6 +176,7 @@
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
 static void ahci_host_stop(struct ata_host_set *host_set);
+static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
 static u8 ahci_check_err(struct ata_port *ap);
@@ -209,6 +210,8 @@
 	.check_err		= ahci_check_err,
 	.dev_select		= ata_noop_dev_select,
 
+	.tf_read		= ahci_tf_read,
+
 	.phy_reset		= ahci_phy_reset,
 
 	.qc_prep		= ahci_qc_prep,
@@ -249,8 +252,6 @@
 	  board_ahci }, /* ICH7 */
 	{ PCI_VENDOR_ID_INTEL, 0x27c5, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ICH7M */
-	{ PCI_VENDOR_ID_INTEL, 0x27c2, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_ahci }, /* ICH7R */
 	{ PCI_VENDOR_ID_INTEL, 0x27c3, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ICH7R */
 	{ PCI_VENDOR_ID_AL, 0x5288, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
@@ -462,6 +463,14 @@
 	return (readl(mmio + PORT_TFDATA) >> 8) & 0xFF;
 }
 
+static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
+
+	ata_tf_from_fis(d2h_fis, tf);
+}
+
 static void ahci_fill_sg(struct ata_queued_cmd *qc)
 {
 	struct ahci_port_priv *pp = qc->ap->private_data;
@@ -538,7 +547,7 @@
 
 	/* stop DMA */
 	tmp = readl(port_mmio + PORT_CMD);
-	tmp &= PORT_CMD_START | PORT_CMD_FIS_RX;
+	tmp &= ~PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 
 	/* wait for engine to stop.  TODO: this could be
@@ -570,7 +579,7 @@
 
 	/* re-start DMA */
 	tmp = readl(port_mmio + PORT_CMD);
-	tmp |= PORT_CMD_START | PORT_CMD_FIS_RX;
+	tmp |= PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
 
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2005-04-27 16:53:06 -04:00
+++ b/drivers/scsi/libata-scsi.c	2005-04-27 16:53:06 -04:00
@@ -1000,7 +1000,12 @@
 
 static unsigned int ata_msense_ctl_mode(u8 **ptr_io, const u8 *last)
 {
-	const u8 page[] = {0xa, 0xa, 2, 0, 0, 0, 0, 0, 0xff, 0xff, 0, 30};
+	const u8 page[] = {0xa, 0xa, 6, 0, 0, 0, 0, 0, 0xff, 0xff, 0, 30};
+
+	/* byte 2: set the descriptor format sense data bit (bit 2)
+	 * since we need to support returning this format for SAT
+	 * commands and any SCSI commands against a 48b LBA device.
+	 */
 
 	ata_msense_push(ptr_io, last, page, sizeof(page));
 	return sizeof(page);
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2005-04-27 16:53:06 -04:00
+++ b/drivers/scsi/sata_sil.c	2005-04-27 16:53:06 -04:00
@@ -38,12 +38,21 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_sil"
-#define DRV_VERSION	"0.8"
+#define DRV_VERSION	"0.9"
 
 enum {
 	sil_3112		= 0,
 	sil_3114		= 1,
 
+	SIL_FIFO_R0		= 0x40,
+	SIL_FIFO_W0		= 0x41,
+	SIL_FIFO_R1		= 0x44,
+	SIL_FIFO_W1		= 0x45,
+	SIL_FIFO_R2		= 0x240,
+	SIL_FIFO_W2		= 0x241,
+	SIL_FIFO_R3		= 0x244,
+	SIL_FIFO_W3		= 0x245,
+
 	SIL_SYSCFG		= 0x48,
 	SIL_MASK_IDE0_INT	= (1 << 22),
 	SIL_MASK_IDE1_INT	= (1 << 23),
@@ -199,6 +208,13 @@
 MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
+static unsigned char sil_get_device_cache_line(struct pci_dev *pdev)
+{
+	u8 cache_line = 0;
+	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cache_line);
+	return cache_line;
+}
+
 static void sil_post_set_mode (struct ata_port *ap)
 {
 	struct ata_host_set *host_set = ap->host_set;
@@ -341,6 +357,7 @@
 	unsigned int i;
 	int pci_dev_busy = 0;
 	u32 tmp, irq_mask;
+	u8 cls;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
@@ -401,6 +418,19 @@
 		probe_ent->port[i].scr_addr = base + sil_port[i].scr;
 		ata_std_ports(&probe_ent->port[i]);
 	}
+
+	/* Initialize FIFO PCI bus arbitration */
+	cls = sil_get_device_cache_line(pdev);
+	if (cls) {
+		cls >>= 3;
+		cls++;  /* cls = (line_size/8)+1 */
+		writeb(cls, mmio_base + SIL_FIFO_R0);
+		writeb(cls, mmio_base + SIL_FIFO_W0);
+		writeb(cls, mmio_base + SIL_FIFO_R1);
+		writeb(cls, mmio_base + SIL_FIFO_W2);
+	} else
+		printk(KERN_WARNING DRV_NAME "(%s): cache line size not set.  Driver may not function\n",
+			pci_name(pdev));
 
 	if (ent->driver_data == sil_3114) {
 		irq_mask = SIL_MASK_4PORT;
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2005-04-27 16:53:06 -04:00
+++ b/drivers/scsi/sata_svw.c	2005-04-27 16:53:06 -04:00
@@ -392,7 +392,7 @@
 
 	/* Clear a magic bit in SCR1 according to Darwin, those help
 	 * some funky seagate drives (though so far, those were already
-	 * set by the firmware on the machines I had access to
+	 * set by the firmware on the machines I had access to)
 	 */
 	writel(readl(mmio_base + K2_SATA_SICR1_OFFSET) & ~0x00040000,
 	       mmio_base + K2_SATA_SICR1_OFFSET);
