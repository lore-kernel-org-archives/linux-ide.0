From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 66/73] sata_sil24: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:22:36 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142022300.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:60031 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756439AbZCNTWj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:22:39 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZRM-000Fmt-K6
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:22:36 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/sata_sil24.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 2590c22..0d8990d 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -429,25 +429,25 @@ static const struct ata_port_info sil24_port_info=
[] =3D {
 	{
 		.flags		=3D SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(4) |
 				  SIL24_FLAG_PCIX_IRQ_WOC,
-		.pio_mask	=3D 0x1f,			/* pio0-4 */
-		.mwdma_mask	=3D 0x07,			/* mwdma0-2 */
-		.udma_mask	=3D ATA_UDMA5,		/* udma0-5 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
+		.udma_mask	=3D ATA_UDMA5,
 		.port_ops	=3D &sil24_ops,
 	},
 	/* sil_3132 */
 	{
 		.flags		=3D SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(2),
-		.pio_mask	=3D 0x1f,			/* pio0-4 */
-		.mwdma_mask	=3D 0x07,			/* mwdma0-2 */
-		.udma_mask	=3D ATA_UDMA5,		/* udma0-5 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
+		.udma_mask	=3D ATA_UDMA5,
 		.port_ops	=3D &sil24_ops,
 	},
 	/* sil_3131/sil_3531 */
 	{
 		.flags		=3D SIL24_COMMON_FLAGS | SIL24_NPORTS2FLAG(1),
-		.pio_mask	=3D 0x1f,			/* pio0-4 */
-		.mwdma_mask	=3D 0x07,			/* mwdma0-2 */
-		.udma_mask	=3D ATA_UDMA5,		/* udma0-5 */
+		.pio_mask	=3D ATA_PIO4,
+		.mwdma_mask	=3D ATA_MWDMA2,
+		.udma_mask	=3D ATA_UDMA5,
 		.port_ops	=3D &sil24_ops,
 	},
 };
--=20
1.5.6.3

