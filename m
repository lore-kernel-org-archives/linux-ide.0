From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 67/73] sata_sil: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:22:44 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142022390.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:60052 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756369AbZCNTWq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:22:46 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZRU-000Fmw-Kj
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:22:44 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/sata_sil.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index d009160..e67ce8e 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -200,8 +200,8 @@ static const struct ata_port_info sil_port_info[] =3D=
 {
 	/* sil_3112 */
 	{
 		.flags		=3D SIL_DFL_PORT_FLAGS | SIL_FLAG_MOD15WRITE,
-		.pio_mask	=3D 0x1f,			/* pio0-4 */
-		.mwdma_mask	=3D 0x07,			/* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA5,
 		.port_ops	=3D &sil_ops,
 	},
@@ -209,24 +209,24 @@ static const struct ata_port_info sil_port_info[]=
 =3D {
 	{
 		.flags		=3D SIL_DFL_PORT_FLAGS | SIL_FLAG_MOD15WRITE |
 				  SIL_FLAG_NO_SATA_IRQ,
-		.pio_mask	=3D 0x1f,			/* pio0-4 */
-		.mwdma_mask	=3D 0x07,			/* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA5,
 		.port_ops	=3D &sil_ops,
 	},
 	/* sil_3512 */
 	{
 		.flags		=3D SIL_DFL_PORT_FLAGS | SIL_FLAG_RERR_ON_DMA_ACT,
-		.pio_mask	=3D 0x1f,			/* pio0-4 */
-		.mwdma_mask	=3D 0x07,			/* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA5,
 		.port_ops	=3D &sil_ops,
 	},
 	/* sil_3114 */
 	{
 		.flags		=3D SIL_DFL_PORT_FLAGS | SIL_FLAG_RERR_ON_DMA_ACT,
-		.pio_mask	=3D 0x1f,			/* pio0-4 */
-		.mwdma_mask	=3D 0x07,			/* mwdma0-2 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA5,
 		.port_ops	=3D &sil_ops,
 	},
--=20
1.5.6.3

