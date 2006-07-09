From: Daniel Drake <dsd@gentoo.org>
Subject: [2.6.17 backport] VIA VT8251 SATA support
Date: Mon, 10 Jul 2006 00:06:37 +0100
Message-ID: <44B18BFD.7000802@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090404090606090806030100"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:42214 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932465AbWGIXBO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Jul 2006 19:01:14 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com with ESMTP
          id <20060709230112.EZVY1865.mtaout03-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>
          for <linux-ide@vger.kernel.org>; Mon, 10 Jul 2006 00:01:12 +0100
Received: from [192.168.0.2] (really [86.14.216.162])
          by aamtaout01-winn.ispmail.ntl.com with ESMTP
          id <20060709230112.HQIH29849.aamtaout01-winn.ispmail.ntl.com@[192.168.0.2]>
          for <linux-ide@vger.kernel.org>; Mon, 10 Jul 2006 00:01:12 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090404090606090806030100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I added the PCI ID for the VT8251 IDE controller and since then I've 
been getting a continuous flow of emails from people who think I might 
have some clue about the SATA side. I don't even own the hardware, but I 
have backported the patch for inclusion in the Gentoo kernels now that 
it has been merged into the 2.6.18 tree. This patch is reported to work 
with 2.6.17.

NOTE: This is unsupported by me, and unsupported the Linux IDE/SATA 
developers too. The patch is slightly ugly because it includes a 
backport of the ata_wait_register() function so the end product is that 
we have some code using ata_wait_register() and some using whatever the 
predecessor was.

Hoping for fewer emails about this annoying hardware...
;)
Daniel

--------------090404090606090806030100
Content-Type: text/x-patch;
 name="4100_vt8251-sata.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="4100_vt8251-sata.patch"

From: Bastiaan Jacques <b.jacques@planet.nl>
Date: Mon, 17 Apr 2006 12:17:59 +0000 (+0200)
Subject: [PATCH] ahci: add support for VIA VT8251
X-Git-Tag: v2.6.17-rc3
X-Git-Url: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=bf2af2a2027e52b653882fbca840620e896ae081

[PATCH] ahci: add support for VIA VT8251

Adds AHCI support for the VIA VT8251.

Includes a workaround for a hardware bug which requires a Command List
Override before softreset.

Signed-off-by: Bastiaan Jacques <b.jacques@planet.nl>
Signed-off-by: Jeff Garzik <jeff@garzik.org>
---

Backported to 2.6.17 by Daniel Drake <dsd@gentoo.org>
Includes addition of ata_wait_register() function

Index: linux-2.6.17-gentoo-r1/drivers/scsi/ahci.c
===================================================================
--- linux-2.6.17-gentoo-r1.orig/drivers/scsi/ahci.c
+++ linux-2.6.17-gentoo-r1/drivers/scsi/ahci.c
@@ -73,6 +73,7 @@ enum {
 	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
 
 	board_ahci		= 0,
+	board_ahci_vt8251	= 1,
 
 	/* global controller registers */
 	HOST_CAP		= 0x00, /* host capabilities */
@@ -153,6 +154,9 @@ enum {
 
 	/* hpriv->flags bits */
 	AHCI_FLAG_MSI		= (1 << 0),
+
+	/* ap->flags bits */
+	AHCI_FLAG_RESET_NEEDS_CLO	= (1 << 24),
 };
 
 struct ahci_cmd_hdr {
@@ -255,6 +259,16 @@ static const struct ata_port_info ahci_p
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
 	},
+	/* board_ahci_vt8251 */
+	{
+		.sht		= &ahci_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
+				  AHCI_FLAG_RESET_NEEDS_CLO,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &ahci_ops,
+	},
 };
 
 static const struct pci_device_id ahci_pci_tbl[] = {
@@ -296,6 +310,8 @@ static const struct pci_device_id ahci_p
 	  board_ahci }, /* ATI SB600 non-raid */
 	{ PCI_VENDOR_ID_ATI, 0x4381, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ATI SB600 raid */
+	{ PCI_VENDOR_ID_VIA, 0x3349, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci_vt8251 }, /* VIA VT8251 */
 	{ }	/* terminate list */
 };
 
@@ -534,9 +550,29 @@ static int ahci_poll_register(void __iom
 	return -1;
 }
 
