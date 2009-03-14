From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 69/73] sata_svw: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:23:39 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142023230.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:60178 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756021AbZCNTXm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:23:42 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZSO-000Fnw-06
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:23:40 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/sata_svw.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 609d147..7257f2d 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -361,8 +361,8 @@ static const struct ata_port_info k2_port_info[] =3D=
 {
 	{
 		.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | K2_FLAG_NO_ATAPI_DMA,
-		.pio_mask	=3D 0x1f,
-		.mwdma_mask	=3D 0x07,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &k2_sata_ops,
 	},
@@ -371,8 +371,8 @@ static const struct ata_port_info k2_port_info[] =3D=
 {
 		.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | K2_FLAG_NO_ATAPI_DMA |
 				  K2_FLAG_SATA_8_PORTS,
-		.pio_mask	=3D 0x1f,
-		.mwdma_mask	=3D 0x07,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &k2_sata_ops,
 	},
@@ -380,8 +380,8 @@ static const struct ata_port_info k2_port_info[] =3D=
 {
 	{
 		.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | K2_FLAG_BAR_POS_3,
-		.pio_mask	=3D 0x1f,
-		.mwdma_mask	=3D 0x07,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &k2_sata_ops,
 	},
@@ -389,8 +389,8 @@ static const struct ata_port_info k2_port_info[] =3D=
 {
 	{
 		.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO,
-		.pio_mask	=3D 0x1f,
-		.mwdma_mask	=3D 0x07,
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &k2_sata_ops,
 	},
--=20
1.5.6.3

