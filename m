From: Bastiaan Jacques <b.jacques@planet.nl>
Subject: [PATCH/RFC] ahci: add support for VIA VT8251
Date: Tue, 11 Apr 2006 19:15:45 +0200
Message-ID: <200604111915.45564.b.jacques@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp16.wxs.nl ([195.121.247.7]:24523 "EHLO smtp16.wxs.nl")
	by vger.kernel.org with ESMTP id S1751027AbWDKRPn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 13:15:43 -0400
Received: from savannah.pagefault.net
 (ip503cf321.speed.planet.nl [80.60.243.33])
 by smtp16.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0IXK00GOWIM4NU@smtp16.wxs.nl> for linux-ide@vger.kernel.org;
 Tue, 11 Apr 2006 19:15:40 +0200 (CEST)
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This patch adds AHCI support for the VIA VT8251 chipset. The patch does so by:
	1) Adding the PCI device ID.
	2) Adding a workaround in ahci_probe_reset() for a VIA hardware bug.

Signed-off-by: Bastiaan Jacques <b.jacques@planet.nl>
---

The patch is based upon the patch[1] provided by VIA. With the softreset and 
probing work that has been merged, this patch has become much simpler.

I am happy to report that without the workaround in ahci_probe_reset(), the 
chipset works quite well; both my SATA drives are recognised. However, 
softreset does not work (but hardreset does), and ata_std_probeinit delays, 
for my primary SATA drive/port,  due to the "busy" bug. A Command List 
Override will unbusy the drive/port.

Since the CLO sequence also appears in ahci_softreset(), I have moved that 
code into a new ahci_clo() function.

This patch is against 2.6.17-rc1 (and -mm2).

This patch has only been tested by yours truly. Whilst I am waiting for 
feedback from other people, I am sending this patch to solicit comments.

NOTE: My email client cuts off some lines (of context) in my patch because 
they are longer than 78 characters. Therefore, I am making the patch 
available from my web server [2], as well.

Bastiaan

[1] http://lkml.org/lkml/2005/12/11/204
[2] http://mirrors.pagefault.net/linux-via-ahci-latest.patch

--- drivers/scsi/ahci.c.orig	2006-04-11 18:58:32.000000000 +0200
+++ drivers/scsi/ahci.c	2006-04-11 12:44:41.000000000 +0200
@@ -297,6 +297,8 @@
 	  board_ahci }, /* ATI SB600 non-raid */
 	{ PCI_VENDOR_ID_ATI, 0x4381, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ATI SB600 raid */
+	{ PCI_VENDOR_ID_VIA, 0x3349, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* VT8251 */
 	{ }	/* terminate list */
 };

@@ -535,6 +537,17 @@
 	return -1;
 }

+static void ahci_clo(struct ata_port *ap)
+{
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
+	u32 tmp;
+
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp |= PORT_CMD_CLO;
+	writel(tmp, port_mmio + PORT_CMD);
+	readl(port_mmio + PORT_CMD); /* flush */
+}
+
 static int ahci_softreset(struct ata_port *ap, int verbose, unsigned int 
*class)
 {
 	struct ahci_host_priv *hpriv = ap->host_set->private_data;
@@ -565,7 +578,6 @@
 	/* check BUSY/DRQ, perform Command List Override if necessary */
 	ahci_tf_read(ap, &tf);
 	if (tf.command & (ATA_BUSY | ATA_DRQ)) {
-		u32 tmp;

 		if (!(hpriv->cap & HOST_CAP_CLO)) {
 			rc = -EIO;
@@ -573,10 +585,7 @@
 			goto fail_restart;
 		}

-		tmp = readl(port_mmio + PORT_CMD);
-		tmp |= PORT_CMD_CLO;
-		writel(tmp, port_mmio + PORT_CMD);
-		readl(port_mmio + PORT_CMD); /* flush */
+		ahci_clo(ap);

 		if (ahci_poll_register(port_mmio + PORT_CMD, PORT_CMD_CLO, 0x0,
 				       1, 500)) {
@@ -695,6 +704,16 @@

 static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes)
 {
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+
+	/* Workaround for VIA VT8251 "busy" bug */
+	if (pdev->device == 0x3349) {
+		if (ata_busy_wait(ap, ATA_BUSY, 1000) & ATA_BUSY) {
+			/* ATA_BUSY hasn't cleared, so send a CLO */
+			ahci_clo(ap);
+		}
+	}
+
 	return ata_drive_probe_reset(ap, ata_std_probeinit,
 				     ahci_softreset, ahci_hardreset,
 				     ahci_postreset, classes);