-static int ahci_softreset(struct ata_port *ap, int verbose, unsigned int *class)
+static int ahci_clo(struct ata_port *ap)
 {
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
 	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+	u32 tmp;
+
+	if (!(hpriv->cap & HOST_CAP_CLO))
+		return -EOPNOTSUPP;
+
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp |= PORT_CMD_CLO;
+	writel(tmp, port_mmio + PORT_CMD);
+
+	tmp = ata_wait_register(port_mmio + PORT_CMD,
+				PORT_CMD_CLO, PORT_CMD_CLO, 1, 500);
+	if (tmp & PORT_CMD_CLO)
+		return -EIO;
+
+	return 0;
+}
+
+static int ahci_softreset(struct ata_port *ap, int verbose, unsigned int *class)
+{
 	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *mmio = ap->host_set->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
@@ -558,23 +594,13 @@ static int ahci_softreset(struct ata_por
 	/* check BUSY/DRQ, perform Command List Override if necessary */
 	ahci_tf_read(ap, &tf);
 	if (tf.command & (ATA_BUSY | ATA_DRQ)) {
-		u32 tmp;
+		rc = ahci_clo(ap);
 
-		if (!(hpriv->cap & HOST_CAP_CLO)) {
-			rc = -EIO;
-			reason = "port busy but no CLO";
+		if (rc == -EOPNOTSUPP) {
+			reason = "port busy but CLO unavailable";
 			goto fail_restart;
-		}
-
-		tmp = readl(port_mmio + PORT_CMD);
-		tmp |= PORT_CMD_CLO;
-		writel(tmp, port_mmio + PORT_CMD);
-		readl(port_mmio + PORT_CMD); /* flush */
-
-		if (ahci_poll_register(port_mmio + PORT_CMD, PORT_CMD_CLO, 0x0,
-				       1, 500)) {
-			rc = -EIO;
-			reason = "CLO failed";
+		} else if (rc) {
+			reason = "port busy but CLO failed";
 			goto fail_restart;
 		}
 	}
@@ -688,6 +714,12 @@ static void ahci_postreset(struct ata_po
 
 static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes)
 {
+	if ((ap->flags & AHCI_FLAG_RESET_NEEDS_CLO) &&
+	    (ata_busy_wait(ap, ATA_BUSY, 1000) & ATA_BUSY)) {
+		/* ATA_BUSY hasn't cleared, so send a CLO */
+		ahci_clo(ap);
+	}
+
 	return ata_drive_probe_reset(ap, ata_std_probeinit,
 				     ahci_softreset, ahci_hardreset,
 				     ahci_postreset, classes);
Index: linux-2.6.17-gentoo-r1/drivers/scsi/libata-core.c
===================================================================
--- linux-2.6.17-gentoo-r1.orig/drivers/scsi/libata-core.c
+++ linux-2.6.17-gentoo-r1/drivers/scsi/libata-core.c
@@ -4895,6 +4895,52 @@ int ata_ratelimit(void)
 	return rc;
 }
 
+/**
+ *	ata_wait_register - wait until register value changes
+ *	@reg: IO-mapped register
+ *	@mask: Mask to apply to read register value
+ *	@val: Wait condition
+ *	@interval_msec: polling interval in milliseconds
+ *	@timeout_msec: timeout in milliseconds
+ *
+ *	Waiting for some bits of register to change is a common
+ *	operation for ATA controllers.  This function reads 32bit LE
+ *	IO-mapped register @reg and tests for the following condition.
+ *
+ *	(*@reg & mask) != val
+ *
+ *	If the condition is met, it returns; otherwise, the process is
+ *	repeated after @interval_msec until timeout.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	The final register value.
+ */
+u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
+		      unsigned long interval_msec,
+		      unsigned long timeout_msec)
+{
+	unsigned long timeout;
+	u32 tmp;
+
+	tmp = ioread32(reg);
+
+	/* Calculate timeout _after_ the first read to make sure
+	 * preceding writes reach the controller before starting to
+	 * eat away the timeout.
+	 */
+	timeout = jiffies + (timeout_msec * HZ) / 1000;
+
+	while ((tmp & mask) == val && time_before(jiffies, timeout)) {
+		msleep(interval_msec);
+		tmp = ioread32(reg);
+	}
+
+	return tmp;
+}
+
 /*
  * libata is essentially a library of internal helper functions for
  * low-level ATA host controller drivers.  As such, the API/ABI is
@@ -4946,6 +4992,7 @@ EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_pair);
 EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_ratelimit);
+EXPORT_SYMBOL_GPL(ata_wait_register);
 EXPORT_SYMBOL_GPL(ata_busy_sleep);
 EXPORT_SYMBOL_GPL(ata_port_queue_task);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
Index: linux-2.6.17-gentoo-r1/include/linux/libata.h
===================================================================
--- linux-2.6.17-gentoo-r1.orig/include/linux/libata.h
+++ linux-2.6.17-gentoo-r1/include/linux/libata.h
@@ -537,6 +537,9 @@ extern unsigned int ata_busy_sleep(struc
 				   unsigned long timeout);
 extern void ata_port_queue_task(struct ata_port *ap, void (*fn)(void *),
 				void *data, unsigned long delay);
+extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
+			     unsigned long interval_msec,
+			     unsigned long timeout_msec);
 
 /*
  * Default driver ops implementations

--------------090404090606090806030100--
