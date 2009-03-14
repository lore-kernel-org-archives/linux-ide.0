From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 52/73] pata_serverworks: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 20:20:41 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142020310.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:62727 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755830AbZCNTUn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:20:43 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZPV-000FiJ-EW
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:20:41 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 drivers/ata/pata_serverworks.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverwo=
rks.c
index 8d2fd9d..beaed12 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -398,26 +398,26 @@ static int serverworks_init_one(struct pci_dev *p=
dev, const struct pci_device_id
 	static const struct ata_port_info info[4] =3D {
 		{ /* OSB4 */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			.udma_mask =3D ATA_UDMA2,
 			.port_ops =3D &serverworks_osb4_port_ops
 		}, { /* OSB4 no UDMA */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
-			.udma_mask =3D 0x00,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
+			/* No UDMA */
 			.port_ops =3D &serverworks_osb4_port_ops
 		}, { /* CSB5 */
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.udma_mask =3D ATA_UDMA4,
 			.port_ops =3D &serverworks_csb_port_ops
 		}, { /* CSB5 - later revisions*/
 			.flags =3D ATA_FLAG_SLAVE_POSS,
-			.pio_mask =3D 0x1f,
-			.mwdma_mask =3D 0x07,
+			.pio_mask =3D ATA_PIO4,
+			.mwdma_mask =3D ATA_MWDMA2,
 			.udma_mask =3D ATA_UDMA5,
 			.port_ops =3D &serverworks_csb_port_ops
 		}
--=20
1.5.6.3

