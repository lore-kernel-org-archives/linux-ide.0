From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 07/73] pata_ali: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:11:40 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142011340.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:60807 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbZCNTLm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:11:42 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZGm-000FY5-Fx
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:11:40 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_ali.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index eb99dbe..751b7ea 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -492,53 +492,53 @@ static int ali_init_one(struct pci_dev *pdev, con=
st struct pci_device_id *id)
 {
 	static const struct ata_port_info info_early =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
+		.pio_mask =3D ATA_PIO4,
 		.port_ops =3D &ali_early_port_ops
 	};
 	/* Revision 0x20 added DMA */
 	static const struct ata_port_info info_20 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.port_ops =3D &ali_20_port_ops
 	};
 	/* Revision 0x20 with support logic added UDMA */
 	static const struct ata_port_info info_20_udma =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
-		.udma_mask =3D 0x07,	/* UDMA33 */
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
+		.udma_mask =3D ATA_UDMA2,
 		.port_ops =3D &ali_20_port_ops
 	};
 	/* Revision 0xC2 adds UDMA66 */
 	static const struct ata_port_info info_c2 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA4,
 		.port_ops =3D &ali_c2_port_ops
 	};
 	/* Revision 0xC3 is UDMA66 for now */
 	static const struct ata_port_info info_c3 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA4,
 		.port_ops =3D &ali_c2_port_ops
 	};
 	/* Revision 0xC4 is UDMA100 */
 	static const struct ata_port_info info_c4 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_LBA48,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA5,
 		.port_ops =3D &ali_c4_port_ops
 	};
 	/* Revision 0xC5 is UDMA133 with LBA48 DMA */
 	static const struct ata_port_info info_c5 =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
-		.pio_mask =3D 0x1f,
-		.mwdma_mask =3D 0x07,
+		.pio_mask =3D ATA_PIO4,
+		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA6,
 		.port_ops =3D &ali_c5_port_ops
 	};
--=20
1.5.6.3

