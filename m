From: Bastiaan Jacques <b.jacques@planet.nl>
Subject: Re: [PATCH/RFC] ahci: add support for VIA VT8251
Date: Tue, 11 Apr 2006 22:10:29 +0200
Message-ID: <200604112210.29525.b.jacques@planet.nl>
References: <200604111915.45564.b.jacques@planet.nl>
 <20060411214118.12653818.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp13.wxs.nl ([195.121.247.4]:45522 "EHLO smtp13.wxs.nl")
	by vger.kernel.org with ESMTP id S1751364AbWDKUK3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 16:10:29 -0400
Received: from [192.168.2.10] (ip56538861.direct-adsl.nl [86.83.136.97])
 by smtp13.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0IXK000W9QPAAK@smtp13.wxs.nl> for linux-ide@vger.kernel.org;
 Tue, 11 Apr 2006 22:10:22 +0200 (CEST)
In-reply-to: <20060411214118.12653818.vsu@altlinux.ru>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: linux-ide@vger.kernel.org

On Tuesday 11 April 2006 19:41, Sergey Vlasov wrote:
> > @@ -565,7 +578,6 @@
> >  	/* check BUSY/DRQ, perform Command List Override if necessary */
> >  	ahci_tf_read(ap, &tf);
> >  	if (tf.command & (ATA_BUSY | ATA_DRQ)) {
> > -		u32 tmp;
>
> The following empty line should probably be deleted too.

Done.

> > +	{ PCI_VENDOR_ID_VIA, 0x3349, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > +	  board_ahci }, /* VT8251 */
>
> You can add a separate host type (e.g., board_via_vt8251_ahci), and then
> add an entry for this type to ahci_port_info[].  The entry would have a
> special flag in .host_flags, but the same .port_ops, so there will not
> be excessive duplication like in the original vendor patch.
>
> Look like other drivers which need workarounds for hardware bugs (e.g.,
> sata_sil) do this.

I noticed there already is a similar mechanism in ahci.c (see AHCI_FLAG_MSI). 
I decided to use that instead. Will that be acceptable?


--- drivers/scsi/ahci.c.orig	2006-04-11 18:58:32.000000000 +0200
+++ drivers/scsi/ahci.c	2006-04-11 22:05:37.000000000 +0200
@@ -152,7 +152,8 @@ enum {
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
 
 	/* hpriv->flags bits */
-	AHCI_FLAG_MSI		= (1 << 0),
+	AHCI_FLAG_MSI			= (1 << 0),
+	AHCI_FLAG_RESET_NEEDS_CLO 	= (1 << 1),
 };
 
 struct ahci_cmd_hdr {
@@ -297,6 +298,8 @@ static const struct pci_device_id ahci_p
 	  board_ahci }, /* ATI SB600 non-raid */
 	{ PCI_VENDOR_ID_ATI, 0x4381, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ATI SB600 raid */
+	{ PCI_VENDOR_ID_VIA, 0x3349, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* VT8251 */
 	{ }	/* terminate list */
 };
 
@@ -535,6 +538,17 @@ static int ahci_poll_register(void __iom
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
@@ -565,18 +579,13 @@ static int ahci_softreset(struct ata_por
 	/* check BUSY/DRQ, perform Command List Override if necessary */
 	ahci_tf_read(ap, &tf);
 	if (tf.command & (ATA_BUSY | ATA_DRQ)) {
-		u32 tmp;
-
 		if (!(hpriv->cap & HOST_CAP_CLO)) {
 			rc = -EIO;
 			reason = "port busy but no CLO";
 			goto fail_restart;
 		}
 
-		tmp = readl(port_mmio + PORT_CMD);
-		tmp |= PORT_CMD_CLO;
-		writel(tmp, port_mmio + PORT_CMD);
-		readl(port_mmio + PORT_CMD); /* flush */
+		ahci_clo(ap);
 
 		if (ahci_poll_register(port_mmio + PORT_CMD, PORT_CMD_CLO, 0x0,
 				       1, 500)) {
@@ -695,6 +704,15 @@ static void ahci_postreset(struct ata_po
 
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
@@ -1266,6 +1284,10 @@ static int ahci_init_one (struct pci_dev
 	if (pdev->vendor == 0x197b)
 		pci_write_config_byte(pdev, 0x41, 0xa1);
 
+	/* VIA VT8251-specific fixup: CLO before reset */
+	if (pdev->device == 0x3349)
+		hpriv->flags |= AHCI_FLAG_RESET_NEEDS_CLO;
+
 	/* initialize adapter */
 	rc = ahci_host_init(probe_ent);
 	if (rc)
