From: Bastiaan Jacques <b.jacques@planet.nl>
Subject: Re: [PATCH/RFC] ahci: add support for VIA VT8251
Date: Wed, 12 Apr 2006 21:10:51 +0200
Message-ID: <200604122110.51723.b.jacques@planet.nl>
References: <200604111915.45564.b.jacques@planet.nl>
 <20060412004232.GA31115@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from psmtp04.wxs.nl ([195.121.247.13]:44424 "EHLO psmtp04.wxs.nl")
	by vger.kernel.org with ESMTP id S1751068AbWDLTKo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Apr 2006 15:10:44 -0400
Received: from [192.168.2.10] (ip56538861.direct-adsl.nl [86.83.136.97])
 by psmtp04.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.07 (built Jun 24 2005))
 with ESMTP id <0IXM00GWQILTXY@psmtp04.wxs.nl> for linux-ide@vger.kernel.org;
 Wed, 12 Apr 2006 21:10:41 +0200 (MEST)
In-reply-to: <20060412004232.GA31115@htj.dyndns.org>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Wednesday 12 April 2006 02:42, Tejun Heo wrote:
> Can you please make ahci_clo() check for HOST_CAP_CLO and return
> -EOPNOTSUPP (or whatever) if it's not supported?

Sure. I've also moved the ahci_poll_register() call into ahci_clo().

Jeff: when everybody is happy with my patch, I'll resubmit it to this list in
accordance with the guidelines you linked to (if that's okay with you).


--- drivers/scsi/ahci.c.orig	2006-04-11 18:58:32.000000000 +0200
+++ drivers/scsi/ahci.c	2006-04-12 20:53:23.000000000 +0200
@@ -152,7 +152,8 @@
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
 
 	/* hpriv->flags bits */
-	AHCI_FLAG_MSI		= (1 << 0),
+	AHCI_FLAG_MSI			= (1 << 0),
+	AHCI_FLAG_RESET_NEEDS_CLO 	= (1 << 1),
 };
 
 struct ahci_cmd_hdr {
@@ -297,6 +298,8 @@
 	  board_ahci }, /* ATI SB600 non-raid */
 	{ PCI_VENDOR_ID_ATI, 0x4381, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ATI SB600 raid */
+	{ PCI_VENDOR_ID_VIA, 0x3349, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* VT8251 */
 	{ }	/* terminate list */
 };
 
@@ -535,9 +538,28 @@
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
+	readl(port_mmio + PORT_CMD); /* flush */
+
+	if (ahci_poll_register(port_mmio + PORT_CMD, PORT_CMD_CLO, 0x0, 1, 500))
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
@@ -565,23 +587,12 @@
 	/* check BUSY/DRQ, perform Command List Override if necessary */
 	ahci_tf_read(ap, &tf);
 	if (tf.command & (ATA_BUSY | ATA_DRQ)) {
-		u32 tmp;
+		if ((rc = ahci_clo(ap))) {
+			if (rc & -EOPNOTSUPP)
+				reason = "port busy but CLO unavailable";
+			else
+				reason = "port busy but CLO failed";
 
-		if (!(hpriv->cap & HOST_CAP_CLO)) {
-			rc = -EIO;
-			reason = "port busy but no CLO";
-			goto fail_restart;
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
 			goto fail_restart;
 		}
 	}
@@ -695,6 +706,15 @@
 
 static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes)
 {
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+
+	if (hpriv->flags & AHCI_FLAG_RESET_NEEDS_CLO) {
+		if (ata_busy_wait(ap, ATA_BUSY, 1000) & ATA_BUSY) {
+			/* ATA_BUSY hasn't cleared, so send a CLO */
+			ahci_clo(ap);
+		}
+	}
+
 	return ata_drive_probe_reset(ap, ata_std_probeinit,
 				     ahci_softreset, ahci_hardreset,
 				     ahci_postreset, classes);
@@ -1266,6 +1286,10 @@
 	if (pdev->vendor == 0x197b)
 		pci_write_config_byte(pdev, 0x41, 0xa1);
 
+	/* VIA VT8251-specific fixup: CLO before reset */
+	if (pdev->device == 0x3349)
+		hpriv->flags |= AHCI_FLAG_RESET_NEEDS_CLO;
+
 	/* initialize adapter */
 	rc = ahci_host_init(probe_ent);
 	if (rc)
