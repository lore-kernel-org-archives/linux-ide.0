From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 14/73] pata_cmd64x: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:13:18 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142013130.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:61069 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753841AbZCNTNV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:13:21 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZIN-000FZD-0U
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:13:19 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_cmd64x.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index 3167d8f..f98dffe 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -299,40 +299,40 @@ static int cmd64x_init_one(struct pci_dev *pdev, =
const struct pci_device_id *id)
 	static const struct ata_port_info cmd_info[6] =3D {
 		{	/* CMD 643 - no UDMA */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.port_ops =3D &cmd64x_port_ops
 		},
 		{	/* CMD 646 with broken UDMA */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.port_ops =3D &cmd64x_port_ops
 		},
 		{	/* CMD 646 with working UDMA */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.udma_mask =3D ATA_UDMA2,
 			.port_ops =3D &cmd64x_port_ops
 		},
 		{	/* CMD 646 rev 1  */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.port_ops =3D &cmd646r1_port_ops
 		},
 		{	/* CMD 648 */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.udma_mask =3D ATA_UDMA4,
 			.port_ops =3D &cmd648_port_ops
 		},
 		{	/* CMD 649 */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.udma_mask =3D ATA_UDMA5,
 			.port_ops =3D &cmd648_port_ops
 		}
--=20
1.5.6.3

