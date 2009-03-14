From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 08/73] pata_amd: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:11:50 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142011440.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:60863 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753450AbZCNTLw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:11:52 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZGw-000FY8-97
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:11:50 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_amd.c |   70 ++++++++++++++++++++++++----------------=
--------
 1 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 115b1cd..33a74f1 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -455,74 +455,74 @@ static void amd_clear_fifo(struct pci_dev *pdev)
 static int amd_init_one(struct pci_dev *pdev, const struct pci_device_=
id *id)
 {
 	static const struct ata_port_info info[10] =3D {
-		{	/* 0: AMD 7401 */
+		{	/* 0: AMD 7401 - no swdma */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,	/* No SWDMA */
-			.udma_mask =3D 0x07,	/* UDMA 33 */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA2,
 			.port_ops =3D &amd33_port_ops
 		},
 		{	/* 1: Early AMD7409 - no swdma */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D ATA_UDMA4,	/* UDMA 66 */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA4,
 			.port_ops =3D &amd66_port_ops
 		},
-		{	/* 2: AMD 7409, no swdma errata */
+		{	/* 2: AMD 7409 */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D ATA_UDMA4,	/* UDMA 66 */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA4,
 			.port_ops =3D &amd66_port_ops
 		},
 		{	/* 3: AMD 7411 */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D ATA_UDMA5,	/* UDMA 100 */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA5,
 			.port_ops =3D &amd100_port_ops
 		},
 		{	/* 4: AMD 7441 */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D ATA_UDMA5,	/* UDMA 100 */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA5,
 			.port_ops =3D &amd100_port_ops
 		},
-		{	/* 5: AMD 8111*/
+		{	/* 5: AMD 8111 - no swdma */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D ATA_UDMA6,	/* UDMA 133, no swdma */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA6,
 			.port_ops =3D &amd133_port_ops
 		},
-		{	/* 6: AMD 8111 UDMA 100 (Serenade) */
+		{	/* 6: AMD 8111 UDMA 100 (Serenade) - no swdma */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D ATA_UDMA5,	/* UDMA 100, no swdma */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA5,
 			.port_ops =3D &amd133_port_ops
 		},
 		{	/* 7: Nvidia Nforce */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D ATA_UDMA5,	/* UDMA 100 */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA5,
 			.port_ops =3D &nv100_port_ops
 		},
-		{	/* 8: Nvidia Nforce2 and later */
+		{	/* 8: Nvidia Nforce2 and later - no swdma */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D ATA_UDMA6,	/* UDMA 133, no swdma */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA6,
 			.port_ops =3D &nv133_port_ops
 		},
 		{	/* 9: AMD CS5536 (Geode companion) */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D ATA_UDMA5,	/* UDMA 100 */
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA5,
 			.port_ops =3D &amd100_port_ops
 		}
 	};
--=20
1.5.6.3

