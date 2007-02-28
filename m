From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA Problem: port is slow to respond
Date: Wed, 28 Feb 2007 15:02:50 +0900
Message-ID: <45E51B0A.5040605@gmail.com>
References: <200702161050.51523.sigmund.lkml@synflood.homelinux.org> <45E4436B.9090102@gmail.com> <45E4A217.7090909@synflood.homelinux.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020909070609070202090308"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:19756 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbXB1GCw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Feb 2007 01:02:52 -0500
Received: by nz-out-0506.google.com with SMTP id s1so47362nze
        for <linux-ide@vger.kernel.org>; Tue, 27 Feb 2007 22:02:51 -0800 (PST)
In-Reply-To: <45E4A217.7090909@synflood.homelinux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sigmund Scheinbar <sigmund.lkml@synflood.homelinux.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020909070609070202090308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Please apply the attached patch over 2.6.20.1 and report how it works.

Thanks.

-- 
tejun

--------------020909070609070202090308
Content-Type: text/x-patch;
 name="sb600-ign-serr-internal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb600-ign-serr-internal.patch"

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6d93240..2d7d97d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -80,6 +80,7 @@ enum {
 	board_ahci_pi		= 1,
 	board_ahci_vt8251	= 2,
 	board_ahci_ign_iferr	= 3,
+	board_ahci_ign_interr	= 4,
 
 	/* global controller registers */
 	HOST_CAP		= 0x00, /* host capabilities */
@@ -168,6 +169,7 @@ enum {
 	AHCI_FLAG_NO_NCQ		= (1 << 24),
 	AHCI_FLAG_IGN_IRQ_IF_ERR	= (1 << 25), /* ignore IRQ_IF_ERR */
 	AHCI_FLAG_HONOR_PI		= (1 << 26), /* honor PORTS_IMPL */
+	AHCI_FLAG_IGN_SERR_INTERNAL	= (1 << 27), /* ignore SERR_INTERNAL */
 };
 
 struct ahci_cmd_hdr {
@@ -353,6 +355,17 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
 	},
+	/* board_ahci_ign_interr */
+	{
+		.sht		= &ahci_sht,
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
+				  ATA_FLAG_SKIP_D2H_BSY |
+				  AHCI_FLAG_IGN_SERR_INTERNAL,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &ahci_ops,
+	},
 };
 
 static const struct pci_device_id ahci_pci_tbl[] = {
@@ -392,8 +405,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(JMICRON, 0x2366), board_ahci_ign_iferr }, /* JMB366 */
 
 	/* ATI */
-	{ PCI_VDEVICE(ATI, 0x4380), board_ahci }, /* ATI SB600 non-raid */
-	{ PCI_VDEVICE(ATI, 0x4381), board_ahci }, /* ATI SB600 raid */
+	{ PCI_VDEVICE(ATI, 0x4380), board_ahci_ign_interr }, /* SB600 non-raid */
+	{ PCI_VDEVICE(ATI, 0x4381), board_ahci_ign_interr }, /* SB600 raid */
 
 	/* VIA */
 	{ PCI_VDEVICE(VIA, 0x3349), board_ahci_vt8251 }, /* VIA VT8251 */
@@ -454,9 +467,10 @@ static inline void __iomem *ahci_port_base(void __iomem *base,
 	return base + 0x100 + (port * 0x80);
 }
 
-static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
+static u32 ahci_scr_read(struct ata_port *ap, unsigned int sc_reg_in)
 {
 	unsigned int sc_reg;
+	u32 serr;
 
 	switch (sc_reg_in) {
 	case SCR_STATUS:	sc_reg = 0; break;
@@ -467,12 +481,13 @@ static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
 		return 0xffffffffU;
 	}
 
-	return readl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	serr = readl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	if (ap->flags & AHCI_FLAG_IGN_SERR_INTERNAL)
+		serr &= ~SERR_INTERNAL;
+	return serr;
 }
 
-
-static void ahci_scr_write (struct ata_port *ap, unsigned int sc_reg_in,
-			       u32 val)
+static void ahci_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val)
 {
 	unsigned int sc_reg;
 

--------------020909070609070202090308--
