From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA Problem: port is slow to respond
Date: Thu, 01 Mar 2007 17:40:54 +0900
Message-ID: <45E69196.4070409@gmail.com>
References: <200702161050.51523.sigmund.lkml@synflood.homelinux.org> <45E4436B.9090102@gmail.com> <45E4A217.7090909@synflood.homelinux.org> <45E51B0A.5040605@gmail.com> <45E68B24.5030006@synflood.homelinux.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000200020001070201000500"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:14172 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933115AbXCAIk4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Mar 2007 03:40:56 -0500
Received: by nz-out-0506.google.com with SMTP id s1so424207nze
        for <linux-ide@vger.kernel.org>; Thu, 01 Mar 2007 00:40:55 -0800 (PST)
In-Reply-To: <45E68B24.5030006@synflood.homelinux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sigmund Scheinbar <sigmund.debian@synflood.homelinux.org>
Cc: Sigmund Scheinbar <sigmund.lkml@synflood.homelinux.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000200020001070201000500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Sigmund Scheinbar wrote:
> Tejun Heo wrote:
>> Please apply the attached patch over 2.6.20.1 and report how it works.
> 
> I'm afraid that something went wrong while patching:

Sorry, it was generated against the wrong tree.  Regenerated patch attached.

> BTW.: I'm just curious, what's the "purpose" of this patch, it looks to
> me like it is just going to ignore the problem? Or do you think that the
> hardware is faulty?

ATAPI devices use error conditions regularly to report all sorts of
things including media not present.  In some variants of ahci's, this
sets seemingly unrelated error bits - JMBs set interface error and
sb600s seem to set internal error.  These errors when interpreted
literally require device reset to recover from thus ATAPI devices never
get through device ready check.  So, the patch makes ahci driver
suppress those spurious errors.

-- 
tejun

--------------000200020001070201000500
Content-Type: text/x-patch;
 name="sb600-ign-serr-internal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb600-ign-serr-internal.patch"

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 48616c6..17c6630 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -82,6 +82,7 @@ enum {
 	board_ahci_pi		= 1,
 	board_ahci_vt8251	= 2,
 	board_ahci_ign_iferr	= 3,
+	board_ahci_ign_interr	= 4,
 
 	/* global controller registers */
 	HOST_CAP		= 0x00, /* host capabilities */
@@ -173,6 +174,7 @@ enum {
 	AHCI_FLAG_NO_NCQ		= (1 << 24),
 	AHCI_FLAG_IGN_IRQ_IF_ERR	= (1 << 25), /* ignore IRQ_IF_ERR */
 	AHCI_FLAG_HONOR_PI		= (1 << 26), /* honor PORTS_IMPL */
+	AHCI_FLAG_IGN_SERR_INTERNAL	= (1 << 27), /* ignore SERR_INTERNAL */
 };
 
 struct ahci_cmd_hdr {
@@ -357,6 +359,17 @@ static const struct ata_port_info ahci_port_info[] = {
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
@@ -396,8 +409,8 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(JMICRON, 0x2366), board_ahci_ign_iferr }, /* JMB366 */
 
 	/* ATI */
-	{ PCI_VDEVICE(ATI, 0x4380), board_ahci }, /* ATI SB600 non-raid */
-	{ PCI_VDEVICE(ATI, 0x4381), board_ahci }, /* ATI SB600 raid */
+	{ PCI_VDEVICE(ATI, 0x4380), board_ahci_ign_interr }, /* SB600 non-raid */
+	{ PCI_VDEVICE(ATI, 0x4381), board_ahci_ign_interr }, /* SB600 raid */
 
 	/* VIA */
 	{ PCI_VDEVICE(VIA, 0x3349), board_ahci_vt8251 }, /* VIA VT8251 */
@@ -462,9 +475,10 @@ static inline void __iomem *ahci_port_base (void __iomem *base, unsigned int por
 	return (void __iomem *) ahci_port_base_ul((unsigned long)base, port);
 }
 
-static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
+static u32 ahci_scr_read(struct ata_port *ap, unsigned int sc_reg_in)
 {
 	unsigned int sc_reg;
+	u32 serr;
 
 	switch (sc_reg_in) {
 	case SCR_STATUS:	sc_reg = 0; break;
@@ -475,12 +489,13 @@ static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
 		return 0xffffffffU;
 	}
 
-	return readl((void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
+	serr = readl((void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
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
 

--------------000200020001070201000500--
