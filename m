From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 21/20] ata_piix: add new PIIX_FLAG_* flags
Date: Tue, 8 Feb 2011 17:03:19 +0100
Message-ID: <201102081703.20447.bzolnier@gmail.com>
References: <201102081652.36752.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52873 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab1BHQDn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 11:03:43 -0500
In-Reply-To: <201102081652.36752.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Turn open-coded checks in piix_set_timings() into PIIX_FLAG_* flags
per suggestion from Alan Cox.

Suggested-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
- On top of https://lkml.org/lkml/2011/2/8/97 patchset.
- Get the reverse logic correct this time.

 drivers/ata/ata_piix.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Index: b/drivers/ata/ata_piix.c
===================================================================
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -133,6 +133,8 @@ enum {
 
 	PIIX_FLAG_CHECKINTR	= (1 << 28), /* make sure PCI INTx enabled */
 	PIIX_FLAG_SIDPR		= (1 << 29), /* SATA idx/data pair regs */
+	PIIX_FLAG_NO_SITRE	= (1 << 30), /* no SITRE register */
+	PIIX_FLAG_RADISYS	= (1 << 31), /* host is Radisys R82600 */
 
 	PIIX_PATA_FLAGS		= ATA_FLAG_SLAVE_POSS,
 	PIIX_SATA_FLAGS		= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,
@@ -698,7 +700,7 @@ static struct ata_port_info piix_port_in
 
 	[oldpiix_pata] =
 	{
-		.flags		= PIIX_PATA_FLAGS,
+		.flags		= PIIX_PATA_FLAGS | PIIX_FLAG_NO_SITRE,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA12_ONLY,
 		.port_ops	= &oldpiix_pata_ops,
@@ -706,7 +708,8 @@ static struct ata_port_info piix_port_in
 
 	[radisys_pata] =
 	{
-		.flags		= PIIX_PATA_FLAGS,
+		.flags		= PIIX_PATA_FLAGS | PIIX_FLAG_NO_SITRE |
+				  PIIX_FLAG_RADISYS,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA12_ONLY,
 		.udma_mask	= ATA_UDMA24_ONLY,
@@ -859,10 +862,8 @@ static void piix_set_timings(struct ata_
 	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
 	unsigned long flags;
 	unsigned int is_slave	= (adev->devno != 0);
-	unsigned int is_radisys	= (dev->vendor == PCI_VENDOR_ID_RADISYS &&
-				   dev->device == 0x8201);
-	unsigned int has_sitre	= (dev->vendor != PCI_VENDOR_ID_INTEL ||
-				   dev->device != 0x1230) && !is_radisys;
+	unsigned int is_radisys	= (ap->flags & PIIX_FLAG_RADISYS) ? 1 : 0;
+	unsigned int has_sitre	= (ap->flags & PIIX_FLAG_NO_SITRE) ? 0 : 1;
 	unsigned int master_port= ap->port_no ? 0x42 : 0x40;
 	unsigned int slave_port	= 0x44;
 	u16 master_data;
