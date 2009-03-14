From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 04/73] ahci: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:11:00 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142010490.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:60672 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753056AbZCNTLE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:11:04 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZG8-000FVF-Hj
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:11:00 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/ahci.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 66e012c..3e66734 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -404,7 +404,7 @@ static const struct ata_port_info ahci_port_info[] =
=3D {
 	/* board_ahci */
 	{
 		.flags		=3D AHCI_FLAG_COMMON,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &ahci_ops,
 	},
@@ -412,7 +412,7 @@ static const struct ata_port_info ahci_port_info[] =
=3D {
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ | AHCI_HFLAG_NO_PMP),
 		.flags		=3D AHCI_FLAG_COMMON,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &ahci_vt8251_ops,
 	},
@@ -420,7 +420,7 @@ static const struct ata_port_info ahci_port_info[] =
=3D {
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR),
 		.flags		=3D AHCI_FLAG_COMMON,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &ahci_ops,
 	},
@@ -430,7 +430,7 @@ static const struct ata_port_info ahci_port_info[] =
=3D {
 				 AHCI_HFLAG_32BIT_ONLY | AHCI_HFLAG_NO_MSI |
 				 AHCI_HFLAG_SECT255),
 		.flags		=3D AHCI_FLAG_COMMON,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &ahci_sb600_ops,
 	},
@@ -440,7 +440,7 @@ static const struct ata_port_info ahci_port_info[] =
=3D {
 				 AHCI_HFLAG_MV_PATA | AHCI_HFLAG_NO_PMP),
 		.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &ahci_ops,
 	},
@@ -448,7 +448,7 @@ static const struct ata_port_info ahci_port_info[] =
=3D {
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
 		.flags		=3D AHCI_FLAG_COMMON,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &ahci_sb600_ops,
 	},
@@ -456,7 +456,7 @@ static const struct ata_port_info ahci_port_info[] =
=3D {
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_YES_NCQ),
 		.flags		=3D AHCI_FLAG_COMMON,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &ahci_ops,
 	},
@@ -464,7 +464,7 @@ static const struct ata_port_info ahci_port_info[] =
=3D {
 	{
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_PMP),
 		.flags		=3D AHCI_FLAG_COMMON,
-		.pio_mask	=3D 0x1f, /* pio0-4 */
+		.pio_mask	=3D ATA_PIO4,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &ahci_ops,
 	},
--=20
1.5.6.3

